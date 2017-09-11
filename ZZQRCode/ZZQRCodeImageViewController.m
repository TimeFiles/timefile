//
//  ZZQRCodeImageViewController.m
//  ZZQRCode
//
//  Created by 张鹏 on 2017/9/11.
//  Copyright © 2017年 ZP. All rights reserved.
//

#import "ZZQRCodeImageViewController.h"

@interface ZZQRCodeImageViewController ()

@end

@implementation ZZQRCodeImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self loadImageView];
}

- (void)loadImageView {

    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, SCREEN_WIDTH -40, 30)];
    textField.placeholder = @"输入文字";
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textField];
    
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
