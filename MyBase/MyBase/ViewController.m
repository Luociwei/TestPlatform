//
//  ViewController.m
//  SC_Eowyn
//
//  Created by ciwei luo on 2020/3/31.
//  Copyright © 2020 ciwei luo. All rights reserved.
//

#import "ViewController.h"
#import "ShowingLogVC.h"
#import "CWGeneralManager.h"
#import "ItemMode.h"
#import "FMDB.h"
#import "DataForFMDB.h"
#import "PythonTask.h"

NSString *vrectInit1 = @"hidreport -v 0x05ac -p 0x041F -i 0 set 0x90 0x90 0x3";

NSString *vrectInit2 = @"hidreport -v 0x05ac -p 0x041F -i 3 set 0x82 0x82  0x06  0x2C  0x00  0x00  0x01  0x00  0x00  0x00  0x00  0x00  0x00  0x00  0x00  0x00  0x00  0x00";

NSString *vrectInit3 = @"hidreport -v 0x05ac -p 0x041F -i 3 set 0x88  0x88  0x90  0x36  0x00  0x40  0xFF  0xFF  0xFF  0xFF  0x00  0x00  0x00  0x80";

NSString *vrectCmd = @"hidreport -v 0x05ac -p 0x041F -i 3 set 0x82 0x82 0x29 0x20 0x00 0x00 0x01 0x80 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00";
@interface ViewController ()
@property (unsafe_unretained) IBOutlet NSTextView *logview;
    
@property (nonatomic,strong) NSMutableArray<ItemMode *> *items_datas;
@property (nonatomic,strong) NSMutableArray<SnVauleMode *> *sn_datas;
@property (weak) IBOutlet NSTableView *itemsTableView;
@property (weak) IBOutlet NSTableView *snTableView;
@property (weak) IBOutlet NSTextField *labelPath;
@property (nonatomic, strong) FMDatabase *db;
    
    @property (nonatomic,strong)PythonTask *vrectReadTask;
    
    @property (nonatomic,strong)PythonTask *vrectInputsTask;
@end

@implementation ViewController

- (IBAction)vrect:(NSButton *)sender {
    
    [self.vrectReadTask send:vrectCmd];
    NSString *read = [self.vrectReadTask read];
    self.logview.string = read;
    
}
    
