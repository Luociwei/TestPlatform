//
//  AppDelegate.h
//  Python_objc
//
//  Created by RyanGao on 2020/6/11.
//  Copyright © 2020 RyanGao. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Python/Python.h>
#import <Foundation/Foundation.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    PyObject *myModule;
}


@end

