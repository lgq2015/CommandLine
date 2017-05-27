//
//  NSTask+CommandLine.h
//  CommandLine
//
//  Created by Shuang Wu on 2017/5/26.
//  Copyright © 2017年 unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTask (CommandLine)

+ (NSTask *)launchedTaskWithAarguments:(NSArray<NSString *> *)arguments waitUntilExit:(BOOL)waitUntilExit;

@end
