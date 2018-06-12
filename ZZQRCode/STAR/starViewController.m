//
//  starViewController.m
//  ZZQRCode
//
//  Created by 张鹏 on 2018/6/12.
//  Copyright © 2018年 ZP. All rights reserved.
//

#import "starViewController.h"
#import "starVeiw.h"
#import "starModel.h"

@interface starViewController ()
<
    starVeiwDelegate
>

@property (nonatomic,strong) UIView *priceDetailBackView;

@property (nonatomic,strong) starVeiw *starView;

@property (nonatomic,strong) UIButton *btn;
@end

@implementation starViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    [self loadBackVeiw];
    [self dismissExpensesDetailView];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@" 点击了屏幕 ");
    self.priceDetailBackView.hidden = NO;
    self.starView.hidden = NO;
}


- (void)loadBackVeiw {
    
    NSLog(@"loadBackVeiw");
    _priceDetailBackView = [[UIView alloc] init];
    _priceDetailBackView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _priceDetailBackView.backgroundColor = [UIColor blackColor];
    _priceDetailBackView.alpha = 0.6;
    [[UIApplication sharedApplication].keyWindow addSubview:_priceDetailBackView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissExpensesDetailView)];
    [_priceDetailBackView addGestureRecognizer:tap];
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    _starView = [[starVeiw alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT -230, SCREEN_WIDTH, 230) dateSourceArr:arr];
    _starView.delegate = self;
    _starView.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication].keyWindow addSubview:_starView];
}

- (void)SureBtnClick:(NSMutableArray *)dateSourceArr {
    
    NSLog(@"dateSourceArr--%@",dateSourceArr);
    [self dismissExpensesDetailView];
}

- (void)dismissExpensesDetailView {
    self.priceDetailBackView.hidden = YES;
    self.starView.hidden = YES;
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
