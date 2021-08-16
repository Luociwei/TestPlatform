//
//  ItemMode.m
//  OPP_Tool
//
//  Created by ciwei luo on 2020/5/26.
//  Copyright © 2020 macdev. All rights reserved.
//

#import "ItemMode.h"


@implementation ItemMode

-(instancetype)init{
    if (self == [super init]) {
        
        self.SnVauleArray = [[NSMutableArray alloc]init];
    }
    return self;
}

-(NSString *)getVauleWithKey:(NSString *)key{
    NSString *value = @"";
    if ([key isEqualToString:@"item"]) {
        value = self.item;
    }else if ([key isEqualToString:@"upper"]) {
        value = self.upper;
    }else if ([key isEqualToString:@"low"]) {
        value = self.low;
    }
    return value;
}

@end
