//
//  CLStandard.h
//  WeChatPlugin Command Line Tools
//
//  Created by Shuang Wu on 2017/8/1.
//
//

#import <Foundation/Foundation.h>

@interface CLStandard : NSObject

+ (NSString *)getStringFromStandardInput:(NSString *)tip;

+ (BOOL)getBOOLFromStandardInput:(NSString *)tip;

@end
