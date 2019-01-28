//
//  GCDViewController.m
//  ZZQRCode
//
//  Created by 张鹏 on 2017/12/19.
//  Copyright © 2017年 ZP. All rights reserved.
//

#import "GCDViewController.h"
#import "GCDTool.h"

@interface GCDViewController ()

@property (nonatomic, strong) UILabel *timerLabel;

@property (nonatomic,strong) FBShimmeringView *shimmeringView;
@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"GCD";
    self.view.backgroundColor = [UIColor whiteColor];
    self.shimmeringView = [[FBShimmeringView alloc] initWithFrame:CGRectMake(100, 100, SCREEN_WIDTH -200, 30)];
    [self.view addSubview:self.shimmeringView];
    
    self.timerLabel = [[UILabel alloc] initWithFrame:self.shimmeringView.bounds];
    self.timerLabel.layer.cornerRadius = 5.0;
    self.timerLabel.text = NSLocalizedString(@"获取验证码", nil);
    self.timerLabel.layer.borderWidth = 1;
    self.timerLabel.layer.borderColor = [UIColor grayColor].CGColor;
    self.timerLabel.textAlignment = NSTextAlignmentCenter;
    self.timerLabel.layer.masksToBounds = YES;
    self.timerLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sendCodeTouched:)];
    [self.timerLabel addGestureRecognizer:tap];
    
    self.shimmeringView.contentView = self.timerLabel;
    self.shimmeringView.shimmering = YES;

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //自动启动timer
    [GCDTool timerCountDownWithKey:kTimerKeyRegister tipLabel:self.timerLabel forceStart:NO];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    //取消timer
    [GCDTool cancelTimerByKey:kTimerKeyRegister];
}

- (void)sendCodeTouched:(id)sender {
    
    [GCDTool startTimerWithKey:kTimerKeyRegister tipLabel:self.timerLabel];
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
