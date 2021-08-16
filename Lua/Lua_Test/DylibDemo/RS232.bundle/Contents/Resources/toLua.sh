#!/bin/sh

#  toLua.sh
#  FCTDemo
#
#  Created by Louis on 13-8-14.
#  Copyright (c) 2013年 Louis. All rights reserved.

#tolua=/Users/ryan/Project/LUA/tolua++-1.0.93/bin/tolua++
tolua=/usr/local/lib/tolua++

$tolua -o CRS232_lua.mm CRS232_lua.pkg

$tolua -o CRS232_Object.mm CRS232_Object.pkg
