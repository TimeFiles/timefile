//
//  YYKitViewController.m
//  ZZQRCode
//
//  Created by 张鹏 on 2018/2/5.
//  Copyright © 2018年 ZP. All rights reserved.
//

#import "YYKitViewController.h"
#import "YYFPSLabel.h"
#import "YYKitTableViewCell.h"
#import "YYKitModel.h"

@interface YYKitViewController ()
<
    UITableViewDelegate, UITableViewDataSource
>

@property (nonatomic, strong) YYFPSLabel *fpsLabel;

@property (nonatomic, strong) NSMutableArray *dateArr;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) YYKitModel *model;
@end

@implementation YYKitViewController
{
    CADisplayLink *_link;
    NSUInteger _count;
    NSTimeInterval _lastTime;
    
    UILabel *label_;
    UITableView *table_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"YYKit测试帧数";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //数据源
    self.dateArr = [NSMutableArray arrayWithObjects:@"卡不卡,卡卡卡卡,bigChange",@"卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange",@"卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange",@"卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange",@"卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange",@"卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange",@"卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange",@"卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange",@"卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange",@"卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange",@"卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange卡不卡,卡卡卡卡,bigChange", nil];
    
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 200;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:_tableView];
    
    //    Demo1: FPS label 用法
    if (ISHIDDEN) {
        //如果是DEBUG模式 显示出来FPSLabel
        NSLog(@"YES");
        [self testFPSLabel];
    }else{
        NSLog(@"NO");
    }
    
    
    //    Demo2: 测试在子线程使用 timer
    //    [self testSubThread];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - FPS demo

- (void)testFPSLabel {
    _fpsLabel = [YYFPSLabel new];
    _fpsLabel.frame = CGRectMake(200, 200, 50, 30);
    [_fpsLabel sizeToFit];
    [self.view addSubview:_fpsLabel];
    
    // 如果直接用 self 或者 weakSelf，都不能解决循环引用问题
    
    // 移除也不能使 label里的 timer invalidate
    //        [_fpsLabel removeFromSuperview];
}

#pragma mark - 子线程 timer demo

- (void)testSubThread {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(200, 200, 100, 50)];
    label_ = label;
    label.backgroundColor = [UIColor grayColor];
    [table_ addSubview:label];
    
    
    // 开启子线程，新建 runloop， 避免主线程 阻塞时， timer不能用
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
        
        // NOTE: 子线程的runloop默认不创建； 在子线程获取 currentRunLoop 对象的时候，就会自动创建RunLoop
        
        // 这里不加到 main loop，必须创建一个 runloop
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        [_link addToRunLoop:runloop forMode:NSRunLoopCommonModes];
        
        // 必须 timer addToRunLoop 后，再run
        [runloop run];
    });
    
    // 模拟 主线程阻塞 （不应该模拟主线程卡死，模拟卡顿即可）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"即将阻塞");
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"同步阻塞主线程");
        });
        NSLog(@"不会执行");
    });
}

- (void)tick:(CADisplayLink *)link {
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    float fps = _count / delta;
    _count = 0;
    
    NSString *text = [NSString stringWithFormat:@"%d FPS",(int)round(fps)];
    
    // 尝试1：主线程阻塞， 这里就不能获取到主线程了
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //        //  阻塞时，想通过 在主线程更新UI 来查看是不可行了
    //        label_.text = text;
    //    });
    
    // 尝试2：不在主线程操作 UI ，界面会发生变化
    label_.text = text;
    
    NSLog(@"%@", text);
}

#pragma mark - other

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dateArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    YYKitTableViewCell*cell = [[NSBundle mainBundle] loadNibNamed:@"YYKitTableViewCell" owner:self options:nil].firstObject;
    cell.titleLabel.text = self.dateArr[indexPath.row];
    [cell layoutIfNeeded];
    CGFloat height = [cell.titleLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    NSLog(@"height--:%f",height);
    self.model.cell_height = height;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return self.model.cell_height+10;
}

- (NSMutableArray *)dateArr {
    
    if (_dateArr == nil) {
        _dateArr = [NSMutableArray array];
    }
    return _dateArr;
}

- (YYKitModel *)model {
    
    if (_model == nil) {
        _model = [[YYKitModel alloc] init];
    }
    return _model;
    
}
@end
