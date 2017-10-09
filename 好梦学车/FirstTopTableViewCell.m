//
//  FirstTopTableViewCell.m
//  好梦学车
//
//  Created by haomeng on 2017/5/2.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "FirstTopTableViewCell.h"
#import "IanScrollView.h"

@interface FirstTopTableViewCell ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation FirstTopTableViewCell

- (void)awakeFromNib{
    [super awakeFromNib];
    IanScrollView *scrollView = [[IanScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 274)];
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 1; i < 5; i ++) {
        [array addObject:[NSString stringWithFormat:@"http://childmusic.qiniudn.com/huandeng/%ld.png", (long)i]];
    }
    scrollView.backgroundColor = [UIColor redColor];
    scrollView.slideImagesArray = array;
    scrollView.ianEcrollViewSelectAction = ^(NSInteger i){
        
        NSLog(@"点击了%ld张图片",(long)i);
        
    };
    scrollView.ianCurrentIndex = ^(NSInteger index){
        NSLog(@"测试一下：%ld",(long)index);
    };
    scrollView.PageControlPageIndicatorTintColor = [UIColor colorWithRed:255/255.0f green:244/255.0f blue:227/255.0f alpha:1];
    scrollView.pageControlCurrentPageIndicatorTintColor = [UIColor colorWithRed:67/255.0f green:174/255.0f blue:168/255.0f alpha:1];
    scrollView.autoTime = [NSNumber numberWithFloat:4.0f];
    NSLog(@"%@",scrollView.slideImagesArray);
    [scrollView startLoading];
    [self addSubview:scrollView];
}

@end
