//
//  IPricePopView.m
//  好梦学车
//
//  Created by haomeng on 2017/6/28.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "IPricePopView.h"


#define LEFT_WIDTH 25

@implementation IPricePopView{
    CGRect _oldRect;
    UIView *_popView;
}

- (instancetype)initWithPopViewWithName:(NSString *)name andTitle1:(NSString *)title1 title2:(NSString *)title2 title3:(NSString *)title3 descr1:(NSString *)descr1 descr2:(NSString *)descr2 descr3:(NSString *)descr3 andVC:(UIViewController *)vc{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = [UIScreen mainScreen].bounds;
        [vc.view.window addSubview:self];
        
        _popView = [[UIView alloc] initWithFrame:CGRectMake(15, CURRENT_BOUNDS.height, CURRENT_BOUNDS.width-30, CURRENT_BOUNDS.height-150)];
        
        _popView.backgroundColor = [UIColor whiteColor];
        _popView.layer.masksToBounds = YES;
        _popView.layer.cornerRadius = 5;
        [self addSubview:_popView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, _popView.frame.size.width, 25*TYPERATION)];
        titleLabel.text = name;
        titleLabel.textColor = TEXT_COLOR;
        titleLabel.font = [UIFont boldSystemFontOfSize:25*TYPERATION];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_popView addSubview:titleLabel];
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_WIDTH*TYPERATION, CGRectGetMaxY(titleLabel.frame)+35*TYPERATION, _popView.frame.size.width-2*LEFT_WIDTH, 16*TYPERATION)];
        priceLabel.textColor = TEXT_COLOR;
        priceLabel.textAlignment = NSTextAlignmentLeft;
        priceLabel.font = [UIFont boldSystemFontOfSize:16*TYPERATION];
        priceLabel.text = title1;
        [_popView addSubview:priceLabel];
        
        UILabel *decPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_WIDTH*TYPERATION, CGRectGetMaxY(priceLabel.frame)+12*TYPERATION, _popView.frame.size.width-2*LEFT_WIDTH, [self heightForString:descr1 andWidth:_popView.frame.size.width-2*LEFT_WIDTH])];
        decPriceLabel.font = [UIFont systemFontOfSize:13*TYPERATION];
        decPriceLabel.numberOfLines = 0;
        decPriceLabel.textAlignment = NSTextAlignmentLeft;
        decPriceLabel.textColor = UNMAIN_TEXT_COLOR;
        decPriceLabel.text = descr1;
        [_popView addSubview:decPriceLabel];
        
        UILabel *priceLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_WIDTH*TYPERATION, CGRectGetMaxY(decPriceLabel.frame)+35*TYPERATION, _popView.frame.size.width-2*LEFT_WIDTH*TYPERATION, 16*TYPERATION)];
        priceLabel1.textColor = TEXT_COLOR;
        priceLabel1.textAlignment = NSTextAlignmentLeft;
        priceLabel1.font = [UIFont boldSystemFontOfSize:16*TYPERATION];
        priceLabel1.text = title2;
        [_popView addSubview:priceLabel1];
        UILabel *decPriceLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_WIDTH*TYPERATION, CGRectGetMaxY(priceLabel1.frame)+12*TYPERATION, _popView.frame.size.width-2*LEFT_WIDTH*TYPERATION, [self heightForString:descr2 andWidth:_popView.frame.size.width-2*LEFT_WIDTH*TYPERATION])];
        decPriceLabel1.font = [UIFont systemFontOfSize:13*TYPERATION];
        decPriceLabel1.numberOfLines = 0;
        decPriceLabel1.textAlignment = NSTextAlignmentLeft;
        decPriceLabel1.textColor = UNMAIN_TEXT_COLOR;
        decPriceLabel1.text = descr2;
        [_popView addSubview:decPriceLabel1];
        
        UILabel *priceLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_WIDTH*TYPERATION, CGRectGetMaxY(decPriceLabel1.frame)+35*TYPERATION, _popView.frame.size.width-2*LEFT_WIDTH*TYPERATION, 16*TYPERATION)];
        priceLabel2.textColor = TEXT_COLOR;
        priceLabel2.textAlignment = NSTextAlignmentLeft;
        priceLabel2.font = [UIFont boldSystemFontOfSize:16*TYPERATION];
        priceLabel2.text = title3;
        [_popView addSubview:priceLabel2];
        UILabel *decPriceLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_WIDTH*TYPERATION, CGRectGetMaxY(priceLabel2.frame)+12*TYPERATION, _popView.frame.size.width-2*LEFT_WIDTH*TYPERATION, [self heightForString:descr3 andWidth:_popView.frame.size.width-2*LEFT_WIDTH*TYPERATION])];
        decPriceLabel2.font = [UIFont systemFontOfSize:13*TYPERATION];
        decPriceLabel2.numberOfLines = 0;
        decPriceLabel2.textAlignment = NSTextAlignmentLeft;
        decPriceLabel2.textColor = UNMAIN_TEXT_COLOR;
        decPriceLabel2.text = descr3;
        [_popView addSubview:decPriceLabel2];
        
