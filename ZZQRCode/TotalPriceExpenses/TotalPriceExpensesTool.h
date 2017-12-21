//
//  TotalPriceExpensesTool.h
//  ZZQRCode
//
//  Created by 张鹏 on 2017/12/21.
//  Copyright © 2017年 ZP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TotalPriceExpensesModel.h"

@protocol TotalPriceExpensesDelegate <NSObject>

-(void)totalPriceDetailBackViewDismiss;
@end

@interface TotalPriceExpensesTool : NSObject

@property (nonatomic,weak) id<TotalPriceExpensesDelegate>delegate;

+ (TotalPriceExpensesTool *)sharedTotalPriceExpenses;


- (void)showTotalPriceExpensesTool:(TotalPriceExpensesModel *)model controller:(UIViewController *)controller;

@end
