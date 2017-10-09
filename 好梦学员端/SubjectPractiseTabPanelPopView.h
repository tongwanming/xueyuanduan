//
//  SubjectPractiseTabPanelPopView.h
//  好梦学车
//
//  Created by haomeng on 2017/5/20.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubjectPractiseTabPanelPopViewModel.h"

@protocol SubjectPractiseTabPanelPopViewDelegate <NSObject>

- (void)topViewBtnClcikWithBtn:(UIButton *)btn;

- (void)SubjectPractiseTabPanelPopViewDelegateWithCollection:(NSIndexPath *)index;


@end

@interface SubjectPractiseTabPanelPopView : UIView

@property (nonatomic, strong) SubjectPractiseTabPanelPopViewModel *model;

@property (nonatomic, weak) id<SubjectPractiseTabPanelPopViewDelegate>delegate;

@end
