//
//  TestViewController.m
//  ZZQRCode
//
//  Created by 张鹏 on 2018/2/1.
//  Copyright © 2018年 ZP. All rights reserved.
//

#import "TestViewController.h"
#import "testku.h"

typedef NS_ENUM(NSInteger, sex) {
    man,
    woman
};

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
    //测试多线程sleep
//    [self testThread];
    //测试数组和字典排序操作
//    [self testArr];
    
    
    
    
    
    
}

- (void)testThread {
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

 -(void)testArr {
        NSMutableArray *testArr  = [NSMutableArray array];
         for (NSInteger i =0; i<100; i++) {
             [testArr addObject:@(i)];
             //100个耗时:0.000181 //100W个耗时:0.048270
         }
         NSLog(@"testArr--%@",@(testArr.count).stringValue);
         NSTimeInterval startTime = CFAbsoluteTimeGetCurrent();
         for (NSString *arrCount in testArr) {
             NSLog(@"arrCount-%@",arrCount);
             //耗时:6.533638
         }
     
         [testArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //耗时:0.030616  耗时:4.969065
             NSLog(@"--%@",obj);
     
         }];
     
    // 倒序遍历
         for (NSString *string in [testArr reverseObjectEnumerator]) {
             NSLog(@"倒序遍历---%@",string);
         }
     
         [testArr enumerateObjectsWithOptions:(NSEnumerationReverse) usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
     
             NSLog(@"倒序遍历---%@",obj);
         }];
     
         NSTimeInterval endTime = [[NSDate new] timeIntervalSinceReferenceDate];;
         NSLog(@"耗时:%f", endTime - startTime);
     
         NSDictionary *dict = @{@"a": @"1", @"e": @"5", @"b": @"3", @"d": @"4", @"c": @"2"};
         [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
     
             //无序的字典
             NSLog(@"key:-%@ ,obj:-%@",key,obj);
         }];
     
         NSArray *arr = dict.allValues;
         arr = [arr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
     
             NSComparisonResult result = [obj1 compare:obj2];
             return result;
         }];
         //按照升序和降序的顺序排序
         NSLog(@"dict ===%@",dict);
     
     
     
     
 }


- (void)dealloc {
    
    NSLog(@"dealloc");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [testku test];
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
