//
//  SpeedyDesktopViewController.m
//  ZZQRCode
//
//  Created by 张鹏 on 2019/1/28.
//  Copyright © 2019 ZP. All rights reserved.
//

#import "SpeedyDesktopViewController.h"

@interface SpeedyDesktopViewController ()

@end

@implementation SpeedyDesktopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSString *weburl = [NSString stringWithFormat:@"www.baidu.com"];
    
    NSDictionary *options = @{
                              UIApplicationOpenURLOptionUniversalLinksOnly : @YES
                              
                              };
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:weburl] options:options completionHandler:^(BOOL success) {
        NSLog(@"success");
    }];
    
    
    
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
