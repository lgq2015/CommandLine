//
//  NSTask+CommandLine.m
//  CommandLine
//
//  Created by Shuang Wu on 2017/5/26.
//  Copyright © 2017年 unique. All rights reserved.
//

#import "NSTask+CommandLine.h"

@implementation NSTask (CommandLine)

+ (instancetype)launchedTaskWithArguments:(NSArray<NSString *> *)arguments waitUntilExit:(BOOL)waitUntilExit {
    NSMutableArray *args = [NSMutableArray arrayWithArray:arguments];
    [args removeObjectAtIndex:0];
    NSTask *task = [self launchedTaskWithLaunchPath:arguments.firstObject arguments:args];
    if (waitUntilExit) {
        [task waitUntilExit];
    }
    return task;
}

@end

@implementation NSString (CommandLine)

+ (instancetype)stringWithLaunchArguments:(NSArray<NSString *> *)arguments {
    NSMutableArray *args = [NSMutableArray arrayWithArray:arguments];
    [args removeObjectAtIndex:0];
    NSTask *task = [NSTask new];
    NSPipe *pipe = [NSPipe pipe];
    NSFileHandle *file = [pipe fileHandleForReading];
    
    task.launchPath = arguments.firstObject;
    task.arguments = args;
    task.standardInput = [NSFileHandle fileHandleWithNullDevice];
    task.standardOutput = pipe;
    task.standardError = pipe;
    [task launch];
    
    [task waitUntilExit];
    NSData *data = file.availableData;
    return [[self alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end
