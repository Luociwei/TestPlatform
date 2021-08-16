//
//  WindowVC.h
//  MixUpgrade
//
//  Created by Louis Luo on 2020/3/31.
//  Copyright © 2020 Suncode. All rights reserved.
//

#import <CwGeneralManagerFrameWork/FileManager.h>
#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
//    NSString *base64String=[FileManager cw_readFromFile:@"/Users/ciweiluo/Desktop/Suncode/log_2.txt"];
// 
//    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
//    
//    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
