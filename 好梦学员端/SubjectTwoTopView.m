//
//  SubjectTwoTopView.m
//  好梦学车
//
//  Created by haomeng on 2017/5/11.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectTwoTopView.h"
#import "SubjectTwoBtn.h"

@implementation SubjectTwoTopView{
    UIView *_subView1;
    UIView *_subView2;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initze];
    }
    return self;
}

- (void)initze{
    
    _subView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, 94)];
    _subView1.backgroundColor = BLUE_BACKGROUND_COLOR;
    [self addSubview:_subView1];
    
    _subView2 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_subView1.frame), CURRENT_BOUNDS.width, self.frame.size.height-94)];
    _subView2.backgroundColor = [UIColor colorWithRed:0.94f green:0.95f blue:0.96f alpha:1.00f];
    [self addSubview:_subView2];
    
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(16, 25, CURRENT_BOUNDS.width-32, 114)];
    subView.backgroundColor = [UIColor whiteColor];
    subView.layer.cornerRadius = 8;
    subView.layer.masksToBounds = YES;
    [self addSubview:subView];
    
    SubjectTwoBtn *btn1 = [SubjectTwoBtn buttonWithType:UIButtonTypeCustom];
    btn1.tag = 1001;
    btn1.frame = CGRectMake(0, 0, (CURRENT_BOUNDS.width-32)/3, 114);
    [btn1 addTarget:self action:@selector(btnClickAvtive:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setImage:[UIImage imageNamed:@"btn_cheats"] forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn1 setTitleColor:ADB1B9 forState:UIControlStateNormal];
    [btn1 setTitle:@"必过秘籍" forState:UIControlStateNormal];
    [subView addSubview:btn1];
    
    SubjectTwoBtn *btn2 = [SubjectTwoBtn buttonWithType:UIButtonTypeCustom];
    btn2.tag = 1002;
    btn2.frame = CGRectMake((CURRENT_BOUNDS.width-32)/3, 0, (CURRENT_BOUNDS.width-32)/3, 114);
    [btn2 addTarget:self action:@selector(btnClickAvtive:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setImage:[UIImage imageNamed:@"btn_single"] forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn2 setTitleColor:ADB1B9 forState:UIControlStateNormal];
    [btn2 setTitle:@"单向解析" forState:UIControlStateNormal];
    [subView addSubview:btn2];
    
    SubjectTwoBtn *btn3 = [SubjectTwoBtn buttonWithType:UIButtonTypeCustom];
    btn3.tag = 1003;
    btn3.frame = CGRectMake((CURRENT_BOUNDS.width-32)/3*2, 0, (CURRENT_BOUNDS.width-32)/3, 114);
    [btn3 addTarget:self action:@selector(btnClickAvtive:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 setImage:[UIImage imageNamed:@"btn_subject"] forState:UIControlStateNormal];
    btn3.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn3 setTitleColor:ADB1B9 forState:UIControlStateNormal];
    [btn3 setTitle:@"科目考规" forState:UIControlStateNormal];
    [subView addSubview:btn3];
    
    SubjectTwoBtn *btn4 = [SubjectTwoBtn buttonWithType:UIButtonTypeCustom];
    btn4.tag = 1004;
    btn4.frame = CGRectMake((CURRENT_BOUNDS.width-32)/4*3, 0, (CURRENT_BOUNDS.width-32)/4, 114);
    [btn4 addTarget:self action:@selector(btnClickAvtive:) forControlEvents:UIControlEventTouchUpInside];
    [btn4 setImage:[UIImage imageNamed:@"btn_save"] forState:UIControlStateNormal];
    btn4.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn4 setTitleColor:ADB1B9 forState:UIControlStateNormal];
    [btn4 setTitle:@"我的收藏" forState:UIControlStateNormal];
//    [subView addSubview:btn4];

}

- (void)btnClickAvtive:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(subjectTwoTopViewBtnClickWithBtn:)]) {
        [self.delegate performSelector:@selector(subjectTwoTopViewBtnClickWithBtn:) withObject:btn];
    }
    
}
@end
