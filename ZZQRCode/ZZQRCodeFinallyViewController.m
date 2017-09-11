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
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH -40, SCREEN_HEIGHT -64)];
    label.text = self.titleLabelStr;
    [self.view addSubview:label];
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
