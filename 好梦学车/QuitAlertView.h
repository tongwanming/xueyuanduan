//
//  QuitAlertView.h
//  好梦学车
//
//  Created by haomeng on 2017/4/25.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuitBoxView.h"

@protocol QuitAlertViewBtnClickedDelegate <NSObject>

- (void)btnClickedWithBtn:(UIButton *)btn;

@end


@interface QuitAlertView : UIView<QuitBoxViewDelegate>


@property (nonatomic, weak) id <QuitAlertViewBtnClickedDelegate> delegate;

@property (nonatomic, strong) NSString *describeStr;

@property (nonatomic, strong) NSString *letfTitle;

@property (nonatomic, strong) NSString *rightTitle;

+ (instancetype)createShowView;

/**
 *  @brief 弹出提醒框
 */
- (void)presentAddView:(UIView *)view;

/**
 *  @brief 弹出提醒框
 */
- (void)dismissSync;

@end
