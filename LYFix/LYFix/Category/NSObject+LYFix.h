//
//  NSObject+LYFix.h
//  LYFix
//
//  Created by xly on 2018/8/1.
//  Copyright © 2018年 Xly. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject (LYFix)

@property (nonatomic, copy) NSString *fixTag;
@property (nonatomic, assign) BOOL hadSetFixTag;

@end
