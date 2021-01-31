//
//  LuaManager.m
//  OcLua
//
//  Created by ciwei luo on 2021/1/23.
//  Copyright © 2021 macdev. All rights reserved.
//

#import "LuaManager.h"


@interface LuaManager()
    //定义一个lua_State结构
@property (nonatomic) NSString *packageCpath;
@property (nonatomic) NSString *scriptPath;
@property (nonatomic) NSString *packagePath;
@property (nonatomic) lua_State *L;
@end



@implementation LuaManager{
//    lua_State *L;

}


- (id)init {
    if(self = [super init]) {
        _L = luaL_newstate();
        

        if(_L == NULL) {
            printf("error initing lua!\n");
            return nil;
        }
        luaL_openlibs(_L);
        lua_settop(_L, 0);
    }

    return self;
}

-(void)cw_luaClose{
    lua_close(_L);
}

- (void)dealloc {
  
    lua_close(_L);
}
+ (LuaManager *)cw_luaScriptWithContentsOfFile:(NSString *)path {
    LuaManager *script = [[LuaManager alloc] init];
    
    script.scriptPath = path;
    script.packagePath = [NSString stringWithFormat:@"%@/?.lua", [[NSBundle mainBundle] resourcePath]];
    script.packageCpath = [NSString stringWithFormat:@"%@/?.so", [[NSBundle mainBundle] resourcePath]];
    [script run];
    return script;
}
- (void)run {
//    luaL_openlibs(_L);
    if (_L == nil || self.scriptPath == nil) {
        NSLog(@"cannot run Lua code.");
        return;
    }
//    luaL_openlibs(_L);
    // set package.path
    lua_getglobal(_L, "package");
    lua_getfield(_L, -1, "path"); // top of the stack
    const char *path = lua_tostring(_L, -1);
    
    //NSMutableString *newPath = [NSMutableString stringWithCString:path encoding:NSUTF8StringEncoding];
    //[newPath appendFormat:@";%@", packagePath];
    NSString *newPath = [NSString stringWithFormat:@"%@;", _packagePath];
    
    lua_pop(_L, 1);
    lua_pushstring(_L, [newPath cStringUsingEncoding:NSUTF8StringEncoding]);
    lua_setfield(_L, -2, "path");
    lua_pop(_L, 1);
    
    // set package.cpath for native modules
    lua_getglobal(_L, "package");
    lua_getfield(_L, -1, "cpath"); // top of the stack
    path = lua_tostring(_L, -1);
    
    newPath = [NSString stringWithFormat:@"%@;", _packageCpath];
    
    lua_pop(_L, 1);
    lua_pushstring(_L, [newPath cStringUsingEncoding:NSUTF8StringEncoding]);
    lua_setfield(_L, -2, "cpath");
    lua_pop(_L, 1);
    
    // run the script
    if(luaL_dofile(_L, [_scriptPath cStringUsingEncoding:NSUTF8StringEncoding]) == 1) {
        NSLog(@"error running lua script: %@", _scriptPath);
    }
}

- (void)pushObjectToLua:(id)arg withArrayIndex:(NSInteger)index withTableKey:(NSString *)key {
    // for tables, push the index/key first
    if(index > -1) {
        lua_pushnumber(_L, index);
    } else if(key) {
        lua_pushstring(_L, [key cStringUsingEncoding:NSUTF8StringEncoding]);
    }
    
    // second, push the value
    if([arg isKindOfClass:[NSString class]]) {
        lua_pushstring(_L, [arg cStringUsingEncoding:NSUTF8StringEncoding]);
    } else if([arg isKindOfClass:[NSArray class]]) {
        //lua_newtable(L);
        lua_createtable(_L, (int) [arg count], 0);
        int count = 1;
        
        for(id obj in arg) {
            [self pushObjectToLua:obj withArrayIndex:count++ withTableKey:nil];
        }
    } else if([arg isKindOfClass:[NSNumber class]]) {
        lua_pushnumber(_L, [arg floatValue]);
    } else {
        lua_pushnil(_L);
    }
    
    if(index > -1 || key) {
        // finally reference the table
        lua_rawset(_L, -3);
    }
}




