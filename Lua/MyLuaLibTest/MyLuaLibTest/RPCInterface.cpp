/*
 *  SocketDev.cpp
 *  SocketDev
 *
 *  Created by Ryan on 11/4/15.
 *  Copyright © 2015 ___Intelligent Automation___. All rights reserved.
 *
 */

#include <iostream>
#include "RPCInterface.h"

#include "tolua++.h"

#define VERSION_NUM     "2021_09_02 for DFU/SOC"

TOLUA_API int  tolua_RPCLua_open (lua_State* tolua_S);


int luaopen_LibRPC(lua_State * state)
{
    printf("*****************************************\r\n");
    printf("       Load libDFUFixture.dylib,v%s\r\n",VERSION_NUM);
    printf("*****************************************\r\n");
    
    
    tolua_RPCLua_open(state);
    
    return 0;
}
