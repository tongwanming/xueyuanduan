//
//  installmentProgressView.m
//  好梦学车
//
//  Created by haomeng on 2017/8/29.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "installmentProgressView.h"

#define WIDTH 28

@implementation installmentProgressView

- (instancetype)initWithPrice1:(int)price1 andPrice2:(int)price2 andPrice3:(int)price3 andHandPrice:(int)handPrice andProgress:(int)progress andFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       
        UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(103/2*TYPERATION, 0, WIDTH, WIDTH)];
        if (progress > 1) {
            imageView1.image = [UIImage imageNamed:@"icon_order_one"];
        }else{
            imageView1.image = [UIImage imageNamed:@"icon_order_two"];
        }
        imageView1.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView1];
        
        UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(103/2*TYPERATION, 0, WIDTH, WIDTH)];
        imageView2.center = CGPointMake(CURRENT_BOUNDS.width/2, WIDTH/2);
        if (progress == 1) {
            imageView2.image = [UIImage imageNamed:@"icon_order_three"];
        }else if (progress == 2){
            imageView2.image = [UIImage imageNamed:@"icon_order_two"];
        }else if (progress == 3){
            imageView2.image = [UIImage imageNamed:@"icon_order_one"];
        }else{
            imageView2.image = [UIImage imageNamed:@"icon_order_one"];
        }
        imageView2.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView2];
        
        UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width-103/2*TYPERATION-WIDTH, 0, WIDTH, WIDTH)];
        if (progress == 1) {
            imageView3.image = [UIImage imageNamed:@"icon_order_three"];
        }else if (progress == 2){
            imageView3.image = [UIImage imageNamed:@"icon_order_three"];
        }else if (progress == 3){
            imageView3.image = [UIImage imageNamed:@"icon_order_two"];
        }else{
            imageView3.image = [UIImage imageNamed:@"icon_order_one"];
        }
        imageView3.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView3];
        
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView1.frame), WIDTH/2-0.5, CURRENT_BOUNDS.width/2-1.5*WIDTH-103/2*TYPERATION, 1)];
        if (progress > 1) {
            lineView1.backgroundColor = BLUE_BACKGROUND_COLOR;
        }else{
            lineView1.backgroundColor = EEEEEE;
        }
        [self addSubview:lineView1];
        
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView2.frame), WIDTH/2-0.5, CURRENT_BOUNDS.width/2-1.5*WIDTH-103/2*TYPERATION, 1)];
        if (progress > 2) {
            lineView2.backgroundColor = BLUE_BACKGROUND_COLOR;
        }else{
            lineView2.backgroundColor = EEEEEE;
        }
        [self addSubview:lineView2];
        
        UILabel *title1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 14)];
        title1.textAlignment = NSTextAlignmentCenter;
        title1.text = @"首付";
        title1.center = CGPointMake(imageView1.center.x, CGRectGetMaxY(imageView1.frame)+15+7);
        title1.font = [UIFont systemFontOfSize:14];
        if (progress == 1) {
            title1.textColor = TEXT_COLOR;
        }else{
            title1.textColor = UNMAIN_TEXT_COLOR;
        }
        [self addSubview:title1];
        
        UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 14)];
        title2.textAlignment = NSTextAlignmentCenter;
        title2.text = @"二期";
        title2.center = CGPointMake(imageView2.center.x, CGRectGetMaxY(imageView1.frame)+15+7);
        title2.font = [UIFont systemFontOfSize:14];
        if (progress <= 2) {
            title2.textColor = TEXT_COLOR;
        }else{
            title2.textColor = UNMAIN_TEXT_COLOR;
        }
        [self addSubview:title2];
        
        UILabel *title3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 14)];
        title3.textAlignment = NSTextAlignmentCenter;
        title3.text = @"三期";
        title3.center = CGPointMake(imageView3.center.x, CGRectGetMaxY(imageView1.frame)+15+7);
        title3.font = [UIFont systemFontOfSize:14];
        if (progress <= 3) {
            title3.textColor = TEXT_COLOR;
        }else{
            title3.textColor = UNMAIN_TEXT_COLOR;
        }
        [self addSubview:title3];
        
        UILabel *smallTitle1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 12)];
        smallTitle1.textAlignment = NSTextAlignmentCenter;
        smallTitle1.text = @"报名时支付";
        smallTitle1.center = CGPointMake(imageView1.center.x, CGRectGetMaxY(title1.frame)+12+6);
        smallTitle1.font = [UIFont systemFontOfSize:12];
        smallTitle1.textColor = UNMAIN_TEXT_COLOR;
        [self addSubview:smallTitle1];
        
        UILabel *smallTitle2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 12)];
        smallTitle2.textAlignment = NSTextAlignmentCenter;
        smallTitle2.text = @"科目二开始前";
        smallTitle2.center = CGPointMake(imageView2.center.x, CGRectGetMaxY(title1.frame)+12+6);
        smallTitle2.font = [UIFont systemFontOfSize:12];
        smallTitle2.textColor = UNMAIN_TEXT_COLOR;
        [self addSubview:smallTitle2];
        
        UILabel *smallTitle3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 12)];
        smallTitle3.textAlignment = NSTextAlignmentCenter;
        smallTitle3.text = @"科目三开始前";
        smallTitle3.center = CGPointMake(imageView3.center.x, CGRectGetMaxY(title1.frame)+12+6);
        smallTitle3.font = [UIFont systemFontOfSize:12];
        smallTitle3.textColor = UNMAIN_TEXT_COLOR;
        [self addSubview:smallTitle3];
        
        UILabel *priceLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 17)];
        priceLabel1.textAlignment = NSTextAlignmentCenter;
        priceLabel1.text = [NSString stringWithFormat:@"¥%d",price1+handPrice];
        priceLabel1.center = CGPointMake(imageView1.center.x, CGRectGetMaxY(smallTitle1.frame)+9+17/2);
        priceLabel1.font = [UIFont systemFontOfSize:17];
        priceLabel1.textColor = UNMAIN_TEXT_COLOR;
        [self addSubview:priceLabel1];
        
//        int price2 = price2;
//        int price3 = ;
//        int a = (price - 890)/100%2;
//        if (a>0) {
//            price2 = (price - 890 - 100)/2;
//            price3 = price - 890 -price2;
//        }else{
//            price2 = (price - 890)/2;
//            price3 = price2;
//        }
        
        UILabel *priceLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 17)];
        priceLabel2.textAlignment = NSTextAlignmentCenter;
        priceLabel2.text = [NSString stringWithFormat:@"¥%d",price2];
        priceLabel2.center = CGPointMake(imageView2.center.x, CGRectGetMaxY(smallTitle1.frame)+9+17/2);
        priceLabel2.font = [UIFont systemFontOfSize:17];
        priceLabel2.textColor = UNMAIN_TEXT_COLOR;
        [self addSubview:priceLabel2];
        
        UILabel *priceLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 17)];
        priceLabel3.textAlignment = NSTextAlignmentCenter;
        priceLabel3.text = [NSString stringWithFormat:@"¥%d",price3];
        priceLabel3.center = CGPointMake(imageView3.center.x, CGRectGetMaxY(smallTitle1.frame)+9+17/2);
        priceLabel3.font = [UIFont systemFontOfSize:17];
        priceLabel3.textColor = UNMAIN_TEXT_COLOR;
        [self addSubview:priceLabel3];
    }
    return self;
}



@end
