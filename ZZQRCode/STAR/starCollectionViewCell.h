//
//  starCollectionViewCell.h
//  ZZQRCode
//
//  Created by 张鹏 on 2018/6/12.
//  Copyright © 2018年 ZP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "starModel.h"

@interface starCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

- (void)loadStarModel:(starModel*)model;

@end
