//
//  CLArguments.m
//  BaiduMusicBrowser
//
//  Created by 吴双 on 2017/3/5.
//  Copyright © 2017年 unique. All rights reserved.
//

#import "CLArguments.h"
#import "CLCommandExplain.h"

static NSMutableDictionary *_key_and_description_;
static NSMutableDictionary *_flag_and_description_;



@interface CLArguments ()

@property (nonatomic, strong) CLCommandExplain *explain;

@property (nonatomic, strong) NSMutableDictionary<NSString *, CLCommandExplain *> *commandExplain;

@property (nonatomic, assign) NSUInteger IOPathMinimumCount;

@end

@implementation CLArguments

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setFlag:@"help" abbr:@"h" explain:@"print help"];
    }
    return self;
}

- (instancetype)initWithRequireCommand:(BOOL)requireCommand {
    self = [self init];
    if (self) {
        _requireCommand = requireCommand;
    }
    return self;
}

- (BOOL)setKey:(NSString *)key abbr:(NSString *)abbr explain:(NSString *)explain {
    return [self setKey:key abbr:abbr explain:explain forCommand:nil];
}

- (BOOL)setKey:(NSString *)key abbr:(NSString *)abbr explain:(NSString *)explain forCommand:(NSString *)command {
    if (command.length == 0) {
        return [self.explain setKey:key abbr:abbr explain:explain];
    }
    CLCommandExplain *commandExplain = self.commandExplain[command];
    if (!commandExplain) {
        commandExplain = [[CLCommandExplain alloc] init];
        self.commandExplain[command] = commandExplain;
    }
    return [commandExplain setKey:key abbr:abbr explain:explain];
}

- (BOOL)setFlag:(NSString *)flag abbr:(NSString *)abbr explain:(NSString *)explain {
    return [self setFlag:flag abbr:abbr explain:explain forCommand:nil];
}

- (BOOL)setFlag:(NSString *)flag abbr:(NSString *)abbr explain:(NSString *)explain forCommand:(NSString *)command {
    if (command.length == 0) {
        return [self.explain setFlag:flag abbr:abbr explain:explain];
    }
    CLCommandExplain *commandExplain = self.commandExplain[command];
    if (!commandExplain) {
        commandExplain = [[CLCommandExplain alloc] init];
        self.commandExplain[command] = commandExplain;
    }
    return [commandExplain setFlag:flag abbr:abbr explain:explain];
}

- (BOOL)setCommand:(NSString *)command explain:(NSString *)explain {
    if (command.length == 0) {
        return NO;
    }
    CLCommandExplain *commandExplain = self.commandExplain[command];
    if (!commandExplain) {
        commandExplain = [[CLCommandExplain alloc] init];
        self.commandExplain[command] = commandExplain;
    }
    commandExplain.explain = explain;
    return YES;
}

- (CLCommandExplain *)explain {
    if (!_explain) {
        _explain = [[CLCommandExplain alloc] init];
    }
    return _explain;
}

- (NSMutableDictionary<NSString *,CLCommandExplain *> *)commandExplain {
    if (!_commandExplain) {
        _commandExplain = [[NSMutableDictionary alloc] init];
    }
    return _commandExplain;
}

- (void)analyseArgumentCount:(NSUInteger)count values:(const char *[])argvs {
    
    
    NSMutableDictionary *keyValues = [NSMutableDictionary dictionary];
    NSMutableArray *flags = [NSMutableArray array];
    NSMutableArray *ioPaths = [NSMutableArray array];
    NSMutableArray *args = [NSMutableArray array];
    
    _executeFilePath = [NSString stringWithUTF8String:argvs[0]];
    [args addObject:_executeFilePath];
    
    CLCommandExplain *explain = nil;
    if (count > 1) {
        NSString *command = [NSString stringWithUTF8String:argvs[1]];
        explain = self.commandExplain[command];
        if (explain) {
            _command = command;
        } else {
            explain = self.explain;
        }
    }
    
    for (int i = _command ? 2 : 1; i < count; i++) {
        NSString *arg = [NSString stringWithUTF8String:argvs[i]];
        [args addObject:arg];
        
        if ([arg hasPrefix:@"--"]) {
            CLExplainItem *explainItem = nil;
            
            explainItem = [explain keyItemWithKey:[arg substringFromIndex:2]];
            if (explainItem) {
                NSUInteger nextIndex = i + 1;
                if (nextIndex < count) {
                    NSString *value = [NSString stringWithUTF8String:argvs[nextIndex]];
                    keyValues[explainItem.key] = value;
                    [args addObject:value];
                    i++;
                    continue;
                }
            }
            
            explainItem = [explain flagItemWithFlag:[arg substringFromIndex:2]];
            if (explainItem) {
                [flags addObject:explainItem.key];
                continue;
            }
        }
        
        if ([arg hasPrefix:@"-"]) {
            if (arg.length > 2) {
                // flag
                for (int j = 1; j < arg.length; j++) {
                    NSRange range = NSMakeRange(j, 1);
                    NSString *abbr = [arg substringWithRange:range];
                    CLExplainItem *explainItem = [explain flagItemWithFlagAbbr:abbr];
                    if (explainItem) {
                        [flags addObject:explainItem.key];
                    }
                }
            } else if (arg.length == 2) {
                NSRange range = NSMakeRange(1, 1);
                NSString *abbr = [arg substringWithRange:range];
                CLExplainItem *explainItem = [explain flagItemWithFlagAbbr:abbr];
                if (explainItem) {
                    [flags addObject:explainItem.key];
                } else {
                    explainItem = [explain keyItemWithKeyAbbr:abbr];
                    if (explainItem) {
                        NSUInteger nextIndex = i + 1;
                        if (nextIndex < count) {
                            NSString *value = [NSString stringWithUTF8String:argvs[nextIndex]];
                            keyValues[explainItem.key] = value;
                            [args addObject:value];
                            i++;
                            continue;
                        }
                    }
                }
            }
        }
        
        [ioPaths addObject:arg];
    }
    
    _keyValues = [keyValues copy];
    _flags = [flags copy];
    _ioPaths = [ioPaths copy];
    _allArgs = [args copy];
}

