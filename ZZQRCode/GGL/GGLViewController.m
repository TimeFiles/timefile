//
//  GGLViewController.m
//  ZZQRCode
//
//  Created by 张鹏 on 2018/7/4.
//  Copyright © 2018年 ZP. All rights reserved.
//

#import "GGLViewController.h"

@interface GGLViewController ()

@property (nonatomic, strong) UIImageView *imageView;


@end

@implementation GGLViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"刮刮乐";
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createSubViews];
}


-(void)createSubViews {
    /**
     注意:
     1. 这两个控件的位置要相同
     2. 一定要先创建下面的label, 再创建图片
     */
    
    // 展示刮出来的效果的view
    UILabel *labelL        = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 280, 200)];
    labelL.text            = @"刮刮乐效果展示";
    labelL.numberOfLines   = 0;
    labelL.backgroundColor = [UIColor brownColor];
    labelL.font            = [UIFont systemFontOfSize:30];
    labelL.textAlignment   = NSTextAlignmentCenter;
    [self.view addSubview:labelL];
    
    // 被刮的图片
    self.imageView       = [[UIImageView alloc] initWithFrame:labelL.frame];
    self.imageView.image = [UIImage imageNamed:@"mm.jpeg"];
    [self.view addSubview:self.imageView];
}


-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // 触摸任意位置
    UITouch *touch = touches.anyObject;
    // 触摸位置在图片上的坐标
    CGPoint cententPoint = [touch locationInView:self.imageView];
    // 设置清除点的大小
    CGRect  rect = CGRectMake(cententPoint.x, cententPoint.y, 20, 20);
    // 默认是去创建一个透明的视图
    UIGraphicsBeginImageContextWithOptions(self.imageView.bounds.size, NO, 0);
    // 获取上下文(画板)
    CGContextRef ref = UIGraphicsGetCurrentContext();
    // 把imageView的layer映射到上下文中
    [self.imageView.layer renderInContext:ref];
    // 清除划过的区域
    CGContextClearRect(ref, rect);
    // 获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束图片的画板, (意味着图片在上下文中消失)
    UIGraphicsEndImageContext();
    
    self.imageView.image = image;
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
