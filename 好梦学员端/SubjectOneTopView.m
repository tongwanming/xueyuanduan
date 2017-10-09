//
//  SubjectOneTopView.m
//  好梦学车
//
//  Created by haomeng on 2017/5/11.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectOneTopView.h"
#import "SubjectOneChoosedBtn.h"
#import "SubjectOneBtn.h"
#import "SubjectPractiseViewController.h"

@implementation SubjectOneTopView{
    UIView *_subView1;
    UIView *_subView2;
    UIView *_subView3;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       
        [self initize];
    }
    
    return self;
}

- (void)setType:(NSString *)type{
    if ([type isEqualToString:@"1"]) {
        NSString *index = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@and%ld",@"order",(long)PractiseViewControllerTypeOne]];
        CGFloat f = [index floatValue]/1229.0*100;
        _title2.text = [NSString stringWithFormat:@"%.0lf",f];
        NSString *objectTure = [[NSUserDefaults standardUserDefaults] objectForKey:@"objectOneTrue"];
        if (objectTure == nil) {
            _title4.text = @"0";
        }else{
            _title4.text = objectTure;
        }
    }else{
        NSString *index = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@and%ld",@"order",(long)PractiseViewControllerTypeForth]];
        CGFloat f = [index floatValue]/1094.0*100;
        _title2.text = [NSString stringWithFormat:@"%.0lf",f];
        NSString *objectTure = [[NSUserDefaults standardUserDefaults] objectForKey:@"objectForthTrue"];
        if (objectTure == nil) {
            _title4.text = @"0";
        }else{
            _title4.text = [NSString stringWithFormat:@"%ld",[objectTure integerValue]*2];
        }
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initize{
    _subView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, 186)];
    _subView1.backgroundColor = BLUE_BACKGROUND_COLOR;
    [self addSubview:_subView1];
    
    _subView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 186, CURRENT_BOUNDS.width, self.bounds.size.height-186)];
    _subView2.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.98f alpha:1.00f];;
    [self addSubview:_subView2];
    
    _subView3 = [[UIView alloc] initWithFrame:CGRectMake(16, 25, CURRENT_BOUNDS.width-32, 277)];
    _subView3.backgroundColor = [UIColor whiteColor];
    _subView3.layer.cornerRadius = 8;
    _subView3.layer.masksToBounds = YES;
    [self addSubview:_subView3];
    
    _title1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 26, 100, 12)];
    _title1.textColor = UNMAIN_TEXT_COLOR;
    _title1.text = @"练题进度";
    _title1.font = [UIFont systemFontOfSize:12];
    [_subView3 addSubview:_title1];
    
    _title2 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_title1.frame)+12, 90, 50)];
    _title2.textColor = TEXT_COLOR;
    _title2.text = @"12";
    _title2.textAlignment = NSTextAlignmentRight;
    _title2.font = [UIFont systemFontOfSize:50];
    
//    _title2.backgroundColor = [UIColor redColor];
    [_subView3 addSubview:_title2];
    UILabel *titleSub1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_title2.frame), CGRectGetMaxY(_title2.frame)-15,25, 15)];
    titleSub1.textColor = TEXT_COLOR;
    titleSub1.text = [NSString stringWithFormat:@"%@%%",@""];
    titleSub1.font = [UIFont systemFontOfSize:15];
    [_subView3 addSubview:titleSub1];
    
    _title3 = [[UILabel alloc] initWithFrame:CGRectMake(_subView3.frame.size.width/2+50, 26, 100, 12)];
    _title3.textColor = UNMAIN_TEXT_COLOR;
    _title3.text = @"考试最高分";
    _title3.font = [UIFont systemFontOfSize:12];
    [_subView3 addSubview:_title3];
    
    _title4 = [[UILabel alloc] initWithFrame:CGRectMake(_subView3.frame.size.width/2+10, CGRectGetMaxY(_title1.frame)+12, 100, 50)];
    _title4.textColor = TEXT_COLOR;
    _title4.text = @"96";
    _title4.font = [UIFont systemFontOfSize:50];
    _title4.textAlignment = NSTextAlignmentRight;
