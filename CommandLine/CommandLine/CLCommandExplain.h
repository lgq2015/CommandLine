//
//  CLCommandExplain.h
//  BaiduMusicBrowser
//
//  Created by Shuang Wu on 2017/3/9.
//  Copyright © 2017年 unique. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLExplainItem.h"

@class CLArguments;

typedef NSError *(^CLCommandTask)(CLArguments *arguments);

@interface CLCommandExplain : NSObject

@property (nonatomic, copy) NSString *explain;

@property (nonatomic, strong, readonly) NSDictionary<NSString *, CLExplainItem *> *keyExplains;

@property (nonatomic, strong, readonly) NSDictionary<NSString *, CLExplainItem *> *flagExplains;

@property (nonatomic, copy) CLCommandTask task;

- (BOOL)setKey:(NSString *)key abbr:(NSString *)abbr optional:(BOOL)optional example:(NSString *)example explain:(NSString *)explain;
- (BOOL)setKey:(NSString *)key abbr:(NSString *)abbr optional:(BOOL)optional defaultValue:(NSString *)defaultValue example:(NSString *)example explain:(NSString *)explain;

- (BOOL)setFlag:(NSString *)flag abbr:(NSString *)abbr explain:(NSString *)explain;
- (BOOL)setDefaultFlag:(NSString *)flag abbr:(NSString *)abbr explain:(NSString *)explain;

- (CLExplainItem *)keyItemWithKey:(NSString *)key;
- (CLExplainItem *)keyItemWithKeyAbbr:(NSString *)keyAbbr;
- (BOOL)keyItemIsOptionalWithDefaultValue:(NSString *)key;
- (NSString *)defaultValueForOptionalKey:(NSString *)key;

- (CLExplainItem *)flagItemWithFlag:(NSString *)flag;
- (CLExplainItem *)flagItemWithFlagAbbr:(NSString *)flagAbbr;

- (void)printExplainWithTabCount:(NSUInteger)tabCount withExplain:(BOOL)withExplain;

@end
