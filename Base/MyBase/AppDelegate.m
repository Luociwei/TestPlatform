//
//  AppDelegate.m
//  SC_Eowyn
//
//  Created by ciwei luo on 2020/3/31.
//  Copyright © 2020 ciwei luo. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
-(void)cw_createFile:(NSString *)filePath isDirectory:(BOOL)isDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) {
        if (isDirectory) {
            [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        }else{
            [fileManager createFileAtPath:filePath contents:nil attributes:nil];
        }
    }
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(windowWillClose:)
                                                 name:NSWindowWillCloseNotification
                                               object:nil];
    
    NSString *filePath = @"/Users/ciweiluo/Desktop/Archive/test/";
    [self cw_createFile:filePath isDirectory:YES];
    
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)windowWillClose:(NSNotification *)notification {
    [NSApp terminate:nil];
}

@end
