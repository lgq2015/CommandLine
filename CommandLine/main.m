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
        CLArguments *arg = MakeArguments();
        
        [arg analyseArgumentCount:argc values:argv];
        [arg printExplainAndExist:0];
        
        for (NSString *path in arg.allArgs) {
            NSLog(@"%@", [CLArguments fullPathWithPath:path]);
        }
        
        NSLog(@"%@", arg.executeFilePath);

    }
    return 0;
}
