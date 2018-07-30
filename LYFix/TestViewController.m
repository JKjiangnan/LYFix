//
//  TestViewController.m
//  LYFix
//
//  Created by xly on 2018/7/26.
//  Copyright © 2018年 Xly. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    // Do any additional setup after loading the view.
}

+ (void)test:(NSInteger)count {
    NSLog(@"xly--%@",@(count));
//    return count;
}
- (void)instanceMethodHasTwoParams:(int)param1 param2:(CGFloat)param2 {
    NSLog(@"instanceMethodHasTwoParams: param1 = %i, param2 = %f", param1, param2);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
