//
//  ZZQRCodeTableviewController.m
//  ZZQRCode
//
//  Created by 张鹏 on 2017/9/7.
//  Copyright © 2017年 ZP. All rights reserved.
//

#import "ZZQRCodeTableviewController.h"
#import "ZZQRCodeImageViewController.h"
#import "NSTimerViewController.h"

@interface ZZQRCodeTableviewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dateArr;

@end

@implementation ZZQRCodeTableviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"二维码";
    self.navigationItem.titleView.backgroundColor = [UIColor lightGrayColor];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.dateArr = [NSMutableArray arrayWithObjects:@"点击进入到扫一扫",@"输入文字或图片生成二维码",@"NSTimer", nil];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dateArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.dateArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 0) {
      [self loadLimitsAndIndexPath:indexPath.row];
    }
    else if (indexPath.row == 1) {
        
    }else if (indexPath.row == 2) {
        
        NSTimerViewController *next = [[NSTimerViewController alloc] init];
        [self.navigationController pushViewController:next animated:YES];
    }
}

//加载访问权限
- (void) loadLimitsAndIndexPath:(NSInteger)index{
    NSLog(@"---------index===%zd",index);
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self whereAreYouGoing:index];
                    });
                    NSLog(@"当前线程 - - %@", [NSThread currentThread]);
                    // 用户第一次同意了访问相机权限
                    NSLog(@"用户第一次同意了访问相机权限");
                } else {
                    // 用户第一次拒绝了访问相机权限
                    NSLog(@"用户第一次拒绝了访问相机权限");
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            NSLog(@"用户允许当前应用访问相机");
            [self whereAreYouGoing:index];
            
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - 盈科旅游] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertC addAction:alertA];
            [self presentViewController:alertC animated:YES completion:nil];
            
        } else if (status == AVAuthorizationStatusRestricted) {
            NSLog(@"因为系统原因, 无法访问相册");
        }
    } else {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertC addAction:alertA];
        [self presentViewController:alertC animated:YES completion:nil];
    }
}

- (void)whereAreYouGoing:(NSInteger)index {

    if (index == 0) {
        ZZQRCodeViewController *ZZQRCodeVC = [[ZZQRCodeViewController alloc] init];
        [self.navigationController pushViewController:ZZQRCodeVC animated:YES];
        
    }else if (index == 1)
    {
        ZZQRCodeImageViewController *ZZQRCodeImageVC = [[ZZQRCodeImageViewController alloc] init];
        [self.navigationController pushViewController:ZZQRCodeImageVC animated:YES];
    }
}


- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -64)];
    }
    return _tableView;
}

- (NSMutableArray *)dateArr {
    if (!_dateArr) {
        _dateArr = [NSMutableArray array];
    }
    return _dateArr;
}


@end