- (id)popObjectFromLua {
    if(lua_isstring(_L, -1)) {
        return [NSString stringWithCString:lua_tostring(_L, -1) encoding:NSUTF8StringEncoding];
    } else if(lua_istable(_L, -1)) {
        BOOL hasArray = NO;
        BOOL hasDict = NO;
        NSMutableArray *array;
        NSMutableDictionary *dict;
        
        lua_pushnil(_L);
        //const char *key, *value;
        
        id value;
        
        while(lua_next(_L, -2)) {
            value = [self popObjectFromLua];
            
            lua_pop(_L, 1);
            
            if(lua_isnumber(_L, -1)) {
                // array index
                if(!array) {
                    array = [NSMutableArray array];
                    hasArray = YES;
                }
                
                int index = (int) lua_tointeger(_L, -1);
                
                [array addObject:value];
            } else if(lua_isstring(_L, -1)) {
                if(!dict) {
                    dict = [NSMutableDictionary dictionary];
                    hasDict = YES;
                }
                
                [dict setObject:value forKey:[NSString stringWithCString:lua_tostring(_L, -1) encoding:NSUTF8StringEncoding]];
            }
        }
        
        if(hasArray && hasDict) {
            // combine array items into dictionary
            for(int i = (int) [array count] - 1; i > -1; i--) {
                [dict setObject:[array objectAtIndex:i] forKey:[NSString stringWithFormat:@"%d", i]];
            }
            
            return dict;
        } else if(hasArray) {
            return array;
        } else if(hasDict) {
            return dict;
        } else {
            return nil;
        }
    } else if(lua_isboolean(_L, -1)) {
        return lua_toboolean(_L, -1) ? @"true" : @"false";
    } else if(lua_isnumber(_L, -1)) {
        return [NSNumber numberWithFloat:lua_tonumber(_L, -1)];
    } else if(lua_isnoneornil(_L, -1)) {
        lua_pop(_L, -1);
        
        return nil;
    } else {
        return nil;
    }
}

- (id)cw_callFunction:(NSString *)aName withArguments:(id)firstObj, ... {
    if (_L == nil || self.scriptPath == nil) {
        NSLog(@"cannot run Lua code.");
        return nil;
    }
    @synchronized(self) {
        va_list args;
        va_start(args, firstObj);
        int count = 0;
        
        lua_getglobal(_L, [aName cStringUsingEncoding:NSUTF8StringEncoding]);
        
        for(id arg = firstObj; arg != nil; arg = va_arg(args, id)) {
            count++;
            [self pushObjectToLua:arg withArrayIndex:-1 withTableKey:nil];
        }
        
        va_end(args);
        
        int err;
        
        if((err = lua_pcall(_L, count, 1, 0)) != 0) {
            switch(err) {
                case LUA_ERRRUN:
                    NSLog(@"Lua: runtime error");
                    break;
                    
                case LUA_ERRMEM:
                    NSLog(@"Lua: memory allocation error");
                    break;
                    
                case LUA_ERRERR:
                    NSLog(@"Lua: error handler error");
                    break;
                    
                default:
                    NSLog(@"Lua: unknown error");
                    return nil;
            }
            
            NSLog(@"Lua: %s", lua_tostring(_L, -1));
            return nil;
        }
        
        return [self popObjectFromLua];
    }
}


//-(void)setLuaVaule:(NSNumber *)vaule variableName:(NSString *)variableName{
//    if (_L == nil || self.scriptPath == nil) {
//        NSLog(@"cannot run Lua code.");
//        return;
//    }
//    lua_pushinteger(_L, vaule.intValue);
//    lua_setglobal(_L, variableName.UTF8String);
//}

-(NSString *)cw_getVauleWithVariableName:(NSString *)variableName{
    if (_L == nil || self.scriptPath == nil) {
        NSLog(@"cannot run Lua code.");
        return @"";
    }
    
    
    lua_getglobal(_L,variableName.UTF8String);
    const char * charStr =lua_tostring(_L,-1);
    NSString *ocStr = [NSString stringWithCString:charStr encoding:NSUTF8StringEncoding];
    NSLog(@"%@",ocStr);
    return ocStr;
    
    
}


-(NSString *)cw_getVauleWithTableName:(NSString *)variableName key:(NSString *)key{
    if (_L == nil || self.scriptPath == nil) {
        NSLog(@"cannot run Lua code.");
        return @"";
    }
    
    lua_getglobal(_L,variableName.UTF8String);
    lua_getfield(_L,-1,key.UTF8String);
    const char * charStr =lua_tostring(_L,-1);
    NSString *ocStr = [NSString stringWithCString:charStr encoding:NSUTF8StringEncoding];
    NSLog(@"%@",ocStr);
    return ocStr;
    
    
}


@end
