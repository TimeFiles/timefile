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
    int number; //
    NSTimer *timers;
    UILabel *label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"倒计时";
    self.view.backgroundColor = [UIColor whiteColor];
    number = 10;
    label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    label.text = [NSString stringWithFormat:@"%d秒倒计时",number];
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
    //当使用NSTimer的scheduledTimerWithTimeInterval方法时。事实上此时Timer会被加入到当前线程的Run Loop中，且模式是默认的NSDefaultRunLoopMode。而如果当前线程就是主线程，也就是UI线程时，某些UI事件，比如UIScrollView的拖动操作，会将Run Loop切换成NSEventTrackingRunLoopMode模式，在这个过程中，默认的NSDefaultRunLoopMode模式中注册的事件是不会被执行的。也就是说，此时使用scheduledTimerWithTimeInterval添加到Run Loop中的Timer就不会执行。
    //所以为了设置一个不被UI干扰的Timer，我们需要手动创建一个Timer，然后使用NSRunLoop的addTimer:forMode:方法来把Timer按照指定模式加入到Run Loop中。这里使用的模式是：NSRunLoopCommonModes，这个模式等效于NSDefaultRunLoopMode和NSEventTrackingRunLoopMode的结合。
    [[NSRunLoop mainRunLoop] addTimer:timers forMode:NSRunLoopCommonModes];
}

- (void)ChangeTimers {
    
    if (number <= 0) {
        number = 60;
        label.userInteractionEnabled = YES;
        label.text = @"获取验证码";
        [timers invalidate];
    }else{
        number--;
        label.text = [NSString stringWithFormat:@"%d秒后重发",number];
        label.userInteractionEnabled = NO;
    }
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
