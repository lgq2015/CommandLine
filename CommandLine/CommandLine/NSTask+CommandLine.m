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

id CLLaunchWithArguments(NSArray *arguments) {
	NSMutableArray *args = [NSMutableArray arrayWithArray:arguments];
	NSString *launchPath = arguments.firstObject;
	[args removeObjectAtIndex:0];
	NSTask *task = [NSTask new];
	NSPipe *pipe = [NSPipe pipe];
	NSFileHandle *file = [pipe fileHandleForReading];
	
	task.launchPath = launchPath;
	task.arguments = args;
	task.standardInput = [NSFileHandle fileHandleWithNullDevice];
	task.standardOutput = pipe;
	task.standardError = pipe;
	[task launch];
	
//	[task waitUntilExit];inf
	NSMutableData *mdata = [NSMutableData data];
	while (task.isRunning) {
		[mdata appendData:file.availableData];
	}
	NSString *output = [[NSString alloc] initWithData:mdata encoding:NSUTF8StringEncoding];
	if ([output hasSuffix:@"\n"]) {
		output = [output substringToIndex:output.length - 1];
	}
	
	if (task.terminationStatus == 0) {
		return output;
	} else {
		NSString *domain = [NSString stringWithFormat:@"com.unique.commandline.%@", launchPath.lastPathComponent.lowercaseString];
		return [NSError errorWithDomain:domain code:task.terminationStatus userInfo:@{NSLocalizedDescriptionKey:output}];
	}
}

id CLLaunchInDirectoryWithArguments(NSString *wd, NSArray *arguments) {
	NSMutableArray *args = [NSMutableArray arrayWithArray:arguments];
	NSString *launchPath = arguments.firstObject;
	[args removeObjectAtIndex:0];
	NSTask *task = [NSTask new];
	NSPipe *pipe = [NSPipe pipe];
	NSFileHandle *file = [pipe fileHandleForReading];
	
	task.currentDirectoryPath = wd;
	task.launchPath = launchPath;
	task.arguments = args;
	task.standardInput = [NSFileHandle fileHandleWithNullDevice];
	task.standardOutput = pipe;
	task.standardError = pipe;
	[task launch];
	
	//	[task waitUntilExit];
	NSMutableData *mdata = [NSMutableData data];
	while (task.isRunning) {
		[mdata appendData:file.availableData];
	}
	NSString *output = [[NSString alloc] initWithData:mdata encoding:NSUTF8StringEncoding];
	if ([output hasSuffix:@"\n"]) {
		output = [output substringToIndex:output.length - 1];
	}
	
	if (task.terminationStatus == 0) {
		return output;
	} else {
		NSString *domain = [NSString stringWithFormat:@"com.unique.commandline.%@", launchPath.lastPathComponent.lowercaseString];
		return [NSError errorWithDomain:domain code:task.terminationStatus userInfo:@{NSLocalizedDescriptionKey:output}];
	}
}

@implementation NSString (CommandLine)

+ (instancetype)stringWithLaunchArguments:(NSArray<NSString *> *)arguments {
	id res = CLLaunchWithArguments(arguments);
	if ([res isKindOfClass:[NSString class]]) {
		return res;
	} else {
		return nil;
	}
}

@end
