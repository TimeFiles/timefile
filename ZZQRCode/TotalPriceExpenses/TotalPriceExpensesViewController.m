//
//  TotalPriceExpensesViewController.m
//  ZZQRCode
//
//  Created by 张鹏 on 2017/12/21.
//  Copyright © 2017年 ZP. All rights reserved.
//

#import "TotalPriceExpensesViewController.h"
#import "TotalPriceExpensesTool.h"
#import "TotalPriceExpensesModel.h"

@interface TotalPriceExpensesViewController ()
<
    TotalPriceExpensesDelegate
>

@property (nonatomic,strong) UIView *toolBarView;

@property (nonatomic,strong) UIButton *totalPriceExpensesBtn;

@property (nonatomic,strong) TotalPriceExpensesModel *model;

@property (nonatomic, assign) BOOL isSeleced;

@end

@implementation TotalPriceExpensesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"费用明细";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadToolBar];
    self.isSeleced = YES;
    self.model = [[TotalPriceExpensesModel alloc] init];
    self.model.title = @"标题";
}

- (void)loadToolBar {
    
    self.toolBarView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT -49, SCREEN_WIDTH, 49)];
    self.toolBarView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.toolBarView];
    
    self.totalPriceExpensesBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
    [self.totalPriceExpensesBtn setTitle:@"费用明细" forState:UIControlStateNormal];
    [self.totalPriceExpensesBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.totalPriceExpensesBtn addTarget:self action:@selector(totalPriceExpensesBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolBarView addSubview:self.totalPriceExpensesBtn];
    
}

- (void)totalPriceExpensesBtnClick:(UIButton *)sender {
    
    [TotalPriceExpensesTool sharedTotalPriceExpenses].delegate = self;
    
    if (self.isSeleced) {
        [[TotalPriceExpensesTool sharedTotalPriceExpenses] showTotalPriceExpensesTool:self.model controller:self];
        self.isSeleced = NO;
    }else
    {
        [self totalPriceDetailBackViewDismiss];
        self.isSeleced = YES;
    }
}

- (void)totalPriceDetailBackViewDismiss {
    self.isSeleced = YES;
    NSLog(@"totalPriceDetailBackViewDismiss");
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
