//
//  TopChoosedClassView.m
//  好梦学车
//
//  Created by haomeng on 2017/6/28.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "TopChoosedClassView.h"

#import "CustomFlowLayout.h"

#import "ChoosedClassCollectionViewCell.h"

#import "ChoosedClassModel.h"

@interface TopChoosedClassView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation TopChoosedClassView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initCollectionView];
    }
    return self;
}

- (void)initCollectionView{
    CustomFlowLayout *layout = [[CustomFlowLayout alloc] init];
    
    CGRect rct = self.bounds;
    rct.size.height = 150;
    rct.origin.y = 17;
//    layout.minimumInteritemSpacing = 10;
    self.collectionView = [[UICollectionView alloc] initWithFrame:rct collectionViewLayout:layout];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateNormal;
    
    [self.collectionView registerClass:[ChoosedClassCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ChoosedClassCollectionViewCell class])];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    
    [self addSubview:_collectionView];
}

- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ChoosedClassCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ChoosedClassCollectionViewCell class]) forIndexPath:indexPath];
    
    ChoosedClassModel *model = [_dataArr objectAtIndex:indexPath.row];
    
    cell.model = model;
    //    NSLog(@"当前的位置：%ld",(long)indexPath.row);
    return cell;
}

- (CGSize)collectionView:(nonnull UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return CGSizeMake(250*TYPERATION, collectionView.bounds.size.height);
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
    if ([self.delegate respondsToSelector:@selector(scrollViewStopWithIndex:)]) {
        [self.delegate performSelector:@selector(scrollViewStopWithIndex:) withObject:indexPath];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //    NSLog(@"水平距离：----%f",scrollView.contentOffset.x);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    
    CGPoint orifinalTargetContentOffset = CGPointMake(targetContentOffset->x, targetContentOffset->y);
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:(NSInteger)(orifinalTargetContentOffset.x/150) inSection:0];
    if ([self.delegate respondsToSelector:@selector(scrollViewStopWithIndexTwo:)]) {
        [self.delegate performSelector:@selector(scrollViewStopWithIndexTwo:) withObject:index];
    }
    
}


@end
