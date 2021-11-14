//
//  tClass.cpp
//  MyLuaLibTest
//
//  Created by ciwei luo on 2021/1/31.
//  Copyright © 2021 Louis.Luo. All rights reserved.
//

#include "RPC.h"


RPC::RPC()
{
    
}

int RPC::Connect()
{
    create_fixture_controller
    return 0;
}

int RPC::FixtureWrite()
{
    return 0;
}
const char *  RPC::FixtureRead()
{
    NSString *strReturn = @"111";
    return [strReturn UTF8String];
}


int RPC::DutWrite()
{
    return 0;
}
const char *  RPC::DutRead()
{
    NSString *strReturn = @"111";
    return [strReturn UTF8String];
    
}


int RPC::Get()
{
    return a;
}

int RPC::Get1()
{
    return 10;
}


