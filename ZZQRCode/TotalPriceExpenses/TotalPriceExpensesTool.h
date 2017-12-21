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

@interface TotalPriceExpensesTool : NSObject

+ (TotalPriceExpensesTool *)sharedTotalPriceExpenses;


- (void)showTotalPriceExpensesTool:(TotalPriceExpensesModel *)model;

@end
