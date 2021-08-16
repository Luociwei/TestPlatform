/*
 *  SocketDev.hpp
 *  SocketDev
 *
 *  Created by Ryan on 11/4/15.
 *  Copyright © 2015  Automation___. All rights reserved.
 *
 */


#ifndef __Global__Global__
#define __Global__Global__
#include "lua.hpp"

#define DL_EXPORT __attribute__((visibility("default")))

#include <stdio.h>

DL_EXPORT extern "C" int luaopen_libTest(lua_State * state);

#endif /* defined(__Global__Global__) */