//        UILabel *decPriceLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_WIDTH*TYPERATION, CGRectGetMaxY(decPriceLabel2.frame), _popView.frame.size.width-2*LEFT_WIDTH*TYPERATION, 13*4*TYPERATION)];
//        decPriceLabel3.font = [UIFont systemFontOfSize:13*TYPERATION];
//        decPriceLabel3.numberOfLines = 4;
//        decPriceLabel3.textAlignment = NSTextAlignmentLeft;
//        decPriceLabel3.textColor = UNMAIN_TEXT_COLOR;
//        decPriceLabel3.text = @"和场费：考试前一天，学员可自愿选择在考场自费租考试专用车进行模拟考试，提高通过率。费用32到400元不等，考试费由考场收取，具体以实际收费为准。";
//        [_popView addSubview:decPriceLabel3];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(0, 0, 48, 32);
        cancelBtn.backgroundColor = [UIColor clearColor];
        cancelBtn.center = CGPointMake(_popView.frame.size.width-20, 30);
        [cancelBtn addTarget:self action:@selector(popViewClose) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn setImage:[UIImage imageNamed:@"btn_close"] forState:UIControlStateNormal];
//        cancelBtn.backgroundColor = [UIColor redColor];
//        [cancelBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        [_popView addSubview:cancelBtn];
        
        UIButton *cancelBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn2.frame = CGRectMake(0, _popView.frame.size.height-60, _popView.frame.size.width, 60);
        cancelBtn2.backgroundColor = [UIColor clearColor];
//        cancelBtn2.center = CGPointMake(_popView.frame.size.width-30, 40);
        cancelBtn2.backgroundColor = BLUE_BACKGROUND_COLOR;
        [cancelBtn2 addTarget:self action:@selector(popViewClose) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn2 setTitle:@"知道了" forState:UIControlStateNormal];
        [_popView addSubview:cancelBtn2];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popViewClose) name:@"closeIPricePopView" object:nil];
        
    }
    
    //添加 手势弹回popView
    UIView *touchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, [[UIScreen mainScreen] bounds].size.height - _popView.frame.size.height)];
    touchView.backgroundColor = [UIColor clearColor];
    [self addSubview:touchView];
    
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenPopView)];
    [touchView addGestureRecognizer:tapGest];
    
    //动画效果
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.backgroundColor = POPVIEW_BACKGROUND_COLOR;
            _popView.frame = CGRectMake(15, 150/2, _popView.frame.size.width, _popView.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    });
    
    return self;
}

