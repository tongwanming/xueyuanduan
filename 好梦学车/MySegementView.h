//
//  MySegementView.h
//  MyScrollView
//
//  Created by 刘刘智明 on 16/6/28.
//  Copyright © 2016年 lzm. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^btnClickedBlock)(int index);

@interface MySegementView : UIView<UIScrollViewDelegate>
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
