//
//  IPopView.h
//  Lightning DS
//
//  Created by tongwanming on 15/8/24.
//  Copyright (c) 2015年 com.auralic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IPopUpWithPromptView.h"

@interface IPopView : UIView

//创建当前的popView的方法
- (instancetype)initWithPopUpBackGroundViewWithRect:(CGRect)rect
                                         andAddView:(UIViewController *)currentAddViewController
                                  andTitleNameArray:(NSArray *)NameArray
                                           andStyle:(IPopUpWithPromptViewStyle)style
                                         completion:(void(^)(IPopUpWithPromptView *popView_))completion;

+ (void)createPopUpBackGroundViewWithRect:(CGRect)rect
                               andAddView:(UIViewController *)currentAddViewController
                        andTitleNameArray:(NSArray *)NameArray
                                 andStyle:(IPopUpWithPromptViewStyle)style
                               completion:(void(^)(IPopUpWithPromptView *popView_))completion;

+ (void)popClose;

@end
