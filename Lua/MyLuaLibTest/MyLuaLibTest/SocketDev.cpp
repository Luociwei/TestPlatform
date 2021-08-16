/*
 *  SocketDev.cpp
 *  SocketDev
 *
 *  Created by Ryan on 11/4/15.
 *  Copyright © 2015 ___Intelligent Automation___. All rights reserved.
 *
 */

#include <iostream>
#include "SocketDev.h"

#include "tolua++.h"

#define VERSION_NUM     "2019 11 20 US dry run for J5XX"

TOLUA_API int  tolua_tClassLua_open (lua_State* tolua_S);


int luaopen_libTest(lua_State * state)
{
    printf("*****************************************\r\n");
    printf("       Load SocketDUT Library,v%s\r\n",VERSION_NUM);
    printf("*****************************************\r\n");
    
    
    tolua_tClassLua_open(state);
    
    return 0;
}
