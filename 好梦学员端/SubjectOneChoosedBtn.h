//
//  SubjectOneChoosedBtn.h
//  好梦学车
//
//  Created by haomeng on 2017/5/11.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SubjectOneChoosedBtnType) {
    SubjectOneChoosedBtnTypeOne,
    SubjectOneChoosedBtnTypeTwo,
};

@interface SubjectOneChoosedBtn : UIControl

@property (nonatomic, strong) UIImageView *backGroundImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *logoImageView;

- (instancetype)initWithFrame:(CGRect)frame andType:(SubjectOneChoosedBtnType)type andProgress:(NSInteger)progress;

@end
