//
//  NSDictionary+safeObjectForKey.m
//  toelibrary
//
//  Created by Shane on 14-7-25.
//  Copyright (c) 2014年 Shanesun All rights reserved.
//

#import "NSDictionary+safeObjectForKey.h"
#define checkNull(__X__)        (__X__) == [NSNull null] || (__X__) == nil ? @"" : [NSString stringWithFormat:@"%@", (__X__)]


@implementation NSDictionary (safeObjectForKey)


- (NSString *)safeObjectForKey:(id)key
{
    return checkNull([self objectForKey:key]);
}
- (BOOL)ss_getBoolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue {
    return [self objectForKey:key] == [NSNull null] ? defaultValue
    : [[self objectForKey:key] boolValue];
}

- (int)ss_getIntValueForKey:(NSString *)key defaultValue:(int)defaultValue {
    return [self objectForKey:key] == [NSNull null]
				? defaultValue : [[self objectForKey:key] intValue];
}
- (float)ss_getFloatValueForKey:(NSString*)key defaultValue:(float)defaultValue{
    return [self objectForKey:key] == [NSNull null]
    ? defaultValue : [[self objectForKey:key] intValue];
}

- (long long)ss_getLongLongValueValueForKey:(NSString *)key defaultValue:(long long)defaultValue {
    return [self objectForKey:key] == [NSNull null]
    ? defaultValue : [[self objectForKey:key] longLongValue];
}

- (NSString *)ss_getStringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue {
    return [self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null]
				? defaultValue : [self objectForKey:key];
}

@end