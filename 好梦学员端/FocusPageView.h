//
//  FocusPageView.h
//  abc
//
//  Created by haomeng on 2017/4/18.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FocusPageView : UIView

//@property (nonatomic, strong) UIColor *backColor;//底色,未使用
//
//@property (nonatomic, strong) UIColor *selectColor;//选中的颜色，未使用\

@property (nonatomic, assign) int selectIndex;


- (instancetype)initWithFrame:(CGRect)frame andShouNumber:(int)num andBackColor:(UIColor *)backColor andSelectColor:(UIColor *)selectColor andSpace:(CGFloat)space selectIndex:(int)selectIndex;


@end
