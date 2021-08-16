//
//  OC_Regular.m
//  Compare_CycleTime_Tool
//
//  Created by ciwei luo on 2021/6/22.
//  Copyright © 2021 Suncode. All rights reserved.
//

#import "CompareCycleTimeVC.h"
#import "LuaScriptCore.h"
#import "ExtensionConst.h"
#import "CycleTimeModel.h"
@interface CompareCycleTimeVC ()
@property (weak) IBOutlet NSTextField *scTimePathView;
@property (weak) IBOutlet NSTextField *atlasTimePathView;
@property (weak) IBOutlet NSButton *btnGenerate;

@property(nonatomic, strong) LSCContext *context;
@end

@implementation CompareCycleTimeVC
{
    NSDictionary *DefaultConfigDict;
    NSString *_comparePath;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    NSString *homepath = [NSString cw_getDesktopPath];
    
    NSString *_savePath =[NSString stringWithFormat:@"%@/Compare_CycleTime",homepath];
    _comparePath =[NSString stringWithFormat:@"%@/FCT_Cycle_Time_Compare.csv",_savePath];
    [FileManager cw_createFile:_savePath isDirectory:YES];
//     [FileManager cw_createFile:_comparePath isDirectory:NO];
//    [Task cw_openFileWithPath:_comparePath.stringByDeletingLastPathComponent];
    self.context = [[LSCContext alloc] init];
    
    //捕获异常
    [self.context onException:^(NSString *message) {
        
        NSLog(@"error = %@", message);
        
    }];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"DefaultConfig.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    if (!self.scTimePathView.stringValue.length) {
        
        //        sc_cycle_time_path = [dict objectForKey:@"sc_cycle_time_path"];
        self.scTimePathView.stringValue =[dict objectForKey:@"sc_cycle_time_path"];
        
    }
    if (!self.atlasTimePathView.stringValue.length) {
        //        atlas2_cycle_time_path = [dict objectForKey:@"atlas2_cycle_time_path"];
        self.atlasTimePathView.stringValue = [dict objectForKey:@"atlas2_cycle_time_path"];
    }
}

- (IBAction)generate:(NSButton *)sender {
    
    [self cycleTimeCompare];
}


