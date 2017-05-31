//
//  CLArguments.h
//  BaiduMusicBrowser
//
//  Created by 吴双 on 2017/3/5.
//  Copyright © 2017年 unique. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CL_ERROR_NO_COMMAND (NSIntegerMax - 0)
#define CL_ERROR_NO_EXPLAIN (NSIntegerMax - 1)
#define CL_ERROR_NO_TASK    (NSIntegerMax - 2)

#define CLVerbose(arg, ...) if ([arg hasFlags:@"verbose"]) printf(__VA_ARGS__);

@class CLArguments;

typedef NSError *(^CLCommandTask)(CLArguments *arguments);

@interface CLArguments : NSObject

@property (nonatomic, strong, readonly) NSString *executeFilePath;

@property (nonatomic, strong, readonly) NSString *command;

@property (nonatomic, strong, readonly) NSArray<NSString *> *allArgs;

@property (nonatomic, strong, readonly) NSDictionary *keyValues;

@property (nonatomic, strong, readonly) NSArray<NSString *> *ioPaths;

@property (nonatomic, strong, readonly) NSArray<NSString *> *flags;

@property (nonatomic, assign, readonly) BOOL requireCommand;

- (instancetype)initWithRequireCommand:(BOOL)requireCommand;

/** 
 *  The function below is define a object of CLArguments
 */

- (void)setIOPathMinimumCount:(NSUInteger)ioPathMinimumCount;

- (BOOL)setKey:(NSString *)key abbr:(NSString *)abbr optional:(BOOL)optional example:(NSString *)example explain:(NSString *)explain;//   forCommand:nil
- (BOOL)setKey:(NSString *)key abbr:(NSString *)abbr optional:(BOOL)optional example:(NSString *)example explain:(NSString *)explain forCommand:(NSString *)command;
- (BOOL)setOptionalKey:(NSString *)key abbr:(NSString *)abbr defaultValue:(NSString *)defaultValue example:(NSString *)example explain:(NSString *)explain forCommand:(NSString *)command;

- (BOOL)setFlag:(NSString *)flag abbr:(NSString *)abbr explain:(NSString *)explain;//   forCommand:nil
- (BOOL)setFlag:(NSString *)flag abbr:(NSString *)abbr explain:(NSString *)explain forCommand:(NSString *)command;

- (BOOL)setCommand:(NSString *)command explain:(NSString *)explain;
- (BOOL)setCommand:(NSString *)command task:(CLCommandTask)task;


/** 
 *  The function below should be called in main().
 *  Before, you need define a object of CLArguments to define the key and set description of arguments
 */

- (void)analyseArgumentCount:(NSUInteger)count values:(const char * [])argvs;
- (void)printExplainAndExist:(int)code;
- (NSError *)executeCommand;

/** 
 *  You can call the function below to get the command line arguments inputted.
 */

- (BOOL)hasKey:(NSString *)key;

- (BOOL)hasFlags:(NSString *)flags;

- (NSString *)stringValueForKey:(NSString *)key;
- (NSNumber *)numberValueForKey:(NSString *)key;
- (NSString *)fullPathValueForKey:(NSString *)key;

- (NSString *)fullIOPathAtIndex:(NSUInteger)index;

/** 
 *  Environment
 */

+ (NSString *)currentWorkDirectory;
+ (NSString *)fullPathWithPath:(NSString *)path;

@end
