//
//  TestViewController.m
//  ZZQRCode
//
//  Created by 张鹏 on 2018/2/1.
//  Copyright © 2018年 ZP. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"test";
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"viewDidLoad");
    UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(100,100,100,100)];
    alertLabel.text = @"Wait 4 seconds...";
    [self.view addSubview:alertLabel];

    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];
    [backgroundQueue addOperationWithBlock:^{
        [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:4]];

        dispatch_async(dispatch_get_main_queue(), ^{

           alertLabel.text = @"Ready to go!";
        });
    }];
    
    NSString *s1 = @"hello";
    NSString *s2 = s1;
    s2 = nil;
    NSLog(@"s2 ==%@",s2);
}

- (void)dealloc {
    
    NSLog(@"dealloc");
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
