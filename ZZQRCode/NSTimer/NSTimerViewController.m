//
//  NSTimerViewController.m
//  ZZQRCode
//
//  Created by 张鹏 on 2017/12/5.
//  Copyright © 2017年 ZP. All rights reserved.
//

#import "NSTimerViewController.h"
#import <objc/runtime.h>

@interface NSTimerViewController ()

@end

@implementation NSTimerViewController {
    int number; //
    NSTimer *timers;
    UILabel *label;
    CFRunLoopTimerRef *ref;
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
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 150, 100, 30)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnclick {
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSLog(@"1Get Library path: %@",[path objectAtIndex:0]);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"2Get document path: %@",[paths objectAtIndex:0]);
    
//        /// 1. 通知Observers，即将进入RunLoop
//        /// 此处有Observer会创建AutoreleasePool: _objc_autoreleasePoolPush();
//        __CFRUNLOOP_IS_CALLING_OUT_TO_AN_OBSERVER_CALLBACK_FUNCTION__(kCFRunLoopEntry);
//        do {
//
//            /// 2. 通知 Observers: 即将触发 Timer 回调。
//            __CFRUNLOOP_IS_CALLING_OUT_TO_AN_OBSERVER_CALLBACK_FUNCTION__(kCFRunLoopBeforeTimers);
//            /// 3. 通知 Observers: 即将触发 Source (非基于port的,Source0) 回调。
//            __CFRUNLOOP_IS_CALLING_OUT_TO_AN_OBSERVER_CALLBACK_FUNCTION__(kCFRunLoopBeforeSources);
//            __CFRUNLOOP_IS_CALLING_OUT_TO_A_BLOCK__(block);
//
//            /// 4. 触发 Source0 (非基于port的) 回调。
//            __CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE0_PERFORM_FUNCTION__(source0);
//            __CFRUNLOOP_IS_CALLING_OUT_TO_A_BLOCK__(block);
//
//            /// 6. 通知Observers，即将进入休眠
//            /// 此处有Observer释放并新建AutoreleasePool: _objc_autoreleasePoolPop(); _objc_autoreleasePoolPush();
//            __CFRUNLOOP_IS_CALLING_OUT_TO_AN_OBSERVER_CALLBACK_FUNCTION__(kCFRunLoopBeforeWaiting);
//
//            /// 7. sleep to wait msg.
//            mach_msg() -> mach_msg_trap();
//
//
//            /// 8. 通知Observers，线程被唤醒
//            __CFRUNLOOP_IS_CALLING_OUT_TO_AN_OBSERVER_CALLBACK_FUNCTION__(kCFRunLoopAfterWaiting);
//
//            /// 9. 如果是被Timer唤醒的，回调Timer
//            __CFRUNLOOP_IS_CALLING_OUT_TO_A_TIMER_CALLBACK_FUNCTION__(timer);
//
//            /// 9. 如果是被dispatch唤醒的，执行所有调用 dispatch_async 等方法放入main queue 的 block
//            __CFRUNLOOP_IS_SERVICING_THE_MAIN_DISPATCH_QUEUE__(dispatched_block);
//
//            /// 9. 如果如果Runloop是被 Source1 (基于port的) 的事件唤醒了，处理这个事件
//            __CFRUNLOOP_IS_CALLING_OUT_TO_A_SOURCE1_PERFORM_FUNCTION__(source1);
//
//
//        } while (...);
//
//        /// 10. 通知Observers，即将退出RunLoop
//        /// 此处有Observer释放AutoreleasePool: _objc_autoreleasePoolPop();
//        __CFRUNLOOP_IS_CALLING_OUT_TO_AN_OBSERVER_CALLBACK_FUNCTION__(kCFRunLoopExit);

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