- (instancetype)initWithPopViewWithName:(NSString *)name andPrice:(NSString *)price andExamPrice:(NSString *)examPrice andVC:(UIViewController *)vc{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = [UIScreen mainScreen].bounds;
        [vc.view.window addSubview:self];
        
        _popView = [[UIView alloc] initWithFrame:CGRectMake(15, CURRENT_BOUNDS.height, CURRENT_BOUNDS.width-30, CURRENT_BOUNDS.height-150)];
        
        _popView.backgroundColor = [UIColor whiteColor];
        _popView.layer.masksToBounds = YES;
        _popView.layer.cornerRadius = 5;
        [self addSubview:_popView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, _popView.frame.size.width, 25*TYPERATION)];
        titleLabel.text = @"费用详情";
        titleLabel.textColor = TEXT_COLOR;
        titleLabel.font = [UIFont systemFontOfSize:25*TYPERATION];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_popView addSubview:titleLabel];
        
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_WIDTH*TYPERATION, CGRectGetMaxY(titleLabel.frame)+35*TYPERATION, _popView.frame.size.width-2*LEFT_WIDTH, 16*TYPERATION)];
        priceLabel.textColor = TEXT_COLOR;
        priceLabel.textAlignment = NSTextAlignmentLeft;
        priceLabel.font = [UIFont systemFontOfSize:16*TYPERATION];
        priceLabel.text = [NSString stringWithFormat:@"培训费:%@元",price];
        [_popView addSubview:priceLabel];
        
        UILabel *decPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_WIDTH*TYPERATION, CGRectGetMaxY(priceLabel.frame), _popView.frame.size.width-2*LEFT_WIDTH, 13*3*TYPERATION+10*TYPERATION)];
        decPriceLabel.font = [UIFont systemFontOfSize:13*TYPERATION];
        decPriceLabel.numberOfLines = 3;
        decPriceLabel.textAlignment = NSTextAlignmentLeft;
        decPriceLabel.textColor = UNMAIN_TEXT_COLOR;
        decPriceLabel.text = @"包含入籍费、培训费、体检费、工本费、合同、IC卡、结业证费、保险、税金、红十字会费。";
        [_popView addSubview:decPriceLabel];
        
        UILabel *priceLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_WIDTH*TYPERATION, CGRectGetMaxY(decPriceLabel.frame)+35*TYPERATION, _popView.frame.size.width-2*LEFT_WIDTH*TYPERATION, 16*TYPERATION)];
        priceLabel1.textColor = TEXT_COLOR;
        priceLabel1.textAlignment = NSTextAlignmentLeft;
        priceLabel1.font = [UIFont systemFontOfSize:16*TYPERATION];
        priceLabel1.text = [NSString stringWithFormat:@"考试费:%@元(自理)",examPrice];
        [_popView addSubview:priceLabel1];
        UILabel *decPriceLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_WIDTH*TYPERATION, CGRectGetMaxY(priceLabel1.frame)+12*TYPERATION, _popView.frame.size.width-2*LEFT_WIDTH*TYPERATION, 13*TYPERATION)];
        decPriceLabel1.font = [UIFont systemFontOfSize:13*TYPERATION];
        decPriceLabel1.numberOfLines = 2;
        decPriceLabel1.textAlignment = NSTextAlignmentLeft;
        decPriceLabel1.textColor = UNMAIN_TEXT_COLOR;
        decPriceLabel1.text = @"科目一50元／科目二160元／科目三180元。";
        [_popView addSubview:decPriceLabel1];
        
        UILabel *priceLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_WIDTH*TYPERATION, CGRectGetMaxY(decPriceLabel1.frame)+35*TYPERATION, _popView.frame.size.width-2*LEFT_WIDTH*TYPERATION, 16*TYPERATION)];
        priceLabel2.textColor = TEXT_COLOR;
        priceLabel2.textAlignment = NSTextAlignmentLeft;
        priceLabel2.font = [UIFont systemFontOfSize:16*TYPERATION];
        priceLabel2.text = @"额外费用";
        [_popView addSubview:priceLabel2];
        UILabel *decPriceLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_WIDTH*TYPERATION, CGRectGetMaxY(priceLabel2.frame)+12*TYPERATION, _popView.frame.size.width-2*LEFT_WIDTH*TYPERATION, 13*TYPERATION)];
        decPriceLabel2.font = [UIFont systemFontOfSize:13*TYPERATION];
        decPriceLabel2.numberOfLines = 2;
        decPriceLabel2.textAlignment = NSTextAlignmentLeft;
        decPriceLabel2.textColor = UNMAIN_TEXT_COLOR;
        decPriceLabel2.text = @"补考费：科目一25元／科目二160元／科目三180元";
        [_popView addSubview:decPriceLabel2];
        
        UILabel *decPriceLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(LEFT_WIDTH*TYPERATION, CGRectGetMaxY(decPriceLabel2.frame), _popView.frame.size.width-2*LEFT_WIDTH*TYPERATION, 13*4*TYPERATION)];
        decPriceLabel3.font = [UIFont systemFontOfSize:13*TYPERATION];
        decPriceLabel3.numberOfLines = 4;
        decPriceLabel3.textAlignment = NSTextAlignmentLeft;
        decPriceLabel3.textColor = UNMAIN_TEXT_COLOR;
        decPriceLabel3.text = @"和场费：考试前一天，学员可自愿选择在考场自费租考试专用车进行模拟考试，提高通过率。费用32到400元不等，考试费由考场收取，具体以实际收费为准。";
        [_popView addSubview:decPriceLabel3];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(0, 0, 48, 32);
        cancelBtn.backgroundColor = [UIColor clearColor];
        cancelBtn.center = CGPointMake(_popView.frame.size.width-20, 30);
        [cancelBtn addTarget:self action:@selector(popViewClose) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn setImage:[UIImage imageNamed:@"btn_close"] forState:UIControlStateNormal];
        //        cancelBtn.backgroundColor = [UIColor redColor];
        //        [cancelBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        [_popView addSubview:cancelBtn];
        
        UIButton *cancelBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn2.frame = CGRectMake(0, _popView.frame.size.height-60, _popView.frame.size.width, 60);
        cancelBtn2.backgroundColor = [UIColor clearColor];
        //        cancelBtn2.center = CGPointMake(_popView.frame.size.width-30, 40);
        cancelBtn2.backgroundColor = BLUE_BACKGROUND_COLOR;
        [cancelBtn2 addTarget:self action:@selector(popViewClose) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn2 setTitle:@"知道了" forState:UIControlStateNormal];
        [_popView addSubview:cancelBtn2];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popViewClose) name:@"closeIPricePopView" object:nil];
        
    }
    
    //添加 手势弹回popView
    UIView *touchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, [[UIScreen mainScreen] bounds].size.height - _popView.frame.size.height)];
    touchView.backgroundColor = [UIColor clearColor];
    [self addSubview:touchView];
    
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenPopView)];
    [touchView addGestureRecognizer:tapGest];

    //动画效果
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.backgroundColor = POPVIEW_BACKGROUND_COLOR;
            _popView.frame = CGRectMake(15, 150/2, _popView.frame.size.width, _popView.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    });
    
    return self;
}

