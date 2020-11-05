//
//  ItemMode.h
//  OPP_Tool
//
//  Created by ciwei luo on 2020/5/26.
//  Copyright © 2020 macdev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SnVauleMode.h"

NS_ASSUME_NONNULL_BEGIN

@interface ItemMode : NSObject

@property (nonatomic,copy)NSString *item;
@property (nonatomic,copy)NSString *upper;
@property (nonatomic,copy)NSString *low;
@property (nonatomic)NSInteger index;
@property (nonatomic,strong)NSMutableArray<SnVauleMode *> *SnVauleArray;
-(NSString *)getVauleWithKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
