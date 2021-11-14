//
//  tClass.hpp
//  MyLuaLibTest
//
//  Created by ciwei luo on 2021/1/31.
//  Copyright © 2021 Louis.Luo. All rights reserved.
//

#ifndef RPC_hpp
#define RPC_hpp

#include <stdio.h>
#include <Foundation/Foundation.h>

class RPC
{
public:
    
    RPC();
    
    int Connect();
    
    int FixtureWrite();

    const char *  FixtureRead();
    
    int DutWrite();

    const char *  DutRead();
 

    int a;
    int Get();
    int Get1();
};


#endif /* tClass_hpp */
