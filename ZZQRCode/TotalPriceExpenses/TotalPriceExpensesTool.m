//
//  TotalPriceExpenseTool.m
//  ZZQRCode
//
//  Created by 张鹏 on 2017/12/21.
//  Copyright © 2017年 ZP. All rights reserved.
//

#import "TotalPriceExpensesTool.h"

@interface TotalPriceExpensesTool()
<
    UITableViewDelegate, UITableViewDataSource
>

@property (nonatomic,strong) UITableView *tableView;


@end

@implementation TotalPriceExpensesTool

+ (TotalPriceExpensesTool *)sharedTotalPriceExpenses {
    
    static TotalPriceExpensesTool *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[TotalPriceExpensesTool alloc] init];
    });
    return manager;
}



- (void)showTotalPriceExpensesTool:(TotalPriceExpensesModel *)model {
    NSLog(@"model.title--%@",model.title);
    
    
    
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    return cell;
    
}


- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
    }
    return _tableView;
}

@end