- (IBAction)dbClick:(NSButton *)btn {
    if ([btn.title isEqualToString:@"add"]) {
//        BOOL flag = [_db executeUpdate:@"insert into t_contact (name,phone) values (?,?)",@"oooo",@"21321321"];
//        if (flag) {
//            NSLog(@"success");
//        }else{
//            NSLog(@"failure");
//        }
        
        [[DataForFMDB sharedDataBase] addData];
        
    }else if ([btn.title isEqualToString:@"delete"]){
//        BOOL flag = [_db executeUpdate:@"delete from t_contact;"];
//        if (flag) {
//            NSLog(@"success");
//        }else{
//            NSLog(@"failure");
//        }
        [[DataForFMDB sharedDataBase] deleteAllData];
    }else if ([btn.title isEqualToString:@"modify"]){
        // FMDB？，只能是对象，不能是基本数据类型，如果是int类型，就包装成NSNumber
//        BOOL flag = [_db executeUpdate:@"update t_contact set name = ?",@"abc"];
//        if (flag) {
//            NSLog(@"success");
//        }else{
//            NSLog(@"failure");
//        }
        [[DataForFMDB sharedDataBase] update];
    }else if ([btn.title isEqualToString:@"search"]){
//        FMResultSet *result =  [_db executeQuery:@"select * from t_contact"];
//
//        // 从结果集里面往下找
//        while ([result next]) {
//            NSString *name = [result stringForColumn:@"name"];
//            NSString *phone = [result stringForColumn:@"phone"];
//            NSLog(@"%@--%@",name,phone);
//        }
        [[DataForFMDB sharedDataBase] getData];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _vrectReadTask =[[PythonTask alloc] initWithLauchPath:@"/bin/sh" arguments:[NSArray arrayWithObjects:@"-c",@"hidreport -v 0x05ac -p 0x041F -i 3 inputs", nil]];
//
    _vrectInputsTask =[[PythonTask alloc] initWithLauchPath:@"/bin/sh" arguments:[NSArray arrayWithObjects:@"-c",vrectInit1,vrectInit2,vrectInit3,nil]];
//    NSString *read = [self.vrectInputsTask read];
//    self.logview.string = read;
    
    
//    NSString *read1 = [self.vrectReadTask read];
//    self.logview.string = read1;
//    _zmqClient = [[ZMQREQ alloc]init];
//    [_zmqClient createRPC:cpk_zmq_addr];
//    [_zmqClient setTimeOut:20*1000];
//    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
//    // 拼接文件名
//    NSString *filePath = [cachePath stringByAppendingPathComponent:@"contact.sqlite"];
//    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
//    self.labelPath.stringValue = resourcePath;
//    NSString *filePath = [resourcePath stringByAppendingPathComponent:@"contact.sqlite"];
//    self.db = [FMDatabase databaseWithPath:filePath];
//
//    BOOL flag = [self.db open];
//    if (flag) {
//        NSLog(@"打开成功");
//    }else{
//        NSLog(@"打开失败");
//    }
//    // 创建数据库表
//    // 数据库操作：插入，更新，删除都属于update
//    // 参数：sqlite语句
//    BOOL flag1 = [self.db executeUpdate:@"create table if not exists t_contact (id integer primary key autoincrement,name text,phone text);"];
//    if (flag1) {
//        NSLog(@"创建成功");
//    }else{
//        NSLog(@"创建失败");
//
//    }
    
    
    
//    self.items_datas = [[NSMutableArray alloc]init];
//    self.sn_datas =[[NSMutableArray alloc]init];
//
//    for (int i =0; i<5; i++) {
//        ItemMode *mode = [[ItemMode alloc]init];
//        mode.item= [NSString stringWithFormat:@"item_%d",i];
//        mode.upper = [NSString stringWithFormat:@"%d",i+5];
//        mode.low = [NSString stringWithFormat:@"%d",i-5];
//        [self.items_datas addObject:mode];
//    }
//
//    for (int i =0; i<5; i++) {
//        SnVauleMode *mode = [[SnVauleMode alloc]init];
//        mode.sn= [NSString stringWithFormat:@"sn_%d",i];
//        mode.value = [NSString stringWithFormat:@"%d",i+5];
//        [self.sn_datas addObject:mode];
//    }
//
//
//    [self initTableView:self.snTableView];
//    [self initTableView:self.itemsTableView];
  
    
}

-(void)initTableView:(NSTableView *)tableView{
    tableView.headerView.hidden=NO;
    tableView.usesAlternatingRowBackgroundColors=YES;
    tableView.rowHeight = 20;
    tableView.gridStyleMask = NSTableViewSolidHorizontalGridLineMask |NSTableViewSolidVerticalGridLineMask ;
}


- (IBAction)add_csv_click:(NSButton *)sender {
    [CWFileManager openPanel:^(NSString * _Nonnull path) {
        NSLog(@"%@", [NSString stringWithFormat:@"CW+++++path:%@",path]);
        CSVParser *csv = [[CSVParser alloc]init];
        NSMutableArray *mutArray = nil;
        if ([csv openFile:path]) {
            mutArray = [csv parseFile];
        }
        
        if (mutArray.count<8 ) {
            return;
        }
        
    
        NSArray *titles_arr = mutArray[1];
        NSArray *upper_arr = mutArray[4];
        NSArray *low_arr = mutArray[5];
        
        NSMutableArray *item_mode_arr = [[NSMutableArray alloc]init];
        for (int i=0; i<titles_arr.count; i++) {
            if (i<12) {
                continue;
            }
            ItemMode *item_mode = [[ItemMode alloc]init];
            item_mode.item = titles_arr[i];
            item_mode.low = low_arr[i];
            item_mode.upper = upper_arr[i];
            item_mode.index=i;
            
            for (int j =0; j<mutArray.count; j++) {
                if (j<7) {
                    continue;
                }
                
               SnVauleMode *sv = [[SnVauleMode alloc] init];
                sv.sn = mutArray[j][2];
                sv.value = mutArray[j][i];
                [item_mode.SnVauleArray addObject:sv];
            }
            
            [item_mode_arr addObject:item_mode];
        }
        NSLog(@"1");
        [self.items_datas removeAllObjects];
        [self.items_datas addObjectsFromArray:item_mode_arr];
        [self.itemsTableView reloadData];
    }];
    
   
}



#pragma mark-  NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    //返回表格共有多少行数据
    if (tableView == self.snTableView) {
        return [self.sn_datas count];
    }else{
        return [self.items_datas count];
    }
    
}

#pragma mark-  NSTableViewDelegate
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
 
    NSString *identifier = tableColumn.identifier;
    NSString *value = @"";
    NSTextField *textField;
    
    if (tableView == self.snTableView) {
     
        SnVauleMode *sv_data = self.sn_datas[row];
        sv_data= self.sn_datas[row];

        value=[sv_data getVauleWithKey:identifier];
    }else{
        
        ItemMode *item_data = self.items_datas[row];
        item_data= self.items_datas[row];
        value=[item_data getVauleWithKey:identifier];

    }
   

    NSView *view = [tableView makeViewWithIdentifier:identifier owner:self];
   
    if(!view){
        
        textField =  [[NSTextField alloc]init];

        textField.identifier = identifier;
        view = textField ;
        
    }
    else{
        
//        textField = (NSTextField*)view;
        NSArray *subviews = [view subviews];
        
        textField = subviews[0];


    }
    textField.wantsLayer=YES;
    [textField setBezeled:NO];
    [textField setDrawsBackground:NO];
    
    if(value){
        //更新单元格的文本
        [textField setStringValue: value];
    }
    
    if ([identifier isEqualToString:@"value"]) {
        [textField setTextColor:[NSColor blueColor]];
        textField.layer.backgroundColor = [NSColor greenColor].CGColor;
    }

    return view;
}


- (void)tableViewSelectionDidChange:(NSNotification *)notification{
    
    NSLog(@"s");
    
    NSTableView *tableView = notification.object;
    if (tableView == self.itemsTableView) {
        NSInteger index = tableView.selectedRow;
        if (self.items_datas.count) {
            ItemMode *item = self.items_datas[index];
            [self.sn_datas removeAllObjects];
            [self.sn_datas addObjectsFromArray:item.SnVauleArray];
            [self.snTableView reloadData];
        }
        
    }
}
@end
