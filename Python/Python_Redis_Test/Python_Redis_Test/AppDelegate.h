//
//  AppDelegate.h
//  Python_Redis_Test
//
//  Created by RyanGao on 2020/6/23.
//  Copyright © 2020 RyanGao. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "StartUp.h"
#import "RedisInterface.hpp"
#import "Client.h"



@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    RedisInterface *myRedis;
    StartUp * startPython;
    Client *cpkClient;
    Client *correlationClient;
    Client *calculateClient;
}


@end

