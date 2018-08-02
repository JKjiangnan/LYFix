//
//  NSObject+LYFix.m
//  LYFix
//
//  Created by xly on 2018/8/1.
//  Copyright © 2018年 Xly. All rights reserved.
//

#import "NSObject+LYFix.h"
#import "LYFix.h"
#import <objc/runtime.h>

@implementation NSObject (LYFix)

- (void)setFixTag:(NSString *)fixTag {
    self.hadSetFixTag = YES;
    objc_setAssociatedObject(self, @selector(fixTag), fixTag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)fixTag {
    NSString *fixTag = objc_getAssociatedObject(self, _cmd);
    if (!fixTag) {
        fixTag = NSStringFromClass(self.class);
    }
    return fixTag;
}

- (void)setHadSetFixTag:(BOOL)hadSetFixTag {
    objc_setAssociatedObject(self, @selector(hadSetFixTag), @(hadSetFixTag), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)hadSetFixTag {
   return [objc_getAssociatedObject(self, _cmd) boolValue];
}

@end
