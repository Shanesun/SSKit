//
//  NSMutableDictionary+safeAddObjectForKey.m
//  SSKit
//
//  Created by Shane Li on 15/12/9.
//  Copyright © 2015年 Shane. All rights reserved.
//

#import "NSMutableDictionary+safeSetObjectForKey.h"
#import <objc/runtime.h>

@implementation NSMutableDictionary (safeSetObjectForKey)
+ (void)load{
    Method origMethod = class_getInstanceMethod(self, @selector(setObject:forKey:));
    Method changeMethod = class_getInstanceMethod(self, @selector(ss_setObject:forKey:));
    method_exchangeImplementations(changeMethod, origMethod);
}

- (void)ss_setObject:(id)object forKey:(NSString *)key{
    if (object == nil) {
        NSLog(@"setObject:nil ===============> %@",key);
        [self ss_setObject:[NSNull null] forKey:key];
    }
    else{
        [self ss_setObject:object forKey:key];
    }
    
}

@end
