//
//  MasonryViewController.m
//  ZZQRCode
//
//  Created by 张鹏 on 2018/4/4.
//  Copyright © 2018年 ZP. All rights reserved.
//

#import "MasonryViewController.h"

@interface MasonryViewController ()

@end

@implementation MasonryViewController

- (void)loadView {
    
    NSLog(@"loadView");
    NSTimeInterval startTime = CFAbsoluteTimeGetCurrent();
    
    UIView *testView = [[UIView alloc] init];
    testView.frame = CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), SCREEN_WIDTH, SCREEN_HEIGHT);
    testView.backgroundColor = [UIColor redColor];
    NSLog(@"%@",NSStringFromCGRect(testView.frame));
    self.view = testView;
    
    
    // 450 for iPad and 300 for iPhone
    CGFloat height = [[UIDevice currentDevice].model hasPrefix:@"iPad"] ? 450 : 300;
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 64, testView.frame.size.width, height)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.backgroundColor = [UIColor whiteColor];
    calendar.appearance.headerMinimumDissolvedAlpha = 0;
    calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase;
    [self.view addSubview:calendar];
    self.calendar = calendar;
    
    UIButton *previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    previousButton.frame = CGRectMake(0, 64+5, 95, 34);
    previousButton.backgroundColor = [UIColor whiteColor];
    previousButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [previousButton setImage:[UIImage imageNamed:@"icon_prev"] forState:UIControlStateNormal];
    [previousButton addTarget:self action:@selector(previousClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:previousButton];
    self.previousButton = previousButton;
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(CGRectGetWidth(self.view.frame)-95, 64+5, 95, 34);
    nextButton.backgroundColor = [UIColor whiteColor];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [nextButton setImage:[UIImage imageNamed:@"icon_next"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    self.nextButton = nextButton;
    NSTimeInterval endTime = [[NSDate new] timeIntervalSinceReferenceDate];;
    NSLog(@"耗时:%f", endTime - startTime);

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Masonry";
//    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"Masonry");
    
    [UIView  animateWithDuration:1.0 animations:^{
        
        self.view.alpha = 0.5;
    }];
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
