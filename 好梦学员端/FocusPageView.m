//
//  FocusPageView.m
//  abc
//
//  Created by haomeng on 2017/4/18.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "FocusPageView.h"


#define SpaceWidth 10
#define SpaceHeight 10

@implementation FocusPageView{
    int _currentSelectIndex;
    UIColor *_selecColor;
    UIColor *_backColor;
}

- (instancetype)initWithFrame:(CGRect)frame andShouNumber:(int)num andBackColor:(UIColor *)backColor andSelectColor:(UIColor *)selectColor andSpace:(CGFloat)space selectIndex:(int)selectIndex{
    self = [super initWithFrame:frame];
    if (self) {
        _currentSelectIndex = selectIndex;
        _selecColor = selectColor;
        _backColor = backColor;
        for (int i = 0; i < num; i++) {
            UIView *v = [[UIView alloc] init];
            v.backgroundColor = backColor;
            if (selectIndex == i) {
                v.backgroundColor = selectColor;
            }
            v.frame = CGRectMake(i*(space+SpaceWidth), 0, SpaceWidth, SpaceHeight);
            [self addSubview:v];
        }
    }
    return self;
}

- (void)setSelectIndex:(int)selectIndex{
    _currentSelectIndex = selectIndex;
    for (UIView *view  in self.subviews) {
        view.backgroundColor = _backColor;
    }
    
    for (int i = 0; i < self.subviews.count; i++) {
        if (_currentSelectIndex == i) {
            UIView *view = self.subviews[i];
            view.backgroundColor = _selecColor;
        }
    }
}

@end
