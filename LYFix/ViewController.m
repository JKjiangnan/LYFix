//
//  ViewController.m
//  LYFix
//
//  Created by xly on 2018/7/25.
//  Copyright © 2018年 Xly. All rights reserved.
//

#import "ViewController.h"
#import "LYFix.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "Test.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIView *myView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [UILabel new];
    
//    CGRect re =  {{20,20},{50,50}};
//    [label setFrame: {{20,20},{50,50}}];
////    [label sizeToFit]
    
    NSLog(@"xly--%@",NSStringFromCGRect(CGRectMake(100, 101, 102, 103)));
    
     self.myView = self.view;
     [self.myView setBackgroundColor:[UIColor redColor]];
    self.dataSource = @[@"instanceMethodCrash",@"calssMethodCrash",@"runBeforeClassMethod",@"runBeforeInstanceMethod",@"runAfterInstanceMethod",@"runAfterClassMethod",@"runInsteadClassMethod",@"runInsteadInstanceMethod",@"changePrames",@"changeReturnValue"].mutableCopy;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        for (NSString *js1 in self.dataSource) {
            NSString *jsPath = [[NSBundle mainBundle] pathForResource:js1 ofType:@"js"];
            NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
            [LYFix evalString:jsString];
        }
    });

    NSArray *runArray = @[@"runClassMethod",@"runInstanceMethod",@"runWithInstanceMethod",@"runWithParams"];
    [self.dataSource addObjectsFromArray:runArray];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.frame = CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height - 50);
    [self.view addSubview:_tableView];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fix"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"fix"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *js = self.dataSource[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([js isEqualToString:@"instanceMethodCrash"]) {
        Test *te = [[Test alloc] init];
        [te instanceMethodCrash:nil];
    } else if ([js isEqualToString:@"calssMethodCrash"]) {
        [Test calssMethodCrash:nil];
    } else if ([js isEqualToString:@"changePrames"]) {
        Test *te = [[Test alloc] init];
        NSString *str = [te changePrames:nil];
        NSLog(@"new params xly--%@",str);
    } else if ([js isEqualToString:@"changeReturnValue"]) {
        NSString *str = [Test changeReturnValue:nil];
        NSLog(@"new  returenValue xly--%@",str);
    } else if ([js isEqualToString:@"runClassMethod"]) {
        NSString *jsPath = [[NSBundle mainBundle] pathForResource:js ofType:@"js"];
        NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
        NSNumber *len = [LYFix evalString:jsString];
        NSLog(@"xly--%ld",len.integerValue);
    } else if ([js isEqualToString:@"runInstanceMethod"]) {
        NSString *jsPath = [[NSBundle mainBundle] pathForResource:js ofType:@"js"];
        NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
        NSString *str = [LYFix evalString:jsString];
        NSLog(@"xly--%@",str);
    } else if ([js isEqualToString:@"runWithInstanceMethod"]) {
        NSString *jsPath = [[NSBundle mainBundle] pathForResource:js ofType:@"js"];
        NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
        [LYFix evalString:jsString];
        NSLog(@"xly--self=== %@",self);
//        [self lyFix];

    } else if ([js isEqualToString:@"runWithParams"]) {
        NSString *jsPath = [[NSBundle mainBundle] pathForResource:js ofType:@"js"];
        NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
        [LYFix evalString:jsString];
       NSArray *arr =  [Test runWithParams:@[@"2222"]];
        NSLog(@"xly--%@",arr);
    }
    else {
        [LYFix runWithClassname:@"Test" selector:js arguments:nil];
    }
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
