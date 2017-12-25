//
//  TotalPriceExpenseTool.m
//  ZZQRCode
//
//  Created by 张鹏 on 2017/12/21.
//  Copyright © 2017年 ZP. All rights reserved.
//

#import "TotalPriceExpensesTool.h"
#import "TotalPriceEepensesCollectionViewCell.h"
#import "CollectionHeaderReusableView.h"
#define TotalPriceExpensesHeight 350

@interface TotalPriceExpensesTool()
<
    UICollectionViewDelegate,UICollectionViewDataSource
>

@property (nonatomic,strong) UIView *shadowView;

@property (nonatomic,strong) UICollectionView *colletionView;

@property (nonatomic,strong) TotalPriceExpensesModel *Model;

@property (nonatomic, assign) NSInteger totalCount;

@end

@implementation TotalPriceExpensesTool

static NSString *const headerId = @"headerId";

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
    self.Model = [[TotalPriceExpensesModel alloc] init];
    self.Model = model;
    [self exe:model];
    [self loadShadowView];
}

- (void)loadShadowView {
    
    self.shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -49)];
    self.shadowView.backgroundColor = [UIColor blackColor];
    self.shadowView.alpha = 0.6;
    [[UIApplication sharedApplication].keyWindow addSubview:self.shadowView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissExpensesDetailView)];
    [self.shadowView addGestureRecognizer:tap];
    
    //标题
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0 , SCREEN_HEIGHT -TotalPriceExpensesHeight -49 ,SCREEN_WIDTH, 50)];
    titleView.backgroundColor = [UIColor whiteColor];
    [self.shadowView addSubview:titleView];
    
    CGRect rect = [self getTotalHeightWithString:self.Model.title withFontSize:17];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - rect.size.width/2 , 10 ,rect.size.width, 20)];
    [titleView addSubview:label];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    label.textColor = [UIColor blackColor];
    label.text = self.Model.title;
    UIImageView *leftImageView = [[UIImageView alloc]init];
    leftImageView.image = [UIImage imageNamed:@"Home_diamond"];
    [titleView addSubview:leftImageView];
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label.mas_centerY);
        make.right.equalTo(label.mas_left).offset(-5);
        make.width.height.equalTo(@6);
    }];
    UIImageView *rightImageView = [[UIImageView alloc]init];
    rightImageView.image = [UIImage imageNamed:@"Home_diamond"];
    [titleView addSubview:rightImageView];
    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label.mas_centerY);
        make.left.equalTo(label.mas_right).offset(3);
        make.width.height.equalTo(@6);
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.colletionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT -TotalPriceExpensesHeight -49 +50, SCREEN_WIDTH, TotalPriceExpensesHeight -50) collectionViewLayout:layout];
    self.colletionView.backgroundColor = [UIColor whiteColor];
    self.colletionView.contentSize = CGSizeMake(SCREEN_WIDTH, 1000);
     [self.colletionView registerNib:[UINib nibWithNibName:@"TotalPriceEepensesCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"cell"];
    [self.colletionView registerClass:[CollectionHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    //隐藏竖直滚动条
    self.colletionView.showsVerticalScrollIndicator = NO;
    //隐藏水平滚动条
    self.colletionView.showsHorizontalScrollIndicator = NO;
    self.colletionView.delegate = self;
    self.colletionView.dataSource = self;
    [self.shadowView addSubview:self.colletionView];
}

- (void)dismissExpensesDetailView {
    NSLog(@"移除遮罩视图");
    [self.shadowView removeFromSuperview];
    if ([self.delegate respondsToSelector:@selector(totalPriceDetailBackViewDismiss)]) {
        [self.delegate totalPriceDetailBackViewDismiss];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.totalCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        if (self.Model.FirstPriceArr.firstObject.sencondPrice.length == 0) {
            return 1;
        }else
        {
            return 2;
        }
    }else if (section == 1) {
        if (self.Model.SecondPriceArr.firstObject.sencondPrice.length == 0) {
            return 1;
        }else
        {
            return 2;
        }
    }else if (section == 2) {
        if (self.Model.ThreePriceArr.firstObject.sencondPrice.length == 0) {
            return 1;
        }else
        {
            return 2;
        }
    }else if (section == 3) {
        if (self.Model.FourPriceArr.firstObject.sencondPrice.length == 0) {
            return 1;
        }else
        {
            return 2;
        }
    }else
    {
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TotalPriceEepensesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    NSLog(@"indexPath.section --%zd",indexPath.section);
    if (indexPath.section == 0) {
        if (indexPath.item == 0) {
            NSLog(@"indexPath.item --%zd",indexPath.item );
            cell.kindsLabel.text = self.Model.FirstPriceArr.firstObject.firstTitle;
            cell.priceLabel.text = self.Model.FirstPriceArr.firstObject.firstPrice;
        }else
        {
            NSLog(@"indexPath.item --%zd",indexPath.item );
            cell.kindsLabel.text = self.Model.FirstPriceArr.lastObject.sencondTitle;
            cell.priceLabel.text = self.Model.FirstPriceArr.lastObject.sencondPrice;
        }
    }else if (indexPath.section == 1) {
        if (indexPath.item == 0) {
            NSLog(@"indexPath.item --%zd",indexPath.item );
            cell.kindsLabel.text = self.Model.SecondPriceArr.firstObject.firstTitle;
            cell.priceLabel.text = self.Model.SecondPriceArr.firstObject.firstPrice;
        }else
        {
            NSLog(@"indexPath.item --%zd",indexPath.item );
            cell.kindsLabel.text = self.Model.SecondPriceArr.lastObject.sencondTitle;
            cell.priceLabel.text = self.Model.SecondPriceArr.lastObject.sencondPrice;
        }
    }else if (indexPath.section == 2) {
        if (indexPath.item == 0) {
            NSLog(@"indexPath.item --%zd",indexPath.item );
            cell.kindsLabel.text = self.Model.ThreePriceArr.firstObject.firstTitle;
            cell.priceLabel.text = self.Model.ThreePriceArr.firstObject.firstPrice;
        }else
        {
            NSLog(@"indexPath.item --%zd",indexPath.item );
            cell.kindsLabel.text = self.Model.ThreePriceArr.lastObject.sencondTitle;
            cell.priceLabel.text = self.Model.ThreePriceArr.lastObject.sencondPrice;
        }
    }else if (indexPath.section == 3) {
        if (indexPath.item == 0) {
            NSLog(@"indexPath.item --%zd",indexPath.item );
            cell.kindsLabel.text = self.Model.FourPriceArr.firstObject.firstTitle;
            cell.priceLabel.text = self.Model.FourPriceArr.firstObject.firstPrice;
        }else
        {
            NSLog(@"indexPath.item --%zd",indexPath.item );
            cell.kindsLabel.text = self.Model.FourPriceArr.lastObject.sencondTitle;
            cell.priceLabel.text = self.Model.FourPriceArr.lastObject.sencondPrice;
        }
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_WIDTH, 20);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        CollectionHeaderReusableView * headerView;
        headerView = [self.colletionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor whiteColor];
        if (indexPath.section == 0) {
            headerView.titleLabel.text = self.Model.FirstPriceArr.firstObject.title;
        }else if (indexPath.section == 1) {
            headerView.titleLabel.text = self.Model.SecondPriceArr.firstObject.title;
        }else if (indexPath.section == 2) {
            headerView.titleLabel.text = self.Model.ThreePriceArr.firstObject.title;
        }else
        {
            headerView.titleLabel.text = self.Model.FourPriceArr.firstObject.title;
        }
        return headerView;
    }
    return nil;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_WIDTH, 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeZero;
}

#pragma mark - 计算label的宽度
- (CGRect)getTotalHeightWithString:(NSString *)string withFontSize:(NSInteger)fontSize{
    CGRect rect = [string boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20 - 100, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    return rect;
}

#pragma mark - 计算collection的组数
- (void )exe:(TotalPriceExpensesModel *)model {
    NSInteger a = 0;
    NSInteger b = 0;
    NSInteger c = 0;
    NSInteger d = 0;
    if (model.FirstPriceArr.count != 0) {
        a = 1;
    }
    if (model.SecondPriceArr.count != 0) {
        b = 1;
    }
    if (model.ThreePriceArr.count != 0) {
        c = 1;
    }
    if (model.FourPriceArr.count != 0) {
        d = 1;
    }
    self.totalCount = a +b +c +d;
}

@end
