//
//  CLKeyItem.m
//  Demo_OC
//
//  Created by Shuang Wu on 2017/3/9.
//  Copyright © 2017年 Magic Unique. All rights reserved.
//

#import "CLExplainItem.h"

@implementation CLExplainItem

+ (instancetype)itemWithKey:(NSString *)key abbr:(NSString *)abbr optional:(BOOL)optional defaultValue:(NSString *)defaultValue example:(NSString *)example explain:(NSString *)explain {
    CLExplainItem *item = [CLExplainItem new];
    item.key = key;
    item.abbr = abbr;
    item.example = example;
    item.explain = explain;
    item.optional = optional;
    return item;
}

+ (instancetype)keyValueItemWithKey:(NSString *)key abbr:(NSString *)abbr optional:(BOOL)optional defaultValue:(NSString *)defaultValue example:(NSString *)example explain:(NSString *)explain {
    return [self itemWithKey:key abbr:abbr optional:optional defaultValue:defaultValue example:example explain:explain];
}

+ (instancetype)flagItemWithKey:(NSString *)key abbr:(NSString *)abbr explain:(NSString *)explain {
    return [self itemWithKey:key abbr:abbr optional:YES defaultValue:nil example:nil explain:explain];
}

@end