-(void)cycleTimeCompare{

    NSString *sc_cycle_time_path = self.scTimePathView.stringValue;
    NSString *atlas2_cycle_time_path = self.atlasTimePathView.stringValue;
    if (![FileManager cw_isFileExistAtPath:sc_cycle_time_path] || ![FileManager cw_isFileExistAtPath:atlas2_cycle_time_path]) {
        return;
    }
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            self.btnGenerate.title = @"Generating";
//        }) ;
//    });
    
    //加载Lua脚本
    NSString *path = [[NSBundle mainBundle]pathForResource:@"DefaultConfig.plist" ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    if ([[dict objectForKey:@"lua"] boolValue]) {
        [self.context
         evalScriptFromFile:[[NSBundle mainBundle] pathForResource:@"Compare_CycleTime"
                                                            ofType:@"lua"]];
        
        
        LSCValue *value1 = [self.context callMethodWithName:@"generate"
                                                  arguments:@[
                                                              [LSCValue stringValue:sc_cycle_time_path],
                                                              [LSCValue stringValue:atlas2_cycle_time_path]
                                                              ]];
        
        return;
        
    }

    
    CSVParser *parser1 = [[CSVParser alloc]init];
    NSMutableArray *scArr =nil;
    
    NSMutableArray *compareArr =[[NSMutableArray alloc]init];;
    if ([parser1 openFile:sc_cycle_time_path]) {
        scArr = [parser1 parseFile];
        
        for (int i =0; i<scArr.count; i++) {
            NSArray *subArr = scArr[i];
            if (subArr.count != [scArr[0] count]) {
                continue;
            }
            CycleTimeModel *model = [[CycleTimeModel alloc]init];
            model.sc_TestName = subArr[0];
            model.sc_SubItem = subArr[1];
            model.sc_SubSubItem = subArr[2];
            model.sc_test_time = subArr[3];
            model.atlas2_Item = @"";
            model.atlas2_SubItem = @"";
            model.atlas2_test_time = @"";
            model.isFind = NO;
            [compareArr addObject:model];
        }
        
    }

    
    for (int i = 0; i<compareArr.count; i++) {
        CycleTimeModel *model = compareArr[i];

        NSString *name1 = [NSString stringWithFormat:@",.* .* %@,",model.sc_SubSubItem];
        NSString *cmd1 = [NSString stringWithFormat:@"grep \"%@\" %@",name1,atlas2_cycle_time_path];
        NSInteger count1 = [self grepWithCmd:cmd1 model:model];

        if (!model.isFind && count1>2) {//!model.isFind && count1>2
            NSString *name2 = [NSString stringWithFormat:@",%@ .* %@,",model.sc_TestName,model.sc_SubSubItem];
            NSString *cmd2 = [NSString stringWithFormat:@"grep \"%@\" %@",name2,atlas2_cycle_time_path];
            NSInteger count2 = [self grepWithCmd:cmd2 model:model];
            if (!model.isFind && count2 > 2) {

                NSString *name3 = [NSString stringWithFormat:@",%@ %@ %@,",model.sc_TestName,model.sc_SubItem,model.sc_SubSubItem];
                NSString *cmd3 = [NSString stringWithFormat:@"grep \"%@\" %@",name3,atlas2_cycle_time_path];
                [self grepWithCmd:cmd3 model:model];
            }
        }
        
//        if (!model.isFind) {
//            model.atlas2_test_time = model.sc_test_time;
//            model.atlas2_Item = [NSString stringWithFormat:@"%@ %@ %@",model.sc_TestName,model.sc_SubItem,model.sc_SubSubItem];
//            model.atlas2_SubItem = model.sc_test_time;
//            
//        }


    }
    
//    NSString *content = [FileManager cw_readFromFile:atlas2_cycle_time_path];
//    for (int i = 0; i<compareArr.count; i++) {
//        CycleTimeModel *model = compareArr[i];
//
//        NSString *name1 = [NSString stringWithFormat:@"\n.*,(.* .* %@),.*\n",model.sc_SubSubItem];
//
////        NSString *cmd1 = [NSString stringWithFormat:@"grep \"%@\" %@",name1,atlas2_cycle_time_path];
//        NSInteger count1 = [self grepWithString:content pattern:name1 model:model];
//
//        if (!model.isFind && count1>1) {//!model.isFind && count1>2
//            NSString *name2 = [NSString stringWithFormat:@"\n.*,(%@ .* %@),.*\n",model.sc_TestName,model.sc_SubSubItem];
//            NSInteger count2 = [self grepWithString:content pattern:name2 model:model];
//            if (!model.isFind && count2 > 1) {
//
//                NSString *name3 = [NSString stringWithFormat:@"\n.*,(%@ %@ %@),.*\n",model.sc_TestName,model.sc_SubItem,model.sc_SubSubItem];
//                [self grepWithString:content pattern:name3 model:model];
//            }
//        }
//
//
//    }
    
    if (compareArr.count) {
        NSString *title = [NSString stringWithFormat:@"TestName,SubItem,SubSubItem,test time(s),Atlas_test_time(s),Atlas_SubItem,Atlas_Item,isFind\n"];
        NSMutableString *compareString = [NSMutableString stringWithString:title];
        
        for (int i =0; i<compareArr.count; i++) {
            CycleTimeModel *model = compareArr[i];
            //            model.sc_TestName = subArr[0];
            //            model.sc_SubItem = subArr[1];
            //            model.sc_SubSubItem = subArr[2];
            //            model.sc_test_time = subArr[3];
            //            model.atlas2_Item = @"";
            //            model.atlas2_SubItem = @"";
            //            model.atlas2_test_time = @"";
            //            model.isFind = NO;
            [compareString appendString:[NSString stringWithFormat:@"%@,",model.sc_TestName]];
            [compareString appendString:[NSString stringWithFormat:@"%@,",model.sc_SubItem]];
            [compareString appendString:[NSString stringWithFormat:@"%@,",model.sc_SubSubItem]];
            [compareString appendString:[NSString stringWithFormat:@"%@,",model.sc_test_time]];
            [compareString appendString:[NSString stringWithFormat:@"%@,",model.atlas2_test_time]];
            [compareString appendString:[NSString stringWithFormat:@"%@,",model.atlas2_SubItem]];
            [compareString appendString:[NSString stringWithFormat:@"%@,",model.atlas2_Item]];
            if (model.isFind) {
                [compareString appendString:@"Y\n"];
            }else{
                [compareString appendString:@"N\n"];
            }
        }
        

        NSError *error;
   
//        NSString *compare_path =[NSString stringWithFormat:@"%@/FCT_Cycle_Time_Compare.csv",_savePath];
        [compareString writeToFile:_comparePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
        
        [Task cw_openFileWithPath:_comparePath.stringByDeletingLastPathComponent];
    }
    //    parser parseFile
    
    
    self.btnGenerate.title = @"Generate";
}


-(NSInteger)grepWithCmd:(NSString *)cmd  model:(CycleTimeModel*)model{
    
//    NSString *fullName = [NSString stringWithFormat:@",%@ %@ %@,",model.sc_TestName,model.sc_SubItem,model.sc_SubSubItem];
//    NSString *cmd = [NSString stringWithFormat:@"grep \"%@\" %@",fullName,atlas2_cycle_time_path];
    
    NSString *log = [Task cw_termialWithCmd:cmd delay:0.1];
    NSArray *logArr = [log componentsSeparatedByString:@"\n"];
    if (logArr.count==1 || (logArr.count==2 && [logArr[1] length] ==0)){
        
        NSArray *sub_log_arr = [log componentsSeparatedByString:@","];
        if (sub_log_arr.count == 9) {
            model.atlas2_test_time = sub_log_arr[4];
            model.atlas2_SubItem = sub_log_arr[5];
            model.atlas2_Item = sub_log_arr[6];
            model.isFind = YES;
            
        }
        
    }
    
    return logArr.count;
}

-(NSInteger)grepWithString:(NSString *)string  pattern:(NSString *)pattern  model:(CycleTimeModel*)model{
    
    NSMutableArray *resultsArr = [self regularWithString:string pattern:pattern];
    if (resultsArr.count==1) {
        NSString *log = resultsArr[0][1];
        NSArray *sub_log_arr = [log componentsSeparatedByString:@" "];
        if (sub_log_arr.count == 3) {
            model.atlas2_test_time = sub_log_arr[0];
            model.atlas2_SubItem = sub_log_arr[1];
            model.atlas2_Item = sub_log_arr[2];
            model.isFind = YES;
            
        }
    }
    return resultsArr.count;
}


-(NSMutableArray *)regularWithString:(NSString *)string pattern:(NSString *)pattern{
//    NSString *content = @"\\J407\\diag-pallas-44.06.81.bin----\\J408\\diag-pallas-48.05.82.bin--\\J409\\diag-pallas-41.02.84.bin";
//    NSString *pattern = @"diag-pallas-([\\d.]+)bin";
//    //    NSString *pattern = @"a";
    NSError *err = nil;
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&err];
    NSArray *results = [regular matchesInString:string options:0 range:NSMakeRange(0,string.length)];
    NSMutableArray *resultsArr = [[NSMutableArray alloc]init];
    for (NSTextCheckingResult *result in results) {
        NSMutableArray *resultArr = [[NSMutableArray alloc]init];
        NSInteger rangesCount = result.numberOfRanges;
        for (int i =0; i<rangesCount; i++) {
            NSRange range = [result rangeAtIndex:i];
            NSString *resultString =[string substringWithRange:range];
            [resultArr addObject:resultString];
        }
        [resultsArr addObject:resultArr];
        
    }
    return resultsArr;
}

@end