//    _title4.backgroundColor = [UIColor redColor];
    [_subView3 addSubview:_title4];
    UILabel *titleSub2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_title4.frame), CGRectGetMaxY(_title4.frame)-15, 25, 15)];
    titleSub2.textColor = TEXT_COLOR;
    titleSub2.text = @"分";
    titleSub2.font = [UIFont systemFontOfSize:15];
    [_subView3 addSubview:titleSub2];
    
    SubjectOneChoosedBtn *leftBtn = [[SubjectOneChoosedBtn alloc] initWithFrame:CGRectMake(23 * TYPERATION, CGRectGetMaxY(_title4.frame)+26, 127 * TYPERATION, 47* TYPERATION) andType:SubjectOneChoosedBtnTypeOne andProgress:12];
    leftBtn.tag = 1001;
    leftBtn.userInteractionEnabled = YES;
    [leftBtn addTarget:self action:@selector(btnClickActive:) forControlEvents:UIControlEventTouchUpInside];
//    leftBtn.backgroundColor = [UIColor redColor];
    [_subView3 addSubview:leftBtn];
    
    SubjectOneChoosedBtn *rightBtn = [[SubjectOneChoosedBtn alloc] initWithFrame:CGRectMake(_subView3.frame.size.width-23* TYPERATION-127* TYPERATION, CGRectGetMaxY(_title4.frame)+26, 127* TYPERATION, 47* TYPERATION) andType:SubjectOneChoosedBtnTypeTwo andProgress:96];
    rightBtn.tag = 1002;
    rightBtn.userInteractionEnabled = YES;
    [rightBtn addTarget:self action:@selector(btnClickActive:) forControlEvents:UIControlEventTouchUpInside];
    [_subView3 addSubview:rightBtn];
    
    SubjectOneBtn *btn1 = [SubjectOneBtn buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 182, _subView3.frame.size.width/4, 95);
    [btn1 setImage:[UIImage imageNamed:@"btn_random"] forState:UIControlStateNormal];
    [btn1 setTitle:@"随机练习" forState:UIControlStateNormal];
    [btn1 setTitleColor:C4C6CC forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:13];
    btn1.tag = 1003;
    [btn1 addTarget:self action:@selector(btnClickActive:) forControlEvents:UIControlEventTouchUpInside];
    [_subView3 addSubview:btn1];
    
    SubjectOneBtn *btn2 = [SubjectOneBtn buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(_subView3.frame.size.width/4, 182, _subView3.frame.size.width/4, 95);
    [btn2 setImage:[UIImage imageNamed:@"btn_special"] forState:UIControlStateNormal];
    [btn2 setTitle:@"专项练习" forState:UIControlStateNormal];
    [btn2 setTitleColor:C4C6CC forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:13];
    btn2.tag = 1004;
    [btn2 addTarget:self action:@selector(btnClickActive:) forControlEvents:UIControlEventTouchUpInside];
    [_subView3 addSubview:btn2];
    
    SubjectOneBtn *btn3 = [SubjectOneBtn buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(_subView3.frame.size.width/4*2, 182, _subView3.frame.size.width/4, 95);
    [btn3 setImage:[UIImage imageNamed:@"btn_results"] forState:UIControlStateNormal];
    [btn3 setTitle:@"考试记录" forState:UIControlStateNormal];
    [btn3 setTitleColor:C4C6CC forState:UIControlStateNormal];
    btn3.titleLabel.font = [UIFont systemFontOfSize:13];
    btn3.tag = 1005;
    [btn3 addTarget:self action:@selector(btnClickActive:) forControlEvents:UIControlEventTouchUpInside];
    [_subView3 addSubview:btn3];
    
    SubjectOneBtn *btn4 = [SubjectOneBtn buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(_subView3.frame.size.width/4*3, 182, _subView3.frame.size.width/4, 95);
    [btn4 setImage:[UIImage imageNamed:@"btn_reservation"] forState:UIControlStateNormal];
    [btn4 setTitle:@"预约考试" forState:UIControlStateNormal];
    [btn4 setTitleColor:C4C6CC forState:UIControlStateNormal];
    btn4.titleLabel.font = [UIFont systemFontOfSize:13];
    btn4.tag = 1006;
    [btn4 addTarget:self action:@selector(btnClickActive:) forControlEvents:UIControlEventTouchUpInside];
    [_subView3 addSubview:btn4];
    
}

- (void)btnClickActive:(UIButton *)btn{
    
    if ([self.delegate respondsToSelector:@selector(subjectOneTopViewBtnClickWithBtn:)]) {
        [self.delegate performSelector:@selector(subjectOneTopViewBtnClickWithBtn:) withObject:btn];
    }
    NSLog(@"btnClick");
}

@end
