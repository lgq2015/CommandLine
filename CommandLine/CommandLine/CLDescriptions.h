//
//  CLDescriptions.h
//  BaiduMusicBrowser
//
//  Created by Shuang Wu on 2017/3/9.
//  Copyright © 2017年 unique. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLDescriptions : NSObject

@property (nonatomic, strong, readonly) NSDictionary<NSString *, NSString *> *keyDescriptions;

@property (nonatomic, strong, readonly) NSDictionary<NSString *, NSString *> *flagDescriptions;

- (void)addKey:(NSString *)key description:(NSString *)description;

- (void)addFlag:(NSString *)flag description:(NSString *)description;

@end
