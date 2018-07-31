//
//  ViewController.m
//  LYFix
//
//  Created by 叶晓倩 on 2018/3/12.
//  Copyright © 2018年 acnc. All rights reserved.
//

#import "ViewController.h"
#import "LYFix.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (id)test:(NSString *)test test1:(NSInteger)test1{
    NSLog(@"xly--%@_____%ld",test,test1);
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObjectsFromArray:@[@(test1)]];
    return arr;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"Test" ofType:@"js"];
    NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
    [LYFix evalString:jsString];
    
    NSString *str = [self test:@"123" test1:123];
    NSLog(@"*****  xly--%@",str);
}


+ (UIViewController *)currentViewController {
    __block UIViewController *currentVC = nil;
    if ([NSThread isMainThread]) {
        @try {
            UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
            if (rootViewController != nil) {
                currentVC = [self getCurrentVCFrom:rootViewController];
            }
        } @catch (NSException *exception) {
        }
        return currentVC;
    } else {
        dispatch_sync(dispatch_get_main_queue(), ^{
            @try {
                UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
                if (rootViewController != nil) {
                    currentVC = [self getCurrentVCFrom:rootViewController];
                }
            } @catch (NSException *exception) {
            }
        });
        return currentVC;
    }
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    @try {
        UIViewController *currentVC;
        if ([rootVC presentedViewController]) {
            // 视图是被presented出来的
            rootVC = [rootVC presentedViewController];
        }
        
        if ([rootVC isKindOfClass:[UITabBarController class]]) {
            // 根视图为UITabBarController
            currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        } else if ([rootVC isKindOfClass:[UINavigationController class]]){
            // 根视图为UINavigationController
            currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        } else {
            // 根视图为非导航类
            currentVC = rootVC;
        }
        
        return currentVC;
    } @catch (NSException *exception) {
    }
}


@end
