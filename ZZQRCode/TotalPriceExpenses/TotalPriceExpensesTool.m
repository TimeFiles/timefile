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
@property (nonatomic,strong) UIView *shadowView;

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



- (void)showTotalPriceExpensesTool:(TotalPriceExpensesModel *)model controller:(UIViewController *)controller{
    NSLog(@"model.title--%@",model.title);
    [self loadShadowView];
    
    
}

- (void)loadShadowView {
    
    self.shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -49)];
    self.shadowView.backgroundColor = [UIColor blackColor];
    self.shadowView.alpha = 0.6;
    [[UIApplication sharedApplication].keyWindow addSubview:self.shadowView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissExpensesDetailView)];
    [self.shadowView addGestureRecognizer:tap];
}

- (void)dismissExpensesDetailView {
    NSLog(@"移除遮罩视图");
    [self.shadowView removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(totalPriceDetailBackViewDismiss)]) {
        [self.delegate totalPriceDetailBackViewDismiss];
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blueColor];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    static NSString *header = @"customHeader";
    UITableViewHeaderFooterView *vHeader;
    vHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:header];
    vHeader = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:header];
    vHeader.contentView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor whiteColor];
    titleLabel.frame = CGRectMake(0, 5, 80, 30);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:14];
    [vHeader addSubview:titleLabel];
    //    }
    titleLabel.text = @"组头";
    return vHeader;
}


- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
    }
    return _tableView;
}

@end
