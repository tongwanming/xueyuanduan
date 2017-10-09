//
//  commonActiveHelper.m
//  safetyProduction
//
//  Created by tongwanming on 16/5/4.
//  Copyright © 2016年 tidalicHifi. All rights reserved.
//

#import "commonActiveHelper.h"

#define BACK_GROUND_COLOR RGBAN(237, 239, 239, 255)
#ifndef RGBA
#define RGBA(r, g, b, a)                     [UIColor colorWithRed:r green:g blue:b alpha:a]
#define RGBAN(r, g, b, a)                   RGBA(r / 255.0, g / 255.0, b / 255.0, a / 100.0)
#endif


@implementation commonActiveHelper

+(commonActiveHelper *)shareDefault{
    static commonActiveHelper *manger;
    static dispatch_once_t precadicate;
    dispatch_once(&precadicate, ^{
        manger = [[commonActiveHelper alloc] init];
    });
    return manger;
}

+(UIButton *)createBtnWithName:(NSString *)name andImage:(UIImage *)image andTag:(NSInteger)tag{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    return btn;
}

+ (UIButton *)createBtnWithTitle:(NSString *)title andTag:(NSInteger)tag andActive:(void (^)(NSInteger))completed{
    return [[commonActiveHelper shareDefault] createBtnWithTitle:title andTag:tag andActive:completed];
    
}

-(UIButton *)createBtnWithTitle:(NSString *)title andTag:(NSInteger)tag andActive:(void (^)(NSInteger))completed{
    _btnClick = completed;
    UIButton *btn = [[UIButton alloc] init];
    [btn setTintColor:[UIColor blackColor]];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn addTarget:self action:@selector(btnClickActive:) forControlEvents:UIControlEventTouchUpInside];
    _tag = tag;
    return btn;
}

- (void)btnClickActive:(UIButton *)btn{
    if (_btnClick) {
        _btnClick(_tag);
    }
}

+(UIControl *)createControlWithImage:(UIImage *)image andTitle:(NSString *)title andWidth:(CGFloat)width andTag:(NSInteger)tag andClickBlock:(void (^)(NSInteger))completed{
    return [[commonActiveHelper shareDefault] createControlWithImage:image andTitle:title andWidth:width andTag:tag andClickBlock:completed];
}

-(UIControl *)createControlWithImage:(UIImage *)image andTitle:(NSString *)title andWidth:(CGFloat)width andTag:(NSInteger)tag andClickBlock:(void (^)(NSInteger))completed{
    UIControl *control = [[UIControl alloc] init];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 40, 40)];
    imageV.image = image;
    imageV.layer.cornerRadius = 40/2.0;
    imageV.layer.masksToBounds = YES;
    [control addSubview:imageV];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 60, 20)];
    titleLabel.text = title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:10];
    [control addSubview:titleLabel];
    
    [control addTarget:self action:@selector(controlClick:) forControlEvents:UIControlEventTouchUpInside];
    _tag = tag;
    _btnClick = completed;
    control.tag = tag;
    
    return control;
}

- (void)controlClick:(UIControl *)control{
    if (_btnClick) {
        _btnClick(control.tag);
    }
}

+(UIControl *)createControlWithlogoImage:(UIImage *)image andTitle:(NSString *)title andSubTitle:(NSString *)subTitle andTag:(NSInteger)tag andBtnClickBlock:(void (^)(NSInteger))completed{
    return [[commonActiveHelper shareDefault] createControlWithlogoImage:image andTitle:title andSubTitle:subTitle andTag:tag andBtnClickBlock:completed];
}

-(UIControl *)createControlWithlogoImage:(UIImage *)image andTitle:(NSString *)title andSubTitle:(NSString *)subTitle andTag:(NSInteger)tag andBtnClickBlock:(void (^)(NSInteger))completed{
    _logoBtnClickActive = completed;
    UIControl *control = [[UIControl alloc] init];
    control.tag = tag;
    [control addTarget:self action:@selector(logoControlClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, [UIScreen mainScreen].bounds.size.width/2, 20)];
    titleLabel.text = title;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor blackColor];
    [control addSubview:titleLabel];
    
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 25, [UIScreen mainScreen].bounds.size.width/2, 18)];
    subTitleLabel.text = subTitle;
    subTitleLabel.font = [UIFont systemFontOfSize:8];
    subTitleLabel.textColor = [UIColor grayColor];
    subTitleLabel.textAlignment = NSTextAlignmentLeft;
    [control addSubview:subTitleLabel];
    
    UIImageView *imageVew = [[UIImageView alloc] init];
    imageVew.image = image;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = BACK_GROUND_COLOR;
    if (tag==0) {
        imageVew.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-85, 44, 80, 50);
        lineView.frame = CGRectMake(0, 103, [UIScreen mainScreen].bounds.size.width/2, 1);
    }else{
        imageVew.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2-40, 16, 32, 32);
        lineView.frame = CGRectMake(0, 51, [UIScreen mainScreen].bounds.size.width/2, 1);
    }
    
    [control addSubview:lineView];
    [control addSubview:imageVew];
    
    
    
    return control;
}

- (void)logoControlClick:(UIControl *)control{
    if (_logoBtnClickActive) {
        _logoBtnClickActive(control.tag);
    }
}

+(UIButton *)createBtnWithColor:(UIColor *)color andRadius:(CGFloat)radius andTitle:(NSString *)title andCompleteBlook:(void (^)(void))completed{
    return [[commonActiveHelper shareDefault] createBtnWithColor:color andRadius:radius andTitle:title andCompleteBlook:completed];
}

-(UIButton *)createBtnWithColor:(UIColor *)color andRadius:(CGFloat)radius andTitle:(NSString *)title andCompleteBlook:(void (^)(void))completed{
    _normalBtnClick = completed;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTintColor:color];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.layer.cornerRadius = radius;
    btn.layer.masksToBounds = YES;
    btn.layer.borderColor = color.CGColor;
    btn.layer.borderWidth = 1.0;
    [btn addTarget:self action:@selector(norBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    return btn;
}

-(void)norBtnClick:(UIButton *)btn{
    if (_normalBtnClick) {
        _normalBtnClick();
    }
}

@end
