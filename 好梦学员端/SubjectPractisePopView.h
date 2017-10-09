//
//  SubjectPractisePopView.h
//  好梦学车
//
//  Created by haomeng on 2017/5/20.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubjectPractiseTabPanelPopView.h"
#import "SubjectPractiseTabPanelPopViewModel.h"

@protocol SubjectPractisePopViewDelegate <NSObject>

- (void)SubjectPractisePopViewBtn:(UIButton *)btn;

- (void)SubjectPractisePopViewWithIndex:(NSIndexPath *)index;

@end

@interface SubjectPractisePopView : UIView

@property (nonatomic, weak)id<SubjectPractisePopViewDelegate>deleagte;

- (instancetype)initWithPopUpBackGroundViewWithRect:(CGRect)rect
                                         andAddView:(UIViewController *)currentAddViewController
                                            andData:(SubjectPractiseTabPanelPopViewModel *)model
                                         completion:(void(^)(SubjectPractiseTabPanelPopView *popView_))completion
                                           andIndex:(void(^)(NSInteger integer_))integer;
+ (void)creatPopUpBackGroundViewWithRect:(CGRect)rect
                              andAddView:(UIViewController *)currentAddViewController
                                 andData:(SubjectPractiseTabPanelPopViewModel *)model
                              completion:(void(^)(SubjectPractiseTabPanelPopView *popView_))completion
                                andIndex:(void(^)(NSInteger integer_))integer;

+ (void)popClose;

@end
