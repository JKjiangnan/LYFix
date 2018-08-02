//
//  UIView+LYFix.m
//  LYFix
//
//  Created by xly on 2018/8/1.
//  Copyright © 2018年 Xly. All rights reserved.
//

#import "UIView+LYFix.h"

@implementation UIView (LYFix)

- (NSString *)fixTag {
    if (self.hadSetFixTag == NO) {
        if (self.tag != 0) {
            return [NSString stringWithFormat:@"%@%ld",NSStringFromClass(self.class),self.tag];
        }
    }
    return [super fixTag];
}

@end
