//
//  CLUtils.m
//  WeChatPlugin Command Line Tools
//
//  Created by Shuang Wu on 2017/8/2.
//
//

#import "CLUtils.h"

NSString *const CLAr = @"/usr/bin/ar";
NSString *const CLTar = @"/usr/bin/tar";
NSString *const CLDefaults = @"/usr/bin/defaults";
NSString *const CLCodeSign = @"/usr/bin/codesign";
NSString *const CLChmod = @"/bin/chmod";
NSString *const CLMakeTemp = @"/usr/bin/mktemp";
NSString *const CLUnzip = @"/usr/bin/unzip";
NSString *const CLZip = @"/usr/bin/zip";
NSString *const CLSecurity = @"/usr/bin/security";

NSString *const CLMove = @"/bin/mv";
NSString *const CLCopy = @"/bin/cp";
NSString *const CLRemove = @"/bin/rm";
NSString *const CLOpen = @"/usr/bin/open";

@implementation CLUtils

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