- (void)printExplainAndExist:(int)code {
    CLCommandExplain *commandExplain = self.explain;
    if (self.command) {
        commandExplain = self.commandExplain[self.command];
    }
    
    BOOL shouldPrint = [self.flags containsObject:@"help"];
    
    if (!shouldPrint && !self.command && self.requireCommand) {
        //  判断是否必须要命令
        shouldPrint = YES;
    }
    
    if (!shouldPrint) {
        //  判断必要参数是否存在
        for (CLExplainItem *item in commandExplain.keyExplains.allValues) {
            if (item.isRequire && ![self.keyValues.allKeys containsObject:item.key]) {
                shouldPrint = YES;
                break;
            }
        }
    }
    
    if (!shouldPrint) {
        //  判断必要flag是否存在
        for (CLExplainItem *item in commandExplain.flagExplains.allValues) {
            if (item.isRequire && ![self.flags containsObject:item.key]) {
                shouldPrint = YES;
                break;
            }
        }
    }
    
    if (!shouldPrint && self.IOPathMinimumCount) {
        shouldPrint = self.ioPaths.count >= self.IOPathMinimumCount;
    }
    
    if (shouldPrint) {
        [self printExplain:commandExplain];
        exit(code);
    }
}

- (void)printExplain:(CLCommandExplain *)explain {
    if (self.explain == explain) {
        if (self.commandExplain.count > 0) {
            printf("Usage: %s command\ncommands are:\n", self.executeFilePath.lastPathComponent.UTF8String);
            for (NSString *command in self.commandExplain.allKeys) {
                CLCommandExplain *commandExplain = self.commandExplain[command];
                printf("\t%s: %s\n", command.UTF8String, commandExplain.explain.UTF8String);
                [commandExplain printExplainWithTabCount:2];
                printf("\n");
            }
        } else {
            printf("Usage: %s\n", self.executeFilePath.lastPathComponent.UTF8String);
            [explain printExplainWithTabCount:1];
        }
    } else {
        printf("Usage: %s %s\n", self.executeFilePath.lastPathComponent.UTF8String, self.command.UTF8String);
        printf("       %s\n", explain.explain.UTF8String);
        [explain printExplainWithTabCount:1];
    }
    printf("\n");
}

- (BOOL)hasKey:(NSString *)key {
	return self.keyValues[key]?YES:NO;
}

- (BOOL)hasFlags:(NSString *)flags {
	return [self.flags containsObject:flags];
}

- (NSString *)stringValueForKey:(NSString *)key {
	return self.keyValues[key];
}

- (NSNumber *)numberValueForKey:(NSString *)key {
	NSString *value = [self stringValueForKey:key];
	if (value) {
		NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
		[formatter setNumberStyle:NSNumberFormatterNoStyle];
		return [formatter numberFromString:value];
	} else {
		return nil;
	}
}

- (NSString *)fullPathValueForKey:(NSString *)key {
	NSString *value = [self stringValueForKey:key];
	if (value) {
		return [CLArguments fullPathWithPath:value];
	} else {
		return nil;
	}
}

- (NSString *)fullIOPathAtIndex:(NSUInteger)index {
	if (index >= self.ioPaths.count) {
		return nil;
	} else {
		return [CLArguments fullPathWithPath:self.ioPaths[index]];
	}
}

+ (NSString *)currentWorkDirectory {
	return [NSString stringWithUTF8String:getcwd(NULL, 0)];
}

+ (NSString *)fullPathWithPath:(NSString *)path {
    
    if ([path hasPrefix:@"~"]) {
        path = [path stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:NSHomeDirectory()];
    }
    
    else if (![path hasPrefix:@"/"]) {
        path = [self.currentWorkDirectory stringByAppendingPathComponent:path];
    }
    
    NSMutableArray *folders = [NSMutableArray arrayWithArray:[path componentsSeparatedByString:@"/"]];
    
	NSMutableArray *formatFolders = [NSMutableArray array];
	for (NSString *folder in folders) {
		if (folder.length == 0) {
			continue;
		}
		
		if ([folder isEqualToString:@"."]) {
			continue;
		} else if ([folder isEqualToString:@".."]) {
			[formatFolders removeLastObject];
		} else {
			[formatFolders addObject:folder];
		}
	}
	
	NSMutableString *fullPath = [NSMutableString string];
	for (NSString *folder in formatFolders) {
		[fullPath appendFormat:@"/%@", folder];
	}
	
	return [fullPath copy];
}

@end
