//
//  NSTimerViewController.m
//  ZZQRCode
//
//  Created by 张鹏 on 2017/12/5.
//  Copyright © 2017年 ZP. All rights reserved.
//

#import "NSTimerViewController.h"

@interface NSTimerViewController ()

@end

@implementation NSTimerViewController {
    NSInteger number; //
    NSTimer *timers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    number = 10;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    label.text = [NSString stringWithFormat:@"%zd秒倒计时",number];
    label.userInteractionEnabled = YES; // 不设置此属性 ,触发不了手势方法
    label.backgroundColor = [UIColor redColor];
    label.textColor = [UIColor whiteColor];
    [self.view addSubview:label];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taps)];
    [label addGestureRecognizer:tap];
}

- (void)taps {
    NSLog(@"点击验证码");
    
    timers = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(ChangeTimers) userInfo:nil repeats:YES];
    
}

- (void)ChangeTimers {
    
    
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
