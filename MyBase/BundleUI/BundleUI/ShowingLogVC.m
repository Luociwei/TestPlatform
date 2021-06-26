//
//  ShowingLogVC.m
//  TestPlanEditor
//
//  Created by ciwei luo on 2020/1/17.
//  Copyright © 2020 macdev. All rights reserved.
//

#import "ShowingLogVC.h"
//#import "TextView.h"

@interface ShowingLogVC ()

//@property (strong,nonatomic)TextView *textView;

@end

@implementation ShowingLogVC
+(void)postNotificationWithLog:(NSString *)log type:(NSString *)type{
    NSLog(@"cw_test__%@--%@",log,type);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _mutLogString = [NSMutableString string];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(showLog:)
//                                                 name:@"ShowingLogVCWillPrintLog"
//                                               object:nil];
//    self.logTextView.layoutManager.allowsNonContiguousLayout = NO;
    // Do view setup here.
  
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = [NSColor blueColor].CGColor;
//
//    self.textView = [TextView cw_allocInitWithFrame:self.view.bounds];

//    [self.view addSubview:self.textView];
}


-(void)viewDidLayout{
    [super viewDidLayout];
//    self.textView.frame = self.view.bounds;
}


-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (IBAction)click:(id)sender {
    NSLog(@"11111");
}




@end
