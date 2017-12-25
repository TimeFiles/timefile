//
//  TotalPriceExpensesModel.h
//  ZZQRCode
//
//  Created by 张鹏 on 2017/12/21.
//  Copyright © 2017年 ZP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PriceExpensesModel.h"

@interface TotalPriceExpensesModel : NSObject

@property (nonatomic, copy) NSString *title;

/*
 基本团费 (跟团游)
    1.包含成人和儿童
    2. 参数包含: 成人价(字符串) , 成人单价, 成人数
    3. 参数包含: 儿童价(字符串) , 儿童单价, 儿童数
 */
@property (nonatomic, strong) NSMutableArray<PriceExpensesModel *> *FirstPriceArr;


/*
 附加项目 (跟团游) 单房差
 1. 参数包含: 单房差(字符串) , 单房差价格
 */
@property (nonatomic, strong) NSMutableArray<PriceExpensesModel *> *SecondPriceArr;


/*
 优惠券(跟团游)
 1. 参数包含: 优惠券(字符串) , 优惠券价格
 */
@property (nonatomic, strong) NSMutableArray<PriceExpensesModel *> *ThreePriceArr;

/*
 福利卡(跟团游)
 1. 参数包含: 福利卡(字符串) , 福利卡价格
 */
@property (nonatomic, strong) NSMutableArray<PriceExpensesModel *> *FourPriceArr;


@end
