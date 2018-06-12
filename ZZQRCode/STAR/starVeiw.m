//
//  starVeiw.m
//  ZZQRCode
//
//  Created by 张鹏 on 2018/6/12.
//  Copyright © 2018年 ZP. All rights reserved.
//

#import "starVeiw.h"
#import "starCollectionViewCell.h"
#import "starModel.h"

@interface starVeiw ()
<
    UICollectionViewDelegate,UICollectionViewDataSource
>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) UIButton *SureBtn;

@property (nonatomic,strong) UIButton *ClearBtn;

@property (nonatomic,strong) starModel *model;

@property (nonatomic, strong) NSMutableArray *dateArr;
@end


@implementation starVeiw

- (instancetype)initWithFrame:(CGRect)frame dateSourceArr:(NSMutableArray *)dateSourceArr
{
    self = [super initWithFrame:frame];
    if (self) {
        
        for (NSInteger i =0; i<dateSourceArr.count; i++) {
            starModel *model = [[starModel alloc] init];
            if (i == 0) {
                model.isSelected = YES;
            }else
            {
                model.isSelected = NO;
            }
            model.titleStr = dateSourceArr[i];
            [self.dateArr addObject:model];
        }
        [self setUI];
    }
    return self;
}

- (void)setUI {
    
    
    [self loadCollectionVeiw];
    [self loadClearBtn];
    [self loadSureBtn];
}

- (void)loadCollectionVeiw {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH -20, 80) collectionViewLayout:flowLayout];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    //实现多选
    collectionView.allowsMultipleSelection = YES;
    [self addSubview:collectionView];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerNib:[UINib nibWithNibName:@"starCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"starCollectionViewCell"];
    self.collectionView = collectionView;
}

#pragma mark - UICollectionDelegate && DateSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dateArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    starCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"starCollectionViewCell" forIndexPath:indexPath];
    starModel *model = self.dateArr[indexPath.item];
    [cell loadStarModel:model];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH-60)/5.0,(SCREEN_WIDTH-60)/5.0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectItemAtIndexPath");
    starCollectionViewCell *cell = (starCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    starModel *model = self.dateArr[indexPath.item];
    model.isSelected = !model.isSelected;
    cell.backgroundColor = [UIColor redColor];
    cell.titleLabel.textColor = [UIColor whiteColor];
    
    if (indexPath.item != 0) {
        //不是1 ,把1改成no
        starModel *model = self.dateArr[0];
        model.isSelected = NO;
    }else {
        //是1,改成yes   ,把其他的状态都清掉no
        for (NSInteger i =0; i<self.dateArr.count; i++) {
            starModel *model = self.dateArr[i];
            if (i == 0) {
                model.isSelected = YES;
            }else{
                model.isSelected = NO;
            }
        }
    }
    
    if (model.isSelected) {
        cell.backgroundColor = [UIColor redColor];
        cell.titleLabel.textColor = [UIColor whiteColor];
    }else
    {
        cell.backgroundColor = [UIColor whiteColor];
        cell.titleLabel.textColor = [UIColor blackColor];
    }
    [self.collectionView reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"didDeselectItemAtIndexPath");
    starCollectionViewCell *cell = (starCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    starModel *model = self.dateArr[indexPath.item];
    model.isSelected = !model.isSelected;
    
    if (indexPath.item != 0) {
        //不是1 ,把1改成no
        starModel *model = self.dateArr[0];
        model.isSelected = NO;
    }else {
        //是1,改成yes   ,把其他的状态都清掉no
        starModel *model = self.dateArr[indexPath.item];
        for (NSInteger i =1; i<self.dateArr.count; i++) {
            model.isSelected = NO;
        }
    }
    if (model.isSelected) {
        cell.backgroundColor = [UIColor redColor];
        cell.titleLabel.textColor = [UIColor whiteColor];
    }else
    {
        cell.backgroundColor = [UIColor whiteColor];
        cell.titleLabel.textColor = [UIColor blackColor];
    }
    [self.collectionView reloadData];
}

- (void)loadSureBtn {
    
     _SureBtn= [[UIButton alloc] init];
    [_SureBtn setBackgroundColor:[UIColor redColor]];
    [_SureBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    [_SureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_SureBtn];
    [_SureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.collectionView.mas_bottom).offset(10);
        make.right.equalTo(self);
        make.width.equalTo(@(SCREEN_WIDTH/2));
        make.height.equalTo(@64);
    }];
    [_SureBtn addTarget:self action:@selector(SureBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loadClearBtn {
    _ClearBtn= [[UIButton alloc] init];
    [_ClearBtn setBackgroundColor:[UIColor redColor]];
    [_ClearBtn setTitle:@"清除" forState:(UIControlStateNormal)];
    [_ClearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:_ClearBtn];
    [_ClearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.collectionView.mas_bottom).offset(10);
        make.left.equalTo(self);
        make.width.equalTo(@(SCREEN_WIDTH/2));
        make.height.equalTo(@64);
    }];
    [_ClearBtn addTarget:self action:@selector(ClearBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)SureBtnClick {
    NSLog(@"SureBtnClick");
    NSLog(@"count----%zd",self.dateArr.count);
    if ([self.delegate respondsToSelector:@selector(SureBtnClick:)]) {
        [self.delegate SureBtnClick:self.dateArr];
    }
}


- (void)ClearBtnClick {
    NSLog(@"ClearBtnClick");
    for (NSInteger i =0; i<self.dateArr.count; i++) {
        starModel *model = self.dateArr[i];
        if (i == 0) {
            model.isSelected = YES;
        }else{
            model.isSelected = NO;
        }
    }
    NSLog(@"3count----%zd",self.dateArr.count);
    [self.collectionView reloadData];
}


- (NSMutableArray *)dateArr {
    if (_dateArr == nil) {
        _dateArr = [NSMutableArray array];
    }
    return _dateArr;
}
@end
