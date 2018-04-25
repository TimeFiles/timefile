//
//  TestHeaderViewController.m
//  ZZQRCode
//
//  Created by 张鹏 on 2018/4/10.
//  Copyright © 2018年 ZP. All rights reserved.
//

#import "TestHeaderViewController.h"

@interface TestHeaderViewController ()

@property (nonatomic,strong) UIButton *btn;

@property (nonatomic,strong) UIView *v1;

@end

@implementation TestHeaderViewController
{
    
    CGFloat btnHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
//    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.navigationController.navigationBar.frame), SCREEN_WIDTH, SCREEN_HEIGHT -64)];
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    _tableView.estimatedRowHeight = 100;
//    _tableView.estimatedSectionHeaderHeight = 300;
//    btnHeight = 50;
//    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//    [self.view addSubview:self.tableView];
    
    [self loadHeader];
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    v.backgroundColor = [UIColor grayColor];
    [self.view addSubview:v];
}

- (void)loadHeader {

    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    v.backgroundColor = [UIColor grayColor];
    [self.view addSubview:v];
//    [v mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.top.left.right.equalTo(self.view);
//        make.height.equalTo(@50);
//    }];
//
//    _btn = [[UIButton alloc] init];
//    [_btn setBackgroundColor:[UIColor redColor]];
//    [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_btn];
//    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.right.equalTo(self.view);
//        make.top.equalTo(v.mas_bottom);
//        make.height.equalTo(@(btnHeight));
//    }];
//
//    _v1 = [UIView new];
//    _v1.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:_v1];
//    [_v1 mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.bottom.right.equalTo(self.view);
//        make.height.equalTo(@50);
//        make.top.equalTo(_btn.mas_bottom);
//    }];

}

- (void)btnClick {
    NSLog(@"btnClick");
     NSLog(@"My btn frame1: %@", NSStringFromCGRect(self.btn.frame));
    CGFloat height = 50;
    btnHeight = btnHeight + height;
    
    [_btn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(@(btnHeight).integerValue));
    }];
    
//    NSLog(@"My btn frame2: %@", NSStringFromCGRect(self.btn.frame));
//    [self.tableView layoutIfNeeded];
//    self.tableView.tableHeaderView = self.headerView;
//    NSLog(@"My view frame: %@", NSStringFromCGRect(self.headerView.frame));
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//
//    return 100;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 50;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//
//    cell.textLabel.text = [NSString stringWithFormat:@"%zd",indexPath.row];
//    return cell;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
