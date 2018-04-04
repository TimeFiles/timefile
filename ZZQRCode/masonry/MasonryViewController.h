//
//  MasonryViewController.h
//  ZZQRCode
//
//  Created by 张鹏 on 2018/4/4.
//  Copyright © 2018年 ZP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCalendar.h"

@interface MasonryViewController : UIViewController
<
    FSCalendarDelegate, FSCalendarDataSource
>

@property (weak, nonatomic) FSCalendar *calendar;
@property (weak, nonatomic) UIButton *previousButton;
@property (weak, nonatomic) UIButton *nextButton;

@property (strong, nonatomic) NSCalendar *gregorian;

- (void)previousClicked:(id)sender;
- (void)nextClicked:(id)sender;


@end
