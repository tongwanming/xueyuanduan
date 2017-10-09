//
//  TopSubView.m
//  好梦学车
//
//  Created by haomeng on 2017/5/4.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "TopSubView.h"

#import "ChoosedCocchLayout.h"

#import "CocchShowCollectionViewCell.h"

#import "ChoosedCocchModel.h"

#import <QuartzCore/QuartzCore.h>

@interface TopSubView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonnull, strong) NSIndexPath *choosedIndexPath;

@end

@implementation TopSubView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initCollectionView];
    }
    return self;
}

- (void)initCollectionView{
    ChoosedCocchLayout *layout = [[ChoosedCocchLayout alloc] init];
    
    CGRect rct = self.bounds;
    rct.size.height = 195;
    rct.origin.y = 17;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:rct collectionViewLayout:layout];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateNormal;
    _choosedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.collectionView registerClass:[CocchShowCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([CocchShowCollectionViewCell class])];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    
    [self addSubview:_collectionView];
    
//    CALayer *leftLayer = [CALayer layer];
//    leftLayer.frame = CGRectMake(0, 17, (CURRENT_BOUNDS.width-140)/2, self.collectionView.frame.size.height);
//    leftLayer.backgroundColor = [UIColor grayColor].CGColor;
//    leftLayer.opacity = 0.5;
//    [self.layer addSublayer:leftLayer];
//    
//    CALayer *rightLayer = [CALayer layer];
//    rightLayer.frame = CGRectMake(CURRENT_BOUNDS.width - (CURRENT_BOUNDS.width-140)/2, 17, (CURRENT_BOUNDS.width-140)/2, self.collectionView.frame.size.height);
//    rightLayer.backgroundColor = [UIColor grayColor].CGColor;
//    rightLayer.opacity = 0.5;
//    [self.layer addSublayer:rightLayer];
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 12, 12)];
    logoImageView.image = [UIImage imageNamed:@"icon_choosecoach_triangle"];
    logoImageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height-3.5);
    logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:logoImageView];
    
}

- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CocchShowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CocchShowCollectionViewCell class]) forIndexPath:indexPath];
    
    ChoosedCocchModel *model = [_dataArr objectAtIndex:indexPath.row];
 
    cell.model = model;
//    cell.alpha = 0.5;
    cell.index = indexPath;
    
//    NSLog(@"当前的位置：%ld",(long)indexPath.row);
    return cell;
}

- (CGSize)collectionView:(nonnull UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return CGSizeMake(140, collectionView.bounds.size.height);
}

//使前后项都能居中显示
- (UIEdgeInsets)collectionView:(nonnull UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    NSInteger itemCount = [self collectionView:collectionView numberOfItemsInSection:section];
    
    NSIndexPath *firstIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    CGSize firstSize = [self collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:firstIndexPath];
    
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:itemCount - 1 inSection:section];
    CGSize lastSize = [self collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:lastIndexPath];
    
    return UIEdgeInsetsMake(0, (collectionView.bounds.size.width - firstSize.width) / 2,
                            0, (collectionView.bounds.size.width - lastSize.width) / 2);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    
    //滚动到中间
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    _choosedIndexPath = indexPath;
    if ([self.delegate respondsToSelector:@selector(scrollViewStopWithIndex:)]) {
        [self.delegate performSelector:@selector(scrollViewStopWithIndex:) withObject:indexPath];
    }

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    NSLog(@"水平距离：----%f",scrollView.contentOffset.x);

}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    for (CocchShowCollectionViewCell *cell in self.collectionView.visibleCells) {
//        cell.alpha = 0.5;
//        
//    }
    
    CGPoint orifinalTargetContentOffset = CGPointMake(targetContentOffset->x, targetContentOffset->y);
  
    NSIndexPath *index = [NSIndexPath indexPathForRow:(NSInteger)(orifinalTargetContentOffset.x/150) inSection:0];
    
    _choosedIndexPath = index;
    if ([self.delegate respondsToSelector:@selector(scrollViewStopWithIndex:)]) {
        [self.delegate performSelector:@selector(scrollViewStopWithIndex:) withObject:index];
    }
    

}



@end
