//
//  CLUtils.h
//  WeChatPlugin Command Line Tools
//
//  Created by Shuang Wu on 2017/8/2.
//
//

#import <Foundation/Foundation.h>

FOUNDATION_EXTERN NSString *const CLAr;
FOUNDATION_EXTERN NSString *const CLTar;
FOUNDATION_EXTERN NSString *const CLDefaults;
FOUNDATION_EXTERN NSString *const CLCodeSign;
FOUNDATION_EXTERN NSString *const CLChmod;
FOUNDATION_EXTERN NSString *const CLMakeTemp;
FOUNDATION_EXTERN NSString *const CLUnzip;
FOUNDATION_EXTERN NSString *const CLZip;
FOUNDATION_EXTERN NSString *const CLSecurity;

FOUNDATION_EXTERN NSString *const CLMove;
FOUNDATION_EXTERN NSString *const CLCopy;
FOUNDATION_EXTERN NSString *const CLRemove;
FOUNDATION_EXTERN NSString *const CLOpen;

@interface CLUtils : NSObject

/**
 *  Environment
 */

+ (NSString *)currentWorkDirectory;

+ (NSString *)fullPathWithPath:(NSString *)path;

@end
