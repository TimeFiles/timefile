//
//  ZZQRCodeImageViewController.m
//  ZZQRCode
//
//  Created by 张鹏 on 2017/9/11.
//  Copyright © 2017年 ZP. All rights reserved.
//

#import "ZZQRCodeImageViewController.h"

@interface ZZQRCodeImageViewController ()
<
    UITextFieldDelegate,
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
>

@property (nonatomic,strong) UIImagePickerController *imagePicker;

@property (nonatomic,strong) UIButton *imgBtn;
@property (nonatomic,strong) UIImageView *imgview;
@end

@implementation ZZQRCodeImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self loadImageView];
    
    /*
     *
     iOS 图片来源有三种方法：
     UIImagePickerControllerSourceTypePhotoLibrary,    //1.从图库中选择
     UIImagePickerControllerSourceTypeCamera,          //2.直接调用摄像头拍照
     UIImagePickerControllerSourceTypeSavedPhotosAlbum //3.从相册中选择
     
     
     // 代理方法,获取图片
     // 选取的信息都在info中，info 是一个字典。
     // info dictionary keys
     UIKIT_EXTERN NSString *const UIImagePickerControllerMediaType __TVOS_PROHIBITED;//指定用户选择的媒体类型
     UIKIT_EXTERN NSString *const UIImagePickerControllerOriginalImage __TVOS_PROHIBITED;//原始图片
     UIKIT_EXTERN NSString *const UIImagePickerControllerEditedImage __TVOS_PROHIBITED;//修改后的图片
     UIKIT_EXTERN NSString *const UIImagePickerControllerCropRect __TVOS_PROHIBITED;//裁剪尺寸
     UIKIT_EXTERN NSString *const UIImagePickerControllerMediaURL __TVOS_PROHIBITED;//媒体的URL
     UIKIT_EXTERN NSString *const UIImagePickerControllerReferenceURL        NS_AVAILABLE_IOS(4_1) __TVOS_PROHIBITED;//原件的URL
     UIKIT_EXTERN NSString *const UIImagePickerControllerMediaMetadata       NS_AVAILABLE_IOS(4_1) __TVOS_PROHIBITED;//如果是拍照的照片，则需要手动保存到本地，系统不会自动保存拍照成功后的照片
     */
    
}

- (void)loadImageView {

    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, SCREEN_WIDTH -40, 30)];
    textField.placeholder = @"输入文字";
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:textField];
    
    UIButton *imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 150, 200, 200)];
    [imgBtn setTitle:@"插入图片" forState:UIControlStateNormal];
    [imgBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [imgBtn addTarget:self action:@selector(imgBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:imgBtn];
    self.imgBtn = imgBtn;
    
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(250, 300, 50, 50)];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(sureBtnClick) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:sureBtn];
    
    
    UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(20, 400, 200, 200)];
    [self.view addSubview:imgview];
    self.imgview = imgview;
    
}

- (void)sureBtnClick {
    
    NSLog(@"sureBtnClick");
    
    
    
    
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    
    return YES;
}

- (void)imgBtnClick {
    
    NSLog(@"imgBtnClick");
    
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    self.imagePicker.allowsEditing = YES;
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"从相机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:self.imagePicker animated:YES completion:nil];
        }
    }];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    
    [actionSheet addAction:cameraAction];
    [actionSheet addAction:photoAction];
    [actionSheet addAction:cancelAction];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.imgBtn setImage:image forState:UIControlStateNormal];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
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
