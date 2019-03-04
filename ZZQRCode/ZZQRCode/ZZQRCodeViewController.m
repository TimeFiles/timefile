//
//  ZZQRCodeViewController.m
//  ZZQRCode
//
//  Created by 张鹏 on 2017/8/3.
//  Copyright © 2017年 ZP. All rights reserved.
//

#import "ZZQRCodeViewController.h"
#import "ZZQRCodeScanningView.h"
#import "ZZQRCodeManager.h"
#import "ZZQRCodeFinallyViewController.h"

@interface ZZQRCodeViewController ()
<
    ZZQRCodeManagerDelegate
>

@property (nonatomic, strong) ZZQRCodeScanningView *scanningView;

@property (nonatomic,strong) UILabel *navagationLabel;

@property (nonatomic, copy) NSString *big_categree_id;

@property (nonatomic, copy) NSString *productId;

@end

@implementation ZZQRCodeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.navigationController.navigationBar.translucent = YES;
    
    //加载扫描视图 放在这 防止pop回来的时候显示空白页
    [self scanQRCodeMethod];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.scanningView addTimer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.scanningView removeTimer];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)dealloc {
    NSLog(@"ZZQRCodeScanningVC - dealloc");
    [self removeScanningView];
}

- (void)removeScanningView {
    [self.scanningView removeTimer];
    [self.scanningView removeFromSuperview];
    self.scanningView = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavigationBar];
    self.title = @"二维码扫描";
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.scanningView];
}
- (void)customNavigationBar {
    
    UIButton * left = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    [left setImage:[UIImage imageNamed:@"NaviBackImageWhie"] forState:UIControlStateNormal];
    [left addTarget:self action:@selector(leftBackItemClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left];
    
    self.navagationLabel = [[UILabel alloc] init];
    self.navagationLabel.text = @"二维码扫描";
    self.navagationLabel.textColor = [UIColor whiteColor];
    [self.navagationLabel sizeToFit];
    self.navigationItem.titleView = self.navagationLabel;
}

- (void)leftBackItemClick:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scanQRCodeMethod {
    // 扫描二维码创建
    ZZQRCodeManager *manager = [ZZQRCodeManager sharedZZCodeManager];
    [manager ZZ_videoPreviewLayerRemoveFromSuperlayer];
    manager.currentVC = self;
    NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    // AVCaptureSessionPreset1920x1080 推荐使用，对于较小的二维码识别率较高
    [manager ZZ_setupSessionPreset:AVCaptureSessionPreset1920x1080 metadataObjectTypes:arr];
    manager.delegate = self;
    // 从相册中读取二维码方法
    //    [[SGQRCodeManager sharedQRCodeManager] SG_readQRCodeFromAlbum];
}

- (void)manager:(ZZQRCodeManager *)manager didOutputMetadataObjects:(NSArray *)metadataObjects {

    NSLog(@"metadataObjects - - %@", metadataObjects);
    if (metadataObjects != nil && metadataObjects.count > 0) {
        [manager ZZ_palySoundName:@"sound.caf"];
        [manager ZZ_stopRunning];
        //        [manager SG_videoPreviewLayerRemoveFromSuperlayer];
        
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        NSLog(@"扫描的结果是%@", [obj stringValue]);
        ZZQRCodeFinallyViewController *finallyVC = [[ZZQRCodeFinallyViewController alloc] init];
        finallyVC.titleLabelStr = [obj stringValue];
        [self.navigationController pushViewController:finallyVC animated:YES];
        
    }
}

#pragma mark - 从相册中读取二维码的代理方法
// 取消选择照片的代理方法
- (void)manager:(ZZQRCodeManager *)manager imagePickerControllerDidCancel:(UIImagePickerController *)picker {

    NSLog(@"取消选择照片的代理方法");
}

// 选择照片完成的代理方法
- (void)manager:(ZZQRCodeManager *)manager imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"选择照片完成的代理方法");
}


- (ZZQRCodeScanningView *)scanningView {
    if (!_scanningView) {
        _scanningView = [ZZQRCodeScanningView scanningViewWithFrame:self.view.bounds layer:self.view.layer];
        _scanningView.backgroundColor = [UIColor clearColor];
    }
    return _scanningView;
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
