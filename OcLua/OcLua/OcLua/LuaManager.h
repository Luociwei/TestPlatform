//
//  LuaManager.h
//  OcLua
//
//  Created by ciwei luo on 2021/1/23.
//  Copyright © 2021 macdev. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "lua.h"
#include "lualib.h"
#include "lauxlib.h"
NS_ASSUME_NONNULL_BEGIN

@interface LuaManager : NSObject
+ (LuaManager *)cw_luaScriptWithContentsOfFile:(NSString *)path;
- (id)cw_callFunction:(NSString *)aName withArguments:(id)firstObj, ... NS_REQUIRES_NIL_TERMINATION;
-(NSString *)cw_getVauleWithTableName:(NSString *)variableName key:(NSString *)key;
-(NSString *)cw_getVauleWithVariableName:(NSString *)variableName;
-(void)cw_luaClose;
@end

NS_ASSUME_NONNULL_END
