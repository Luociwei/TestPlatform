//
//  WindowVC.m
//  SC_Eowyn
//
//  Created by ciwei luo on 2020/3/31.
//  Copyright © 2020 ciwei luo. All rights reserved.
//

#import "WindowVC.h"
#import "AtlasLogVC.h"
#import "ShowingLogVC.h"


@interface WindowVC ()

@end

@implementation WindowVC

- (void)windowDidLoad {
    [super windowDidLoad];
    NSString *path = [[NSBundle bundleForClass:[self class]].resourcePath stringByAppendingPathComponent:@"BundleUI.bundle"];
    NSBundle *bundle =   [NSBundle bundleWithPath:path];
    if ([NSBundle loadNibNamed:@"ShowingLogVC" owner:self]==FALSE){
        return ;
    }
    
    id bdl = [[[bundle principalClass] alloc]init];
    
    
//    ShowingLogVC *showVC = [[ShowingLogVC alloc]init] ;
//    ViewController *vc = [[ViewController alloc]init] ;
    AtlasLogVC *vc = [[AtlasLogVC alloc]init];
    [self cw_addViewController:vc];

//    [self cw_addViewController:bdl];
}



@end
