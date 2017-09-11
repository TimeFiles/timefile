//
//  ZZQRCodeManager.h
//  ZZQRCode
//
//  Created by 张鹏 on 2017/8/3.
//  Copyright © 2017年 ZP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@class ZZQRCodeManager;


@protocol ZZQRCodeManagerDelegate <NSObject>

/**
 *  delegate(扫描二维码获取数据的方法)
 *
 *  @param manager    ZZQRCodeManager
 *  @param metadataObjects    数据信息
 */

- (void)manager:(ZZQRCodeManager *)manager didOutputMetadataObjects:(NSArray *)metadataObjects;

/**
 *  delegate(didFinishPickingMediaWithInfo)
 *
 *  @param manager    SGQRCodeManager
 *  @param picker    UIImagePickerController
 *  @param info    获取图片信息
 */
//- (void)manager:(ZZQRCodeManager *)manager imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info;
//
///**
// *  delegate(imagePickerControllerDidCancel)
// *
// *  @param manager    SGQRCodeManager
// *  @param picker    UIImagePickerController
// */
//- (void)manager:(ZZQRCodeManager *)manager imagePickerControllerDidCancel:(UIImagePickerController *)picker;

@end



@interface ZZQRCodeManager : NSObject
/// 快速创建单利方法
+ (instancetype)sharedZZCodeManager;

/// 当前 ZZQRCodeManager 所在的控制器；必须设置且在 ZZ_setupeSsionPreset:metadataObjectTypes 方法前设置
@property (nonatomic, strong) UIViewController *currentVC;
/// 相册访问权限是否打开
@property (nonatomic, assign) BOOL isPHAuthorization;

@property (nonatomic,weak) id<ZZQRCodeManagerDelegate> delegate;
/**
 *  设置会话采集数据类型以及扫码支持的编码格式
 *
 *  @param sessionPreset    会话采集数据类型
 *  @param metadataObjectTypes    扫码支持的编码格式
 */
- (void)ZZ_setupSessionPreset:(NSString *)sessionPreset metadataObjectTypes:(NSArray *)metadataObjectTypes;

/// 开启会话对象扫描
- (void)ZZ_startRunning;
/// 停止会话对象扫描
- (void)ZZ_stopRunning;
/// 移除 videoPreviewLayer 对象
- (void)ZZ_videoPreviewLayerRemoveFromSuperlayer;
/// 播放音效文件
- (void)ZZ_palySoundName:(NSString *)name;

@end
