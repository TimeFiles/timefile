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
#import "PriceExpensesModel.h"

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
    self.model.title = @"费用明细";
    self.model.FirstPriceArr = [NSMutableArray array];
    self.model.SecondPriceArr = [NSMutableArray array];
    self.model.ThreePriceArr = [NSMutableArray array];
    self.model.FourPriceArr = [NSMutableArray array];
    
    PriceExpensesModel *Fmodel = [[PriceExpensesModel alloc] init];
    Fmodel.title = @"基本团费";
    Fmodel.firstTitle = @"成人价";
    Fmodel.firstPrice = @"Y 100*1/人";
    Fmodel.sencondTitle = @"儿童价";
    Fmodel.sencondPrice = @"Y 10*1/人";
    [self.model.FirstPriceArr addObject:Fmodel];
    
    PriceExpensesModel *Smodel = [[PriceExpensesModel alloc] init];
    Smodel.title = @"单房差";
    Smodel.firstTitle = @"单房差";
    Smodel.firstPrice = @"Y +100*1/人";
    [self.model.SecondPriceArr addObject:Smodel];
    
    PriceExpensesModel *Tmodel = [[PriceExpensesModel alloc] init];
    Tmodel.title = @"优惠券";
    Tmodel.firstTitle = @"优惠券";
    Tmodel.firstPrice = @"Y -100*1/人";
    [self.model.ThreePriceArr addObject:Tmodel];
    
    PriceExpensesModel *FUmodel = [[PriceExpensesModel alloc] init];
    FUmodel.title = @"福利卡";
    FUmodel.firstTitle = @"福利卡";
    FUmodel.firstPrice = @"Y -1000*2/人";
    FUmodel.sencondTitle = @"福利卡1";
    FUmodel.sencondPrice = @"Y -1000*2/人11";
    [self.model.FourPriceArr addObject:FUmodel];
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
        [[TotalPriceExpensesTool sharedTotalPriceExpenses] dismissExpensesDetailView];
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