+ (void)createPopviewWithName:(NSString *)name andPrice:(NSString *)price andExamPrice:(NSString *)examPrice andVC:(UIViewController *)vc{
    IPricePopView *view = [[self alloc] initWithPopViewWithName:name andPrice:price andExamPrice:examPrice andVC:vc];
}

+ (void)createPopviewWithName:(NSString *)name title1:(NSString *)title1 title2:(NSString *)title2 title3:(NSString *)title3 descr1:(NSString *)descr1 descr2:(NSString *)descr2 descr3:(NSString *)descr3 andVC:(UIViewController *)vc{
    IPricePopView *view = [[self alloc] initWithPopViewWithName:name andTitle1:title1 title2:title2 title3:title3 descr1:descr1 descr2:descr2 descr3:descr3 andVC:vc];
}

- (void)popViewClose{
    [self popViewHidden];
}

- (void)hiddenPopView{
    [self popViewHidden];
}


- (void)popViewHidden{
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _popView.frame = CGRectMake(15, self.frame.size.height, _popView.frame.size.width, _popView.frame.size.height);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
    }];
}


+ (void)popClose{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeIPricePopView" object:nil];
}

- (float)heightForString:(NSString *)titleString andWidth:(float)width{
    CGSize titleSize = [titleString boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    return titleSize.height;
}



@end
