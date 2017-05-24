//
//  CLDescriptions.m
//  BaiduMusicBrowser
//
//  Created by Shuang Wu on 2017/3/9.
//  Copyright © 2017年 unique. All rights reserved.
//

#import "CLDescriptions.h"

@interface CLDescriptions ()

@property (nonatomic, strong) NSMutableDictionary *mKeyDescs;

@property (nonatomic, strong) NSMutableDictionary *mFlagDescs;

@end

@implementation CLDescriptions

- (void)addKey:(NSString *)key description:(NSString *)description {
    self.mKeyDescs[key] = description?description:@"";
}

- (void)addFlag:(NSString *)flag description:(NSString *)description {
    self.mFlagDescs[flag] = description?description:@"";
}

- (NSDictionary<NSString *,NSString *> *)keyDescriptions {
    return [self.mKeyDescs copy];
}

- (NSDictionary<NSString *,NSString *> *)flagDescriptions {
    return [self.mFlagDescs copy];
}

- (NSMutableDictionary *)mKeyDescs {
    if (!_mKeyDescs) {
        _mKeyDescs = [[NSMutableDictionary alloc] init];
    }
    return _mKeyDescs;
}

- (NSMutableDictionary *)mFlagDescs {
    if (!_mFlagDescs) {
        _mFlagDescs = [[NSMutableDictionary alloc] init];
    }
    return _mFlagDescs;
}

@end
