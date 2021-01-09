//
//  WindowVC.m
//  SC_Eowyn
//
//  Created by ciwei luo on 2020/3/31.
//  Copyright © 2020 ciwei luo. All rights reserved.
//

#import "WindowVC.h"

//#import <DvpStimPanelFrameWork/Test4VC.h>

@interface WindowVC ()

@end

@implementation WindowVC

- (void)windowDidLoad {
    [super windowDidLoad];
    
//        UIViewController *vc = [[UIViewController alloc]initWithNibName:@"Frameworks/CustomFrameWork.framework/ActivityViewController" bundle:nil];
    
//    NSBundle *bundle = [NSBundle bundleForClass:[Test4VC class]];
//
//    Test4VC *frameworkVC = [[Test4VC alloc] initWithNibName:@"Test4VC" bundle:bundle];

    NTCViewController *frameworkVC = [NTCViewController allocInit];
//
    self.window.contentViewController = frameworkVC;

//    self.window.contentViewController = [];

//
//    NSString * bundlePath = [[ NSBundle mainBundle] pathForResource: @"TestBundle1"ofType :@"bundle"];
//
//    NSBundle *resourceBundle = [NSBundle bundleWithPath:bundlePath];
//    NSString *imgPath= [bundlePath stringByAppendingPathComponent:@"Contents/Resources/switch1_on.jpg"];
    
//    TestVC *vc = [[TestVC alloc] initWithNibName:@"TestVC"bundle:resourceBundle];
//    Test1VC *vc = [Test1VC new];
//
//    self.window.contentViewController =vc;

}



@end
