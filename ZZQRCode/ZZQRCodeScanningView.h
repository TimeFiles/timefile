//
//  ZZQRCodeScanningView.h
//  ZZQRCode
//
//  Created by 张鹏 on 2017/8/3.
//  Copyright © 2017年 ZP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZQRCodeScanningView : UIView

/**
 *  对象方法创建SGQRCodeScanningView
 *
 *  @param frame     frame
 *  @param layer     父视图 layer
 */
- (instancetype)initWithFrame:(CGRect)frame layer:(CALayer *)layer;
/**
 *  类方法创建SGQRCodeScanningView
 *
 *  @param frame     frame
 *  @param layer     父视图 layer
 */
+ (instancetype)scanningViewWithFrame:(CGRect )frame layer:(CALayer *)layer;

/** 添加定时器 */
- (void)addTimer;
/** 移除定时器(切记：一定要在Controller视图消失的时候，停止定时器) */
- (void)removeTimer;

@end
