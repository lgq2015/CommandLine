//
//  CLArguments.h
//  BaiduMusicBrowser
//
//  Created by 吴双 on 2017/3/5.
//  Copyright © 2017年 unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLArguments : NSObject

@property (nonatomic, strong, readonly) NSString *executeFilePath;

@property (nonatomic, strong, readonly) NSString *command;

@property (nonatomic, strong, readonly) NSArray<NSString *> *allArgs;

@property (nonatomic, strong, readonly) NSDictionary *keyValues;

@property (nonatomic, strong, readonly) NSArray<NSString *> *ioPaths;

@property (nonatomic, strong, readonly) NSArray<NSString *> *flags;

@property (nonatomic, assign, readonly) BOOL requireCommand;

- (instancetype)initWithRequireCommand:(BOOL)requireCommand;

- (void)setIOPathMinimumCount:(NSUInteger)ioPathMinimumCount;
- (BOOL)setKey:(NSString *)key abbr:(NSString *)abbr explain:(NSString *)explain;
- (BOOL)setKey:(NSString *)key abbr:(NSString *)abbr explain:(NSString *)explain forCommand:(NSString *)command;
- (BOOL)setFlag:(NSString *)flag abbr:(NSString *)abbr explain:(NSString *)explain;
- (BOOL)setFlag:(NSString *)flag abbr:(NSString *)abbr explain:(NSString *)explain forCommand:(NSString *)command;
- (BOOL)setCommand:(NSString *)command explain:(NSString *)explain;

- (void)analyseArgumentCount:(NSUInteger)count values:(const char * [])argvs;
- (void)printExplainAndExist:(int)code;

- (BOOL)hasKey:(NSString *)key;

- (BOOL)hasFlags:(NSString *)flags;

- (NSString *)stringValueForKey:(NSString *)key;
- (NSNumber *)numberValueForKey:(NSString *)key;
- (NSString *)fullPathValueForKey:(NSString *)key;

- (NSString *)fullIOPathAtIndex:(NSUInteger)index;


+ (NSString *)currentWorkDirectory;
+ (NSString *)fullPathWithPath:(NSString *)path;

@end