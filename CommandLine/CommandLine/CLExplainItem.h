//
//  CLKeyItem.h
//  Demo_OC
//
//  Created by Shuang Wu on 2017/3/9.
//  Copyright © 2017年 Magic Unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLExplainItem : NSObject

@property (nonatomic, copy) NSString *key;

@property (nonatomic, copy) NSString *abbr;

@property (nonatomic, copy) NSString *example;

@property (nonatomic, copy) NSString *explain;

@property (nonatomic, assign, getter=isOptional) BOOL optional;

+ (instancetype)keyValueItemWithKey:(NSString *)key abbr:(NSString *)abbr optional:(BOOL)optional example:(NSString *)example explain:(NSString *)explain;

+ (instancetype)flagItemWithKey:(NSString *)key abbr:(NSString *)abbr explain:(NSString *)explain;

@end
