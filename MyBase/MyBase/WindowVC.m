//
//  WindowVC.m
//  SC_Eowyn
//
//  Created by ciwei luo on 2020/3/31.
//  Copyright © 2020 ciwei luo. All rights reserved.
//

#import "WindowVC.h"
#import "ViewController.h"
#import "ShowingLogVC.h"
#import "CWGeneralManager.h"

@interface WindowVC ()

@end

@implementation WindowVC

- (void)windowDidLoad {
    [super windowDidLoad];
    

    ShowingLogVC *showVC = [[ShowingLogVC alloc]init] ;

    [self cw_addViewController:showVC];
}



@end
