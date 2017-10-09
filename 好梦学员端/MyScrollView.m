//
//  MyScrollView.m
//  MyScrollView
//
//  Created by 刘刘智明 on 16/6/28.
//  Copyright © 2016年 lzm. All rights reserved.
//

#define SCROLLVIEW_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCROLLVIEW_HEIGTH self.bounds.size.height
#define SEGEMENT_HEIGTHT 50

#import "MyScrollView.h"

@implementation MyScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype) initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray viewArray:(NSArray *)viewArray
{
    self = [super initWithFrame:frame];
    if (_mySegementView == nil) {
        _mySegementView = [[MySegementView alloc] initWithFrame:CGRectMake(0, 0, SCROLLVIEW_WIDTH, SEGEMENT_HEIGTHT) titleArray:titleArray block:^void(int index){  //用block实现回调，顶部按钮点击的时候滚动到指定位置
            [_myScrollView setContentOffset:CGPointMake((index - 1) * SCROLLVIEW_WIDTH, 0)];
            if ([self.delegate respondsToSelector:@selector(myScrollViewBtnClickWithIndex:)]) {
                [self.delegate performSelector:@selector(myScrollViewBtnClickWithIndex:) withObject:@(index)];
            }
        }];
    }
    [self addSubview:_mySegementView];
    [self addSubview:self.myScrollView];
    
    if (self) {
//        for (int i = 0; i < viewArray.count; i++) {
//            UIViewController *viewController = viewArray[i];
//            viewController.view.frame = CGRectMake(i * SCROLLVIEW_WIDTH, 0, SCROLLVIEW_WIDTH, self.myScrollView.frame.size.height);
//            [self.myScrollView addSubview:viewController.view];
//        }
        self.myScrollView.contentSize = CGSizeMake(viewArray.count * SCROLLVIEW_WIDTH, 0);
    }
    
    return self;
}


// 滚动页面视图懒加载
- (UIScrollView *)myScrollView
{
    if (_myScrollView == nil) {
        _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _mySegementView.frame.size.height, SCROLLVIEW_WIDTH, SCROLLVIEW_HEIGTH - _mySegementView.frame.size.height)];
        _myScrollView.backgroundColor = [UIColor clearColor];
        _myScrollView.delegate = self;
        _myScrollView.showsVerticalScrollIndicator = NO;
        _myScrollView.showsHorizontalScrollIndicator = NO;
        _myScrollView.bounces = NO;
        _myScrollView.scrollsToTop = NO;
        _myScrollView.pagingEnabled = YES;
        
    }
    return _myScrollView;
}

//滚动结束，更新按钮下方线条
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==_myScrollView)
    {
        int p=_myScrollView.contentOffset.x / SCROLLVIEW_WIDTH;
        [_mySegementView setPageIndex:p + 1];
    }
}

@end
