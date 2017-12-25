//
//  CollectionHeaderReusableView.m
//  ZZQRCode
//
//  Created by 张鹏 on 2017/12/25.
//  Copyright © 2017年 ZP. All rights reserved.
//

#import "CollectionHeaderReusableView.h"

@interface CollectionHeaderReusableView()

@end

@implementation CollectionHeaderReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        // 标题
        UILabel * titleLabel = ({
            UILabel * label = [[UILabel alloc] init];
            label.numberOfLines = 0;
            label.textColor = [UIColor blackColor];
            label.textAlignment = NSTextAlignmentLeft;
            label.font = [UIFont systemFontOfSize:15];
            [self addSubview:label];
            label;
            
        });
        self.titleLabel = titleLabel;
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mas_left).offset(20);
            make.right.equalTo(self.mas_right).offset(-5);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    return self;
}

@end
