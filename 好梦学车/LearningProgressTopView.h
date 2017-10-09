//
//  LearningProgressTopView.h
//  好梦学车
//
//  Created by haomeng on 2017/7/10.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LearningProgressTopViewDelegate <NSObject>

- (void)LearningProgressTopViewBtnClick:(UIButton *)btn;

@end

@interface LearningProgressTopView : UIView

@property (nonatomic, weak) id<LearningProgressTopViewDelegate>delegate;

- (void)setCurrentChoosed:(NSInteger)choosedInt;

@end
