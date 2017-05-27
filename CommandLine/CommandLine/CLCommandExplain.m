//
//  CLCommandExplain.m
//  BaiduMusicBrowser
//
//  Created by Shuang Wu on 2017/3/9.
//  Copyright © 2017年 unique. All rights reserved.
//

#import "CLCommandExplain.h"
#import "CLArguments.h"

@interface CLCommandExplain ()

@property (nonatomic, strong) NSMutableDictionary *mKeyExplains;

@property (nonatomic, strong) NSMutableDictionary *mFlagExplains;

@end

@implementation CLCommandExplain

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setFlag:@"help" abbr:@"h" explain:@"print help"];
    }
    return self;
}

- (BOOL)hasAbbr:(NSString *)abbr ignoreKey:(NSString *)key {
    for (CLExplainItem *item in self.mKeyExplains.allValues) {
        if ([item.abbr isEqualToString:abbr] && ![item.key isEqualToString:key]) {
            return YES;
        }
    }
    for (CLExplainItem *item in self.mFlagExplains.allValues) {
        if ([item.abbr isEqualToString:abbr] && ![item.key isEqualToString:key]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)setKey:(NSString *)key abbr:(NSString *)abbr explain:(NSString *)explain {
    if (!key)                               return NO;
    if (abbr.length > 1)                    return NO;
    if ([self hasAbbr:abbr ignoreKey:key])  return NO;
    self.mKeyExplains[key] = [CLExplainItem itemWithKey:key abbr:abbr explain:explain];
    return YES;
}

- (BOOL)setFlag:(NSString *)flag abbr:(NSString *)abbr explain:(NSString *)explain {
    if (!flag)                               return NO;
    if (abbr.length > 1)                    return NO;
    if ([self hasAbbr:abbr ignoreKey:flag]) return NO;
    self.mFlagExplains[flag] = [CLExplainItem itemWithKey:flag abbr:abbr explain:explain];
    return YES;
}

- (void)printExplainWithTabCount:(NSUInteger)tabCount {
    NSMutableString *prefix = [NSMutableString string];
    for (int i = 0; i < tabCount; i++) {
        [prefix appendString:@"\t"];
    }
    
    for (CLExplainItem *item in self.mKeyExplains.allValues) {
        printf("%s", prefix.UTF8String);
        if (!item.isRequire) {
//            printf("[");
        }
//        printf("--%s", item.key.UTF8String);
//        if (item.abbr) {
            printf(" -%s", item.abbr.UTF8String);
//        }
        if (!item.isRequire) {
//            printf("]");
        }
        printf(" %s\n", item.explain.UTF8String);
    }
    
    for (CLExplainItem *item in self.mFlagExplains.allValues) {
        printf("%s", prefix.UTF8String);
        if (!item.isRequire) {
            printf("[");
        }
        printf("--%s", item.key.UTF8String);
        if (item.abbr) {
            printf(" -%s", item.abbr.UTF8String);
        }
        if (!item.isRequire) {
            printf("]");
        }
        printf(" %s\n", item.explain.UTF8String);
    }
}

- (CLExplainItem *)keyItemWithKey:(NSString *)key {
    return self.mKeyExplains[key];
}

- (CLExplainItem *)keyItemWithKeyAbbr:(NSString *)keyAbbr {
    for (CLExplainItem *item in self.mKeyExplains.allValues) {
        if ([item.abbr isEqualToString:keyAbbr]) {
            return item;
        }
    }
    return nil;
}

- (CLExplainItem *)flagItemWithFlag:(NSString *)flag {
    return self.mFlagExplains[flag];
}

- (CLExplainItem *)flagItemWithFlagAbbr:(NSString *)flagAbbr {
    for (CLExplainItem *item in self.mFlagExplains.allValues) {
        if ([item.abbr isEqualToString:flagAbbr]) {
            return item;
        }
    }
    return nil;
}

- (NSDictionary<NSString *,CLExplainItem *> *)keyExplains {
    return [self.mKeyExplains copy];
}

- (NSDictionary<NSString *,CLExplainItem *> *)flagExplains {
    return [self.mFlagExplains copy];
}

- (NSMutableDictionary *)mKeyExplains {
    if (!_mKeyExplains) {
        _mKeyExplains = [[NSMutableDictionary alloc] init];
    }
    return _mKeyExplains;
}

- (NSMutableDictionary *)mFlagExplains {
    if (!_mFlagExplains) {
        _mFlagExplains = [[NSMutableDictionary alloc] init];
    }
    return _mFlagExplains;
}

@end
