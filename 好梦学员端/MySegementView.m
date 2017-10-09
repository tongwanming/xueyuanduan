//
//  MySegementView.m
//  MyScrollView
//
//  Created by 刘刘智明 on 16/6/28.
//  Copyright © 2016年 lzm. All rights reserved.
//

#import "MySegementView.h"
#define SEGEMENT_BTN_WIDTH 70

@implementation MySegementView


- (instancetype) initWithFrame:(CGRect)frame titleArray : (NSArray *)titleArray block : (btnClickedBlock) clickedBlock
{
    self = [super initWithFrame:frame];
    [self addSubview:self.segementScrollView];
    if (self) {
//        [self setBackgroundColor:[UIColor colorWithRed:0x2d/255.0 green:0x2a/255.0 blue:0x2b/255.0 alpha:1]];
        [self setBackgroundColor:[UIColor whiteColor]];
        self.block = clickedBlock;
        nPageIndex = 1;
        titleCount = titleArray.count;
        btnArray = [NSMutableArray array];
        for (int i = 0; i < titleCount; i++) {
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(i * SEGEMENT_BTN_WIDTH, 0, SEGEMENT_BTN_WIDTH, 48)];
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
//            btn.titleLabel.font = [UIFont fontWithName:@"Arial" size:14];
            if (i == 0) {
                [btn setTitleColor:BLUE_BACKGROUND_COLOR forState:UIControlStateNormal];
            }else{
                [btn setTitleColor:UNMAIN_TEXT_COLOR forState:UIControlStateNormal];
            }
            
            btn.tag = i + 1;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
            [self.segementScrollView addSubview:btn];
            [btnArray addObject:btn];
        }
        self.selectedLine.frame = CGRectMake(0, 48, SEGEMENT_BTN_WIDTH, 2);
        [self.segementScrollView addSubview: self.selectedLine];
        self.segementScrollView.contentSize = CGSizeMake(titleCount * SEGEMENT_BTN_WIDTH, 0);
    }
    return self;
}

//懒加载
- (UIScrollView *)segementScrollView
{
    if (_segementScrollView == nil) {
        CGRect rect = self.frame;
        _segementScrollView = [[UIScrollView alloc] initWithFrame:rect];
        _segementScrollView.showsHorizontalScrollIndicator = NO;
        _segementScrollView.showsVerticalScrollIndicator = NO;
        _segementScrollView.bounces = NO;
        _segementScrollView.pagingEnabled = NO;
        _segementScrollView.delegate = self;
        _segementScrollView.scrollsToTop = NO;
    }
    return _segementScrollView;
}

//懒加载
- (UIView *)selectedLine
{
    if (_selectedLine == nil) {
        _selectedLine = [[UIView alloc] init];
        _selectedLine.backgroundColor = BLUE_BACKGROUND_COLOR;
    }
    return _selectedLine;
}

//设置当前页面，并更新顶部标签页
- (void)setPageIndex:(int)nIndex
{
    if (nIndex != nPageIndex) {
        nPageIndex = nIndex;
        [self refreshSegement];
    }
}

- (void)refreshSegement
{
    //找到当前选中页面对应的顶部按钮
    for (UIButton *btn in btnArray) {
        if (btn.tag == nPageIndex) {
            currentBtn = btn;
        }
    }
    
    //如果选中页面对应按钮超出可视范围，顶部滚动视图滚动
//    int x = currentBtn.frame.origin.x;
     if (currentBtn.frame.origin.x + SEGEMENT_BTN_WIDTH > self.frame.size.width + self.segementScrollView.contentOffset.x) {
     [self.segementScrollView setContentOffset:CGPointMake(self.segementScrollView.contentOffset.x + SEGEMENT_BTN_WIDTH, 0) animated:YES];
     }
     else if (currentBtn.frame.origin.x < self.segementScrollView.contentOffset.x)
     {
     [self.segementScrollView setContentOffset:CGPointMake(currentBtn.frame.origin.x, 0) animated:YES];
     }

    //下方选中标记线条滚动效果
    [UIView animateWithDuration:0.2 animations:^{
    _selectedLine.frame = CGRectMake(currentBtn.frame.origin.x, self.frame.size.height - 2, SEGEMENT_BTN_WIDTH, 2);
        [currentBtn setTitleColor:BLUE_BACKGROUND_COLOR forState:UIControlStateNormal];
    }completion:^(BOOL finished) {
        
    }];
}

- (void)btnClick:(UIButton*)btn
{
    currentBtn = btn;
    for (UIButton *button in btnArray) {
        [button setTitleColor:UNMAIN_TEXT_COLOR forState:UIControlStateNormal];
    }
    if (nPageIndex != btn.tag) {
        nPageIndex = btn.tag;
        [self refreshSegement];
        self.block((int)nPageIndex);
    }
}
@end
