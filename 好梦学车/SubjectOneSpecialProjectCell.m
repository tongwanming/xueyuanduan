//
//  SubjectOneSpecialProjectCell.m
//  好梦学车
//
//  Created by haomeng on 2017/5/13.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectOneSpecialProjectCell.h"
#import "SubjectOneSpecialProjectBtn.h"

@implementation SubjectOneSpecialProjectCell{
    UILabel *_titleLabel;
    NSMutableArray *_btnData;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 20, CURRENT_BOUNDS.width - 32, 16)];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_titleLabel];
    _titleLabel.text = titleStr;
}

- (void)setDataArr:(NSArray *)dataArr{
    if (dataArr.count < 1) {
        return;
    }
    _dataArr = dataArr;
    _btnData = [[NSMutableArray alloc] init];
    for (int i = 0; i < dataArr.count; i++) {
        int a = i/2;
        int b = i%2;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(b*CURRENT_BOUNDS.width/2, 55+58*a, CURRENT_BOUNDS.width/2, 0.5)];
        lineView.backgroundColor = ADB1B9;
        [self addSubview:lineView];
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width/2-0.5, 55+10+58*a, 0.5, 38)];
        lineView2.backgroundColor = ADB1B9;
        [self addSubview:lineView2];
        SubjectOneSpecialProjectBtn *btn = [[SubjectOneSpecialProjectBtn alloc] initWithFrame:CGRectMake(b*CURRENT_BOUNDS.width/2, 55+58*a+1, CURRENT_BOUNDS.width/2-1, 56)];
        btn.tag = i+1000;
        [self addSubview:btn];
        [btn addTarget:self action:@selector(btnClickActive:) forControlEvents:UIControlEventTouchUpInside];
        [_btnData addObject:btn];
        btn.model = dataArr[i];
//        btn.backgroundColor = [UIColor greenColor];
    }
}

- (void)btnClickActive:(SubjectOneSpecialProjectBtn *)btn{
    if ([btn.model.numLabel isEqualToString:@"0"]) {
        
    }else{
        if ([self.delegate respondsToSelector:@selector(SubjectOneSpecialProjectCellTapWith:andTitle:)]) {
            [self.delegate performSelector:@selector(SubjectOneSpecialProjectCellTapWith:andTitle:) withObject:btn withObject:_titleStr];
        }
    }
   
//    NSLog(@"按钮的tag值:%ld",(long)btn.tag);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
