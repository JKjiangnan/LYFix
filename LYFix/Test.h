//
//  Test.h
//  LYFix
//
//  Created by xly on 2018/7/31.
//  Copyright © 2018年 Xly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Test : NSObject

- (void)instanceMethodCrash:(NSString *)string;
+ (void)calssMethodCrash:(NSString *)string;

+ (void)runBeforeClassMethod;
- (void)runBeforeInstanceMethod;

+ (void)runAfterClassMethod;
- (void)runAfterInstanceMethod;

+ (void)runInsteadClassMethod;
- (void)runInsteadInstanceMethod;

+ (void)log;

@end
