//
//  TestViewController.m
//  ZZQRCode
//
//  Created by 张鹏 on 2018/2/1.
//  Copyright © 2018年 ZP. All rights reserved.
//

#import "TestViewController.h"

typedef NS_ENUM(NSInteger, sex) {
    man,
    woman
};

@interface TestViewController ()<NSCopying>

@property (nonatomic, copy) NSString *name;

@end

@implementation TestViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}

- (id)copyWithZone:(NSZone *)zone {
    
    TestViewController *testCopy = [[self class] allocWithZone:nil];
    
    return testCopy;
}
- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear");
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//
//    TestHeaderViewController *next = [[TestHeaderViewController alloc] init];
//    [self.navigationController pushViewController:next animated:YES];
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"test";
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"viewDidLoad");
    //测试多线程sleep
//    [self testThread];
    //测试数组和字典排序操作
//    [self testArr];
    
    //测试线程死锁
//    [self testDispatch];

    //测试归档
//    [self testNSSearchPath];
    
    
    //runtime 交换方法
    [self runtime];
    
    
    
}

- (void)runtime {
    
    UIImage *image = [UIImage imageNamed:@"Home_diamond"];
    
    
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
     
     [testArr enumerateObjectsUsingBlock:^(NSIndexPath *path, NSUInteger idx, BOOL * _Nonnull stop) {
         
         
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testDispatch {
    
    NSLog(@"1");
    //死锁
    //    dispatch_sync(dispatch_get_main_queue(), ^{
    //
    //    });
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"2");
        
    });
    NSLog(@"3");
    
    
    NSArray *array = @[@"a", @"b", @"c"];
    @try {
        // 可能抛出异常的代码
        [array objectAtIndex:3];
    }
    @catch (NSException *exception) {
        // 处理异常
        NSLog(@"throw an exception: %@", exception.reason);
    }
    @finally {
        NSLog(@"finally execution");
    }
    
    NSArray *aArray = @[@[@"a", @"b"], @[@"c", @"d"]];
    NSLog(@"aArray----%p",aArray);
    NSArray *bArray = [NSArray arrayWithArray:aArray];
    NSLog(@"bArray----%p",bArray);
    NSArray *cArray = [NSKeyedUnarchiver unarchiveTopLevelObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:aArray] error:nil];
    NSLog(@"cArray----%p",cArray);
    
}

- (void)testNSSearchPath {
#pragma mark --- 归档和解档
    //1.获取文件路径
    NSString *docPath=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //2、添加储存的文件名
    NSString *path  = [docPath stringByAppendingPathComponent:@"data.archiver"];
    //3、将一个对象保存到文件中
    //    NSArray *abc = @[@"1",@"2",@"3"];
    NSDictionary *dict = @{
                           @"abc":@"123",
                           @"def":@"234"
                           };
    BOOL flag = [NSKeyedArchiver archiveRootObject:dict toFile:path];
    
    if (flag) {
        NSLog(@"success");
    }else
    {
        NSLog(@"error");
    }
    id a = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    
    NSLog(@"---%@",[a class]);
    if ([a isKindOfClass:[NSArray class]]) {
        NSLog(@"NSArray");
    }else if ([a isKindOfClass:[NSDictionary class]]) {
        NSLog(@"NSDictionary");
    }else if ([a isKindOfClass:[NSString class]]) {
        NSLog(@"NSString");
    }
    
    NSDictionary *d = [[NSDictionary alloc] initWithDictionary:dict copyItems:YES];
    NSLog(@"dict---%p",dict);
    NSLog(@"d---%p",d);
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
