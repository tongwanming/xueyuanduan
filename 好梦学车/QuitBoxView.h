//
//  QuitBoxView.h
//  好梦学车
//
//  Created by haomeng on 2017/4/25.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QuitBoxViewDelegate <NSObject>

- (void)QuitBoxViewBtnClick:(UIButton *)btn;

@end

@interface QuitBoxView : UIView
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (weak, nonatomic) IBOutlet UIButton *LookBtn;
@property (weak, nonatomic) IBOutlet UIButton *LeaveBtn;

@property (nonatomic, weak) id<QuitBoxViewDelegate>delegate;

@end
