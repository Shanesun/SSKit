//
//  NSNull+InternalNullExtention.m
//  SSKit
//
//  Created by Shane Li on 15/12/9.
//  Copyright © 2015年 Shane. All rights reserved.
//

#import "NSNull+InternalNullExtention.h"
#define NSNullObjects @[@"",@0,@{},@[]]

@implementation NSNull (InternalNullExtention)
- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
    if (!signature) {
        for (NSObject *object in NSNullObjects) {
            signature = [object methodSignatureForSelector:selector];
            if (signature) {
                break;
            }
        }
        
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL aSelector = [anInvocation selector];
    
    for (NSObject *object in NSNullObjects) {
        if ([object respondsToSelector:aSelector]) {
            [anInvocation invokeWithTarget:object];
            return;
        }
    }
    NSLog(@"[null %@] ===============> method forward",NSStringFromSelector(aSelector));
    [self doesNotRecognizeSelector:aSelector];
}
@end
