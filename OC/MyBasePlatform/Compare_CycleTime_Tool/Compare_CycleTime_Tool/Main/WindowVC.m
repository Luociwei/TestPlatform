//
//  WindowVC.m
//  DfuDebugTool
//
//  Created by ciwei luo on 2021/2/28.
//  Copyright © 2021 Suncode. All rights reserved.
//

#import "WindowVC.h"
#import "CompareCycleTimeVC.h"
@interface WindowVC ()

//@property (strong,nonatomic)RegularVC *regularVC;


@end

@implementation WindowVC




- (void)windowDidLoad {
    [super windowDidLoad];
//
    CompareCycleTimeVC *compareCycleTimeVC =  [[CompareCycleTimeVC alloc] init];
    compareCycleTimeVC.title = @"CompareCycleTime";
//
//    _atlasCsvLogVC =  [[AtlasLogVC alloc] init];
//    _atlasCsvLogVC.title = @"AtlasLog";
//
//    _atlasScritVC =  [[AtlasScritVC alloc] init];
//    _atlasScritVC.title = @"AtlasScript";
//
//    [self cw_addViewControllers:@[_atlasCsvLogVC,_atlasScritVC,regularVC]];
//    FailOnlyItems *item =  [[FailOnlyItems alloc] init];
//    item.title = @"AtlasLog";
//
    [self cw_addViewControllers:@[compareCycleTimeVC]];
   
//    [self getMixSate];
//
//    self.startBtn.toolTip = @"1_on.command";
//    self.stopBtn.toolTip = @"2_off.command";
//    self.atlasPathBtn.toolTip = @"/Users/gdlocal/Library/Atlas2/Assets/";
//    self.atlasLogBtn.toolTip = @"/Users/gdlocal/Library/Logs/Atlas/";
//    self.mixLogBtn.toolTip = @"/vault/Atlas/FixtureLog/";
//
    
}







//-(PresentViewController *)catchFwVc{
//    if (!_catchFwVc) {
//        _catchFwVc =[[CatchFwVc alloc]init];
//    }
//    return _catchFwVc;
//}
@end
