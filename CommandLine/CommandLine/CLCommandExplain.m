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

@property (nonatomic, strong) NSMutableDictionary *mOptionalKeyExplains;

@property (nonatomic, strong) NSMutableDictionary *mFlagExplains;

@end

@implementation CLCommandExplain

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setFlag:@"help" abbr:@"h" explain:@"print help"];
        [self setFlag:@"verbose" abbr:@"v" explain:@"Log out infomation"];
    }
    return self;
}

- (BOOL)hasAbbr:(NSString *)abbr ignoreKey:(NSString *)key {
    for (CLExplainItem *item in self.mKeyExplains.allValues) {
        if ([item.abbr isEqualToString:abbr] && ![item.key isEqualToString:key]) {
            return YES;
        }
    }
    for (CLExplainItem *item in self.mOptionalKeyExplains.allValues) {
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

- (BOOL)setKey:(NSString *)key abbr:(NSString *)abbr optional:(BOOL)optional example:(NSString *)example explain:(NSString *)explain {
    return [self setKey:key abbr:abbr optional:optional defaultValue:nil example:example explain:explain];
}

- (BOOL)setKey:(NSString *)key abbr:(NSString *)abbr optional:(BOOL)optional defaultValue:(NSString *)defaultValue example:(NSString *)example explain:(NSString *)explain {
    if (!key)                               return NO;
    if (abbr.length > 1)                    return NO;
    if ([self hasAbbr:abbr ignoreKey:key])  return NO;
    self.mOptionalKeyExplains[key] = [CLExplainItem keyValueItemWithKey:key abbr:abbr optional:optional defaultValue:defaultValue example:example explain:explain];
    return YES;
}

- (BOOL)setFlag:(NSString *)flag abbr:(NSString *)abbr explain:(NSString *)explain {
    if (!flag)                               return NO;
    if (abbr.length > 1)                    return NO;
    if ([self hasAbbr:abbr ignoreKey:flag]) return NO;
    self.mFlagExplains[flag] = [CLExplainItem flagItemWithKey:flag abbr:abbr explain:explain];
    return YES;
}

- (void)printExplainWithTabCount:(NSUInteger)tabCount {
    NSMutableString *prefix = [NSMutableString string];
    for (int i = 0; i < tabCount; i++) {
        [prefix appendString:@"\t"];
    }
    
    for (CLExplainItem *item in self.mKeyExplains.allValues) {
        printf("%s", prefix.UTF8String);
        printf("--%s", item.key.UTF8String);
        if (item.abbr) {
            printf(" -%s", item.abbr.UTF8String);
        }
        if (item.example) {
            printf(" \"%s\"", item.example.UTF8String);
        }
        printf(":\n%s%s\n", [prefix stringByAppendingString:@"\t\t"].UTF8String, item.explain.UTF8String);
    }
    
    for (CLExplainItem *item in self.mOptionalKeyExplains.allValues) {
        printf("%s[--%s", prefix.UTF8String, item.key.UTF8String);
        if (item.abbr) {
            printf(" -%s", item.abbr.UTF8String);
        }
        if (item.example) {
            printf(" \"%s\"", item.example.UTF8String);
        }
        printf("]");
        printf(":\n%s%s\n", [prefix stringByAppendingString:@"\t\t"].UTF8String, item.explain.UTF8String);
    }
    
    for (CLExplainItem *item in self.mFlagExplains.allValues) {
        printf("%s", prefix.UTF8String);
        printf("--%s", item.key.UTF8String);
        if (item.abbr) {
            printf(" -%s", item.abbr.UTF8String);
        }
        printf(" %s\n", item.explain.UTF8String);
    }
}

- (CLExplainItem *)keyItemWithKey:(NSString *)key {
    if (self.mKeyExplains[key]) {
        return self.mKeyExplains[key];
    } else {
        return self.mOptionalKeyExplains[key];
    }
}

- (CLExplainItem *)keyItemWithKeyAbbr:(NSString *)keyAbbr {
    for (CLExplainItem *item in self.mKeyExplains.allValues) {
        if ([item.abbr isEqualToString:keyAbbr]) {
            return item;
        }
    }
    for (CLExplainItem *item in self.mOptionalKeyExplains.allValues) {
        if ([item.abbr isEqualToString:keyAbbr]) {
            return item;
        }
    }
    return nil;
}

- (BOOL)keyItemIsOptionalWithDefaultValue:(NSString *)key {
    return [self defaultValueForOptionalKey:key]?YES:NO;
}

- (NSString *)defaultValueForOptionalKey:(NSString *)key {
    CLExplainItem *item = [self keyItemWithKey:key];
    if (item.isOptional && item.defaultValue) {
        return item.defaultValue;
    } else {
        return nil;
    }
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
    NSMutableDictionary *keyExplains = [self.mKeyExplains mutableCopy];
    [keyExplains setValuesForKeysWithDictionary:self.mOptionalKeyExplains];
    return [keyExplains copy];
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

- (NSMutableDictionary *)mOptionalKeyExplains {
    if (!_mOptionalKeyExplains) {
        _mOptionalKeyExplains = [[NSMutableDictionary alloc] init];
    }
    return _mOptionalKeyExplains;
}

- (NSMutableDictionary *)mFlagExplains {
    if (!_mFlagExplains) {
        _mFlagExplains = [[NSMutableDictionary alloc] init];
    }
    return _mFlagExplains;
}

@end
