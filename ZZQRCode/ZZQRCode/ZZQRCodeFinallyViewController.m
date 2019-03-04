//
//  ZZQRCodeFinallyViewController.m
//  ZZQRCode
//
//  Created by 张鹏 on 2017/9/11.
//  Copyright © 2017年 ZP. All rights reserved.
//

#import "ZZQRCodeFinallyViewController.h"

@interface ZZQRCodeFinallyViewController ()

@end

@implementation ZZQRCodeFinallyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫描结果";
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH -40, SCREEN_HEIGHT -64)];
    label.text = self.titleLabelStr;
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
