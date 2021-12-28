//
//  DemoModel.m
//  YYModelDemo
//
//  Created by LarryZhang on 2021/12/27.
//

#import "DemoModel.h"
#import <objc/runtime.h>

@implementation DemoModel


+ (NSString *)ServerAddress {
    return @"https://retoolapi.dev/wJoHGX/data";
}

#pragma mark ---- description
- (NSString *)description {
    return [self debugDescription];
}

- (NSString *)debugDescription {
    NSMutableString *desc = [NSStringFromClass([self class]) stringByAppendingString:@": {\n"].mutableCopy;
    unsigned int count;
    Ivar *ivar = class_copyIvarList([self class], &count);
    for (int i = 0 ; i < count ; i++) {
        Ivar iv = ivar[i];
        const char *name = ivar_getName(iv);
        NSString *strName = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:strName];
        [desc appendString:[NSString stringWithFormat:@"    %@: %@,\n", strName, value]];
    }
    free(ivar);
    
    [desc appendString:@"}"];
    return desc;
}

@end
