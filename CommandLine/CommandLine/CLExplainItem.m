//
//  CLKeyItem.m
//  Demo_OC
//
//  Created by Shuang Wu on 2017/3/9.
//  Copyright © 2017年 Magic Unique. All rights reserved.
//

#import "CLExplainItem.h"

@implementation CLExplainItem

+ (instancetype)itemWithKey:(NSString *)key abbr:(NSString *)abbr explain:(NSString *)explain {
    CLExplainItem *item = [CLExplainItem new];
    item.key = key;
    item.abbr = abbr;
    item.explain = explain;
    return item;
}

@end
