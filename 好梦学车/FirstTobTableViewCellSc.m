//
//  FirstTobTableViewCellSc.m
//  好梦学车
//
//  Created by haomeng on 2017/6/30.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "FirstTobTableViewCellSc.h"
#import "IanScrollView.h"

@interface FirstTobTableViewCellSc ()

@property (nonatomic, strong) IanScrollView *scrollView;

@end

@implementation FirstTobTableViewCellSc

- (void)awakeFromNib{
    [super awakeFromNib];
 
}

- (void)addBlockActive:(firstTapTableViewCellBlock)block{
    _block = block;
}

- (void)setArr:(NSArray *)arr{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 274*TYPERATION)];
    imageView.image = [UIImage imageNamed:@"pic04"];
    [self addSubview:imageView];
    if (arr.count < 1) {
        return;
    }else{
        for (UIView *v in self.subviews) {
            if ([v isKindOfClass:[UIImageView class]]) {
                [v removeFromSuperview];
            }
        }
    }
    
    imageView.hidden = YES;
    _arr = arr;
    _scrollView = [[IanScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 274*TYPERATION)];
    NSMutableArray *array = [NSMutableArray arrayWithArray:_arr];
    //    for (NSInteger i = 1; i < 5; i ++) {
    //        [array addObject:[NSString stringWithFormat:@"http://childmusic.qiniudn.com/huandeng/%ld.png", (long)i]];
    //    }
//    _scrollView.backgroundColor = [UIColor redColor];
    _scrollView.slideImagesArray = array;
    
    __weak __typeof(&*self)weakSelf = self;
    _scrollView.ianEcrollViewSelectAction = ^(NSInteger i){
        
//        NSLog(@"点击了%ld张图片",i);
        if (weakSelf.block) {
            weakSelf.block(i);
        }
        
    };
    _scrollView.ianCurrentIndex = ^(NSInteger index){
        NSLog(@"测试一下：%ld",(long)index);
    };
    _scrollView.PageControlPageIndicatorTintColor = [UIColor colorWithRed:255/255.0f green:244/255.0f blue:227/255.0f alpha:1];
    _scrollView.pageControlCurrentPageIndicatorTintColor = [UIColor colorWithRed:67/255.0f green:174/255.0f blue:168/255.0f alpha:1];
    _scrollView.autoTime = [NSNumber numberWithFloat:4.0f];
    NSLog(@"%@",_scrollView.slideImagesArray);
    [_scrollView startLoading];
    [self addSubview:_scrollView];
}

@end
