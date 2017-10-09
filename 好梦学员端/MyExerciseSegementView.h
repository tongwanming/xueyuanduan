//
//  MyExerciseSegementView.h
//  好梦学车
//
//  Created by haomeng on 2017/5/12.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^btnClickedBlock)(int index);

@interface MyExerciseSegementView : UIView<UIScrollViewDelegate>
{
    NSInteger nPageIndex;
    NSInteger titleCount;
    UIButton *currentBtn;
    NSMutableArray *btnArray;
}

- (void)setPageIndex:(int)nIndex;

- (instancetype) initWithFrame:(CGRect)frame titleArray : (NSArray *)titleArray block : (btnClickedBlock) clickedBlock;

@property (nonatomic, copy) btnClickedBlock block;

@property (strong, nonatomic) UIScrollView *segementScrollView;

@property (strong, nonatomic) UIView *selectedLine;

@end
