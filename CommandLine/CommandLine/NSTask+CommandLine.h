//
//  NSTask+CommandLine.h
//  CommandLine
//
//  Created by Shuang Wu on 2017/5/26.
//  Copyright © 2017年 unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTask (CommandLine)

+ (instancetype)launchedTaskWithArguments:(NSArray<NSString *> *)arguments waitUntilExit:(BOOL)waitUntilExit;

@end

@interface NSString (CommandLine)

+ (instancetype)stringWithLaunchArguments:(NSArray<NSString *> *)arguments;

@end

id CLLaunchWithArguments(NSArray *arguments);
