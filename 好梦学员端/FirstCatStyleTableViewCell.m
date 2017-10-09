//
//  FirstCatStyleTableViewCell.m
//  好梦学车
//
//  Created by haomeng on 2017/5/2.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "FirstCatStyleTableViewCell.h"

@interface FirstCatStyleTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>



@end

@implementation FirstCatStyleTableViewCell

- (NSMutableArray *)getCatStyleData{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSArray *imageArr = @[@"101",@"201",@"301",@"401",@"501"];
    NSArray *typeArr = @[@"都市普通班",@"都市经典班",@"经典小灶班",@"一价全包班",@"B2大货车班"];
    NSArray *priceArr = @[@"2,390",@"2,890",@"3,390",@"3,990",@"1,2500"];
    for (int i = 0; i < imageArr.count; i++) {
        FirstCatStyleModel *model = [[FirstCatStyleModel alloc] init];
        model.backGroundImageName = imageArr[i];
        model.type = typeArr[i];
        model.price = priceArr[i];
        [arr addObject:model];
    }
    return arr;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor redColor];
    HorizontalFlowLayout *layout = [[HorizontalFlowLayout alloc] init];
    
    CGRect rct = self.bounds;
    rct.size.height = 110;
    rct.origin.y = 56;
//    rct.origin.x = -16;
//    rct.size.width = CURRENT_BOUNDS.width+25;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:rct collectionViewLayout:layout];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateNormal;
    
    [self.collectionView registerClass:[FirstCatStyleCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([FirstCatStyleCollectionViewCell class])];
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    [self.collectionView setDelegate:self];
    [self.collectionView setDataSource:self];
    
    [self addSubview:_collectionView];
    

}

- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    [_collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_dataArray && _dataArray.count > 0) {
        return _dataArray.count;
    }else
        return [self getCatStyleData].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FirstCatStyleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FirstCatStyleCollectionViewCell class]) forIndexPath:indexPath];
    
    if (_dataArray && _dataArray.count > 0) {
        cell.model = _dataArray[indexPath.row];
    }else{
        cell.locationModel = [self getCatStyleData][indexPath.row];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (CGSize)collectionView:(nonnull UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return CGSizeMake(140, collectionView.bounds.size.height);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    
    if ([self.delegate respondsToSelector:@selector(firstCatStyleTableViewCellSubCellDidSelectActiveAndIndex:)]) {
        [self.delegate performSelector:@selector(firstCatStyleTableViewCellSubCellDidSelectActiveAndIndex:) withObject:indexPath];
    }
    //滚动到中间
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

//使前后项都能居中显示
- (UIEdgeInsets)collectionView:(nonnull UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    NSInteger itemCount = [self collectionView:collectionView numberOfItemsInSection:section];
    
    NSIndexPath *firstIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    CGSize firstSize = [self collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:firstIndexPath];
    
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForItem:itemCount - 1 inSection:section];
    CGSize lastSize = [self collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:lastIndexPath];
    
    return UIEdgeInsetsMake(0, 16,
                            0, (collectionView.bounds.size.width - lastSize.width) / 9);
}




@end
