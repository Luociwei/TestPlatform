//
//  SnVauleMode.m
//  OPP_Tool
//
//  Created by ciwei luo on 2020/5/27.
//  Copyright © 2020 macdev. All rights reserved.
//

#import "SnVauleMode.h"

@implementation SnVauleMode

-(NSString *)getVauleWithKey:(NSString *)key{
    NSString *value = @"";
    if ([key isEqualToString:@"sn"]) {
        value = self.sn;
    }else if ([key isEqualToString:@"value"]) {
        value = self.value;
    }
    return value;
}



@end
