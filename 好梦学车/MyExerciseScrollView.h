//
//  MyExerciseScrollView.h
//  好梦学车
//
//  Created by haomeng on 2017/5/12.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyExerciseSegementView.h"

@protocol MyExerciseScrollViewDelegate <NSObject>

-(void)myScrollViewBtnClickWithIndex:(NSString *)index;

@end

@interface MyExerciseScrollView : UIView<UIScrollViewDelegate>

- (instancetype) initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray viewArray:(NSArray *)viewArray;

//滚动页面
@property (strong, nonatomic)UIScrollView *myScrollView;

//顶部标签按钮滚动视图
@property (strong, nonatomic)MyExerciseSegementView *mySegementView;

@property (nonatomic, weak) id<MyExerciseScrollViewDelegate>delegate;

@end
