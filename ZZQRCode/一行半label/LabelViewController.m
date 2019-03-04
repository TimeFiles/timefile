//
//  LabelViewController.m
//  ZZQRCode
//
//  Created by 张鹏 on 2019/3/4.
//  Copyright © 2019 ZP. All rights reserved.
//

#import "LabelViewController.h"

@interface LabelViewController ()

@end

@implementation LabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *newStr =@"小时候爹问我有什么理想,我说我要把你照片挂在那个城门楼上,爹听完笑笑从口袋里摸出一块糖,可没拿糖的那只手就甩了我个耳光,他说火红的太阳照的我们倍儿有面子,这面子保佑人们吃饱还能赚着票子,被乌云挡住了太阳怎么能不发火呢,像谁家的爸爸不打谁们家的儿子";
    
    [newStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];//去除掉首尾的空白字符和换行字符
    
    newStr = [newStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    newStr = [newStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    //创建label,WIDTH是宏定义的屏幕宽度
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 335, 100)];
    
    label.numberOfLines = 0;
    
    label.backgroundColor = [UIColor orangeColor];
    
    label.textColor = [UIColor redColor];
    
    label.font = [UIFont systemFontOfSize:14.0];
    
    label.text = newStr;
    
    [self.view addSubview:label];
    
    [label sizeToFit];
    
    NSString *string = [self getWidthWithLabel:label];
    
    label.text = string;
    
    
    [self adjustLabelLineSpacing:label];
}


//核心代码控制显示一行半的方法

- (NSString *)getWidthWithLabel:(UILabel *)label{
    
    NSString *temp =nil;
    
    NSString *temp1=label.text;
    
    CGFloat length = 0;
    
    for(int i =0; i < [label.text length]; i++)
        
    {
        
        temp = [label.text substringWithRange:NSMakeRange(i,1)];
        
        // 计算宽度
        
        CGSize size = [temp boundingRectWithSize:CGSizeMake(MAXFLOAT, 0.0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : label.font} context:nil].size;
        
        length=length+size.width;
        
        // 3*label.frame.size.width   此处是三行半,根据需求设置
        
        if (length >= (3*label.frame.size.width + 0.5 * label.frame.size.width)) {
            
            temp1= [[label.text substringToIndex:i] stringByAppendingString:@" ..."];
            
            return temp1;
        }
    }
    return temp1;
}

//控制行间距

-(CGSize)adjustLabelLineSpacing:(UILabel *)label

{
    
    CGSize size = CGSizeZero;
    
    label.text = ((NSNull *)label.text == [NSNull null] || label.text == nil) ? @"" : label.text;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:label.text];;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    [paragraphStyle setLineSpacing:6];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, label.text.length)];
    
    label.attributedText = attributedString;
    
    //调节高度
    
    size = CGSizeMake(label.frame.size.width, 500000);
    
    CGSize labelSize = [label sizeThatFits:size];
    
    CGRect rect = label.frame;
    
    rect.size.width = labelSize.width;
    
    rect.size.height = labelSize.height;
    
    label.frame = rect;
    
    return size;
    
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
