//
//  ViewController.m
//  LYFix
//
//  Created by 叶晓倩 on 2018/3/12.
//  Copyright © 2018年 acnc. All rights reserved.
//

#import "ViewController.h"
#import "LYFix.h"
#import "LBYFixDemo.h"
#import "LBYFixDemo2.h"
#import "LBYFixDemo3.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *_dataSource;
}
//@property (nonatomic, strong) UIView *testView;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self view];
    // Do any additional setup after loading the view, typically from a nib.
//    [LYFix Fix];
    _dataSource = @[@"instance method crash", @"class method crash", @"run before instance method", @"run after instance method", @"run before class method", @"run after class method", @"run instance method has no params", @"run instance method has one param", @"run instance method has tow params", @"run instance method has multiple params", @"run class method has no params", @"run class method has one param", @"run class method has two params", @"run class method has multiple params"];
    
    [self.view addSubview:self.tableView];
//    UIView *view = [self view];
    
//    [self ];
  
//   NSString *a  = [self test];
    
//    NSLog(@"xly--%@",a);
    
}

- (id)test:(NSString *)test test1:(NSString*)test1{
    NSLog(@"xly--%@_____%@",test,test1);
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:test1];
    return arr;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"Test" ofType:@"js"];
    NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
    [LYFix evalString:jsString];
    
    NSString *str = [self test:@"123" test1:@"456"];
    NSLog(@"*****  xly--%@",str);
    return;
    NSLog(@"xly--%@",[ViewController currentViewController]);
    NSLog(@"xly--%@",[self tableView]);
//    return;
//    [LYFix runWithInstance:self.tableView selector:@"setHidden:" arguments:@[@0]];
//    [self.tableView setHidden:<#(BOOL)#>]
//    return;
    NSString *js = @"var result = runMethod('ViewController', 'currentViewController',Array());var tablview = runInstanceMethod(result, 'tableView',Array());runInstanceMethod(tablview,'setHidden:',Array('0'))";
    //    [self.view setBackgroundColor:<#(UIColor * _Nullable)#>]
    //    ;
    [LYFix evalString:js];
    
    JSValue *jsValue = [LYFix context][@"result"];
    NSLog(@"_____xly--%@",jsValue);
//    [_tableView setHidden:false];
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




#pragma mark - LBYFixDemo
- (void)instanceMethodCrash {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"InstanceMethodCrash" ofType:@"js"];
        NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
        [LYFix evalString:jsString];
    });
    
    LBYFixDemo *demo = [[LBYFixDemo alloc] init];
    [demo instanceMightCrash:nil];
    NSLog(@"instanceMethodCrash not crash");
}

- (void)classMethodCrash {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"ClassMethodCrash" ofType:@"js"];
        NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
        [LYFix evalString:jsString];
    });
    
    [LBYFixDemo2 classMightCrash:nil];
    NSLog(@"classMethodCrash not crash");
}

- (void)runBeforeInstanceMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"RunBeforeInstanceMethod" ofType:@"js"];
        NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
        [LYFix evalString:jsString];
    });
    
    LBYFixDemo *demo = [[LBYFixDemo alloc] init];
    [demo runBeforeInstanceMethod];
}

- (void)runAfterInstanceMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"RunAfterInstanceMethod" ofType:@"js"];
        NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
        [LYFix evalString:jsString];
    });
    
    LBYFixDemo *demo = [[LBYFixDemo alloc] init];
    [demo runAfterInstanceMethod];
}

- (void)runBeforeClassMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"RunBeforeClassMethod" ofType:@"js"];
        NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
        [LYFix evalString:jsString];
    });
    
    [LBYFixDemo2 runBeforeClassMethod];
}

- (void)runAfterClassMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"RunAfterClassMethod" ofType:@"js"];
        NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
        [LYFix evalString:jsString];
    });
    
    [LBYFixDemo2 runAfterClassMethod];
}

- (void)runInstanceMethodHasNoParams {
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"RunInstanceMethodHasNoParams" ofType:@"js"];
    NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
    [LYFix evalString:jsString];
}

- (void)runInstanceMethodHasOneParam {
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"RunInstanceMethodHasOneParam" ofType:@"js"];
    NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
    [LYFix evalString:jsString];
}

- (void)runInstanceMethodHasTwoParams {
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"RunInstanceMethodHasTwoParams" ofType:@"js"];
    NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
    [LYFix evalString:jsString];
}

- (void)runInstanceMethodHasMultipleParams {
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"RunInstanceMethodHasMultipleParams" ofType:@"js"];
    NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
    [LYFix evalString:jsString];
}

- (void)runClassMethodHasNoParams {
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"RunClassMethodHasNoParams" ofType:@"js"];
    NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
    [LYFix evalString:jsString];
}

- (void)runClassMethodHasOneParam {
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"RunClassMethodHasOneParam" ofType:@"js"];
    NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
    [LYFix evalString:jsString];
}

- (void)runClassMethodHasTwoParams {
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"RunClassMethodHasTwoParams" ofType:@"js"];
    NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
    [LYFix evalString:jsString];
}

- (void)runClassMethodHasMultipleParams {
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"RunClassMethodHasMultipleParams" ofType:@"js"];
    NSString *jsString = [NSString stringWithContentsOfFile:jsPath encoding:NSUTF8StringEncoding error:nil];
    [LYFix evalString:jsString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableviewcell"];
    if (indexPath.row < _dataSource.count) {
        cell.textLabel.text = _dataSource[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0: {[self instanceMethodCrash];}                   break;
        case 1: {[self classMethodCrash];}                      break;
        case 2: {[self runBeforeInstanceMethod];}               break;
        case 3: {[self runAfterInstanceMethod];}                break;
        case 4: {[self runBeforeClassMethod];}                  break;
        case 5: {[self runAfterClassMethod];}                   break;
        case 6: {[self runInstanceMethodHasNoParams];}          break;
        case 7: {[self runInstanceMethodHasOneParam];}          break;
        case 8: {[self runInstanceMethodHasTwoParams];}         break;
        case 9: {[self runInstanceMethodHasMultipleParams];}    break;
        case 10:{[self runClassMethodHasNoParams];}             break;
        case 11:{[self runClassMethodHasOneParam];}             break;
        case 12:{[self runClassMethodHasTwoParams];}            break;
        case 13:{[self runClassMethodHasMultipleParams];}       break;
        default:
            break;
    }
}

#pragma mark - setter / getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.hidden = YES;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableviewcell"];
    }
    return _tableView;
}

@end
