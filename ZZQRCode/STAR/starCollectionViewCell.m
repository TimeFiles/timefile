//
//  starCollectionViewCell.m
//  ZZQRCode
//
//  Created by 张鹏 on 2018/6/12.
//  Copyright © 2018年 ZP. All rights reserved.
//

#import "starCollectionViewCell.h"

@implementation starCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loadStarModel:(starModel *)model {
    
    self.titleLabel.text = model.titleStr;
    if (model.isSelected) {
        self.backgroundColor = [UIColor redColor];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 0.5;
    } else {
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel.textColor = [UIColor darkGrayColor];
        self.titleLabel.font = [UIFont systemFontOfSize:15.0];
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 0.5;
    }
}

@end
