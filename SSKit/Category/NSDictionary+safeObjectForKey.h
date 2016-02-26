//
//  NSDictionary+safeObjectForKey.h
//  toelibrary
//
//  Created by Shane on 14-7-25.
//  Copyright (c) 2014年 Shanesun All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSDictionary (safeObjectForKey)
- (NSString *)safeObjectForKey:(id)key;
- (BOOL)ss_getBoolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
- (int)ss_getIntValueForKey:(NSString *)key defaultValue:(int)defaultValue;
- (long long)ss_getLongLongValueValueForKey:(NSString *)key defaultValue:(long long)defaultValue;
- (NSString *)ss_getStringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (float)ss_getFloatValueForKey:(NSString*)key defaultValue:(float)defaultValue;
@end

