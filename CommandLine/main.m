//
//  main.m
//  CommandLine
//
//  Created by Shuang Wu on 2017/5/24.
//  Copyright © 2017年 unique. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommandLine.h"

CLArguments *MakeArguments() {
    CLArguments *arg = [CLArguments new];
    return arg;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        dispatch_semaphore_t mainSemaphore = dispatch_semaphore_create(1);
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
        
        dispatch_queue_t mainQueue = dispatch_queue_create("test.main", NULL);
        dispatch_queue_t taskQueue = dispatch_queue_create("test.task", NULL);
        
        dispatch_async(mainQueue, ^{
            for (int i = 0; i < 10; i++) {
                NSLog(@"wait: %d", i);
                dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
                NSLog(@"do: %d", i);
                dispatch_async(taskQueue, ^{
                    NSLog(@"sleep: %d", i);
                    [NSThread sleepForTimeInterval:1];
                    NSLog(@"end: %d", i);
                    dispatch_semaphore_signal(semaphore);
                    if (i == 9) {
                        dispatch_semaphore_signal(mainSemaphore);
                    }
                });
            }
            
        });
        
        dispatch_semaphore_wait(mainSemaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"end");
    }
    return 0;
}
