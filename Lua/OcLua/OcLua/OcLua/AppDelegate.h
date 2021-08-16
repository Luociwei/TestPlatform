//
//  WindowVC.h
//  OcLua
//
//  Created by Louis Luo on 2020/3/31.
//  Copyright © 2020 Suncode. All rights reserved.
//


#import <Cocoa/Cocoa.h>
#import "LuaManager.h"
@interface AppDelegate : NSObject <NSApplicationDelegate>
@property (nonatomic) lua_State *luaState;     //定义一个lua_State结构

@end

