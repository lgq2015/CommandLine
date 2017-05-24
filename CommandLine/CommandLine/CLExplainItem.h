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

@property (nonatomic, copy) NSString *explain;

@property (nonatomic, assign, getter=isRequire) BOOL require;

+ (instancetype)itemWithKey:(NSString *)key abbr:(NSString *)abbr explain:(NSString *)explain;

@end
