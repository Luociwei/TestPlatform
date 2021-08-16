//
//  WindowVC.h
//  OcLua
//
//  Created by Louis Luo on 2020/3/31.
//  Copyright © 2020 Suncode. All rights reserved.
//

//#import <CwGeneralManagerFrameWork/FileManager.h>
#import "AppDelegate.h"
#import "LuaManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
//    [FileManager cw_readFromFile:@""];
    [self luaDemo];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}
-(void)luaDemo{
    
    LuaManager *script = [LuaManager cw_luaScriptWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"luaTestDemo" ofType:@"lua"]];
    
    
    NSDictionary *table1= [script cw_callFunction:@"hello" withArguments:@"world", nil];
    
    // call a function that we know returns mixed results
    id table = [script cw_callFunction:@"test" withArguments:@"foo", [NSNumber numberWithInt:1337], @"baz", nil];
    if ([table isKindOfClass:NSArray.class]) {
        for(id item in table) {
            
            NSLog(@"%@", item);
        }
    }else{
        for(id item in table) {
            
            NSLog(@"%@ -> %@", item, [table objectForKey:item]);
        }
    }
    
    //    NSString *s = [script cw_getVauleWithVariableName:@"intVal"];
    
    
    //    NSString *s1 = [script cw_getVauleWithTableName:@"tbl" key:@"name"];
    [script cw_luaClose];
    
    //
    
}

@end
