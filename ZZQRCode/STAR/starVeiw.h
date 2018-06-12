//
//  starVeiw.h
//  ZZQRCode
//
//  Created by 张鹏 on 2018/6/12.
//  Copyright © 2018年 ZP. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol starVeiwDelegate <NSObject>

- (void)SureBtnClick:(NSMutableArray *)dateSourceArr;
@end

@interface starVeiw : UIView

- (instancetype)initWithFrame:(CGRect)frame dateSourceArr:(NSMutableArray *)dateSourceArr;
@property (nonatomic,weak) id <starVeiwDelegate> delegate;

@end
