//
//  SubjectPopTopView.m
//  好梦学车
//
//  Created by haomeng on 2017/5/20.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectPopTopView.h"

@implementation SubjectPopTopView{
    UILabel *_titleLabel;
    UIButton *_delectBtn;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
}

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)setSecntion:(NSInteger)secntion{
    _secntion = secntion;
    _delectBtn.tag = secntion;
}

- (void)setTitleNameStr:(NSString *)titleNameStr{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, CURRENT_BOUNDS.width-100, 38)];
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _titleLabel.textColor = ADB1B9;
    [self addSubview:_titleLabel];
    
    _delectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _delectBtn.frame = CGRectMake(CURRENT_BOUNDS.width-70, 12.5, 70, 13);
    _delectBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_delectBtn setTitleColor:UNMAIN_TEXT_COLOR forState:UIControlStateNormal];
    [_delectBtn setImage:[UIImage imageNamed:@"pop_btn_delete"] forState:UIControlStateNormal];
    _delectBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_delectBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_delectBtn setTitle:@"清空" forState:UIControlStateNormal];
    [self addSubview:_delectBtn];
    _titleNameStr = titleNameStr;
    _titleLabel.text = titleNameStr;
}

- (void)btnClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(subjectPopTopViewBtnClickWithBtn:)]) {
        [self.delegate performSelector:@selector(subjectPopTopViewBtnClickWithBtn:) withObject:btn];
    }
}

@end
