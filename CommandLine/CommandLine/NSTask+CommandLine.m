//
//  NSTask+CommandLine.m
//  CommandLine
//
//  Created by Shuang Wu on 2017/5/26.
//  Copyright © 2017年 unique. All rights reserved.
//

#import "NSTask+CommandLine.h"

@implementation NSTask (CommandLine)

+ (NSTask *)launchedTaskWithAarguments:(NSArray<NSString *> *)arguments waitUntilExit:(BOOL)waitUntilExit {
    NSMutableArray *args = [NSMutableArray arrayWithArray:arguments];
    [args removeObjectAtIndex:0];
    NSTask *task = [self launchedTaskWithLaunchPath:arguments.firstObject arguments:args];
    if (waitUntilExit) {
        [task waitUntilExit];
    }
    return task;
}

@end
