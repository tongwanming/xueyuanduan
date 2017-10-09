//
//  myLearningTapView.m
//  好梦学车
//
//  Created by haomeng on 2017/7/31.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "myLearningTapView.h"

@implementation myLearningTapView{
    UILabel *_sectionTitleLabel;
    UILabel *_titleLabel;
    UIImageView *_logoImageView;
    NSInteger _currentIndex;
    UIView *lineView;
}

- (instancetype)initWithFrame:(CGRect)frame andName:(NSString *)name andProgress:(NSString *)progress andIndexPath:(NSInteger)indexPath andBloc:(tapLearningSectionView)topViewBlock{
    if (self = [super initWithFrame:frame]) {
        
        self.topBlock = topViewBlock;
        _currentIndex = indexPath;
        
        _sectionTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 32, 32)];
        _sectionTitleLabel.text = [NSString stringWithFormat:@"%@.%ld",progress,(long)indexPath];
        _sectionTitleLabel.textColor = ADB1B9;
        _sectionTitleLabel.backgroundColor = WHITE_TEXT_COLOR;
        _sectionTitleLabel.textAlignment = NSTextAlignmentCenter;
        _sectionTitleLabel.font = [UIFont systemFontOfSize:13];
        _sectionTitleLabel.layer.cornerRadius = 4;
        _sectionTitleLabel.layer.masksToBounds = YES;
        _sectionTitleLabel.layer.borderWidth = 1;
        _sectionTitleLabel.layer.borderColor = ADB1B9.CGColor;
        [self addSubview:_sectionTitleLabel];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_sectionTitleLabel.frame)+16, (62-16)/2, 200, 16)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor = TEXT_COLOR;
        _titleLabel.text = name;
        [self addSubview:_titleLabel];
        
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width-27, 0, 14, 8)];
        _logoImageView.center = CGPointMake(CURRENT_BOUNDS.width-27, 62/2);
        _logoImageView.image = [UIImage imageNamed:@"btn_study_unfolded"];
        [self addSubview:_logoImageView];
        
        lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 61.5, CURRENT_BOUNDS.width-20, 0.5)];
        lineView.backgroundColor = EEEEEE;
        [self addSubview:lineView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureActive:)];
        [self addGestureRecognizer:tap];
        
        
    }
    return self;
}

- (void)tapGestureActive:(UITapGestureRecognizer *)gesture{
    NSString *style = @"normal";
    if ([_sectionTitleLabel.textColor isEqual:ADB1B9]) {
        _sectionTitleLabel.backgroundColor = BLUE_BACKGROUND_COLOR;
        _sectionTitleLabel.textColor = WHITE_TEXT_COLOR;
        _sectionTitleLabel.layer.borderColor = BLUE_BACKGROUND_COLOR.CGColor;
        
        _logoImageView.image = [UIImage imageNamed:@"btn_study_putaway"];
        style = @"selected";
        lineView.hidden = YES;
    }else{
        _sectionTitleLabel.textColor = ADB1B9;
        _sectionTitleLabel.backgroundColor = WHITE_TEXT_COLOR;
        _sectionTitleLabel.layer.borderColor = ADB1B9.CGColor;
        _logoImageView.image = [UIImage imageNamed:@"btn_study_unfolded"];
        lineView.hidden = NO;
        style = @"normal";
    }
    if (self.topBlock) {
        self.topBlock(style,_currentIndex);
    }
}

@end
