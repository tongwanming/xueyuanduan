//
//  LearningProgressTopView.m
//  好梦学车
//
//  Created by haomeng on 2017/7/10.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "LearningProgressTopView.h"

@implementation LearningProgressTopView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self= [super initWithFrame:frame]) {
        for (int i = 0; i <[self getData].count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(8+(CURRENT_BOUNDS.width-16)/([self getData].count)*i, 0, (CURRENT_BOUNDS.width-16)/[self getData].count, 34);
            btn.tag = i;
            [btn setTitle:[self getData][i] forState:UIControlStateNormal];
            
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            [btn setTitleColor:BLUE_BACKGROUND_COLOR forState:UIControlStateSelected];
            btn.layer.cornerRadius = 17;
            btn.layer.masksToBounds = YES;
            btn.backgroundColor = [UIColor clearColor];
            btn.userInteractionEnabled = YES;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
    }
    return self;
}

- (void)btnClick:(UIButton *)btn{
    [self setCurrentChoosed:btn.tag];
    if ([self.delegate respondsToSelector:@selector(LearningProgressTopViewBtnClick:)]) {
        [self.delegate performSelector:@selector(LearningProgressTopViewBtnClick:) withObject:btn];
    }
    
}

- (void)setCurrentChoosed:(NSInteger)choosedInt{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            if (((UIButton *)view).tag == choosedInt) {
                ((UIButton *)view).selected = YES;
                ((UIButton *)view).backgroundColor = [UIColor whiteColor];
            }else{
                ((UIButton *)view).selected = NO;
            ((UIButton *)view).backgroundColor = [UIColor clearColor];
            }
        }
    }
}

- (NSArray *)getData{
    NSArray *arr = @[@"报名",@"科目一",@"科目二",@"科目三",@"领证"];
    
    return arr;
}

@end
