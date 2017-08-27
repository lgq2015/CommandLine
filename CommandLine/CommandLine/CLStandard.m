//
//  CLStandard.m
//  WeChatPlugin Command Line Tools
//
//  Created by Shuang Wu on 2017/8/1.
//
//

#import "CLStandard.h"

@implementation CLStandard

+ (NSString *)getStringFromStandardInput:(NSString *)tip {
    char *input = malloc(sizeof(char) * 512);
    memset(input, 0, sizeof(char) * 512);
    printf("%s: ", tip.UTF8String);
    scanf("%s", input);
    fflush(stdin);
    NSString *inputStr = [NSString stringWithUTF8String:input];
    free(input);
    return inputStr;
}

+ (BOOL)getBOOLFromStandardInput:(NSString *)tip {
    char input = '\0';
    printf("%s(y/n): ", tip.UTF8String);
    do {
        scanf("%c", &input);
        fflush(stdin);
    } while (input != 'y' && input != 'Y' && input != 'n' && input != 'N');
    fflush(stdin);
    if (input == 'y' || input == 'Y') {
        return YES;
    } else {
        return NO;
    }
}

+ (NSInteger)getIntegerFromStandardInput:(NSString *)tip {
	NSInteger input = 0;
	printf("%s: ", tip.UTF8String);
	scanf("%ld", &input);
	fflush(stdin);
	return input;
}

@end
