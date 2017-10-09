//
//  MyLearnScrollView.h
//  好梦学车
//
//  Created by haomeng on 2017/7/31.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLearningSegementView.h"

@protocol MyLearnScrollViewDelegate <NSObject>

-(void)myLearnScrollViewBtnClickWithIndex:(NSString *)index;

@end

@interface MyLearnScrollView : UIView<UIScrollViewDelegate>

- (instancetype) initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray viewArray:(NSArray *)viewArray;

//滚动页面
@property (strong, nonatomic)UIScrollView *myScrollView;

//顶部标签按钮滚动视图
@property (strong, nonatomic)MyLearningSegementView *mySegementView;

@property (nonatomic, weak) id<MyLearnScrollViewDelegate>delegate;

@end
