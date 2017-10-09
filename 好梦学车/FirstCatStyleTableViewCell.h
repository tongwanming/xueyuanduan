//
//  FirstCatStyleTableViewCell.h
//  好梦学车
//
//  Created by haomeng on 2017/5/2.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "FirstBasicTableViewCell.h"
#import "HorizontalFlowLayout.h"
#import "FirstCatStyleModel.h"
#import "FirstCatStyleCollectionViewCell.h"

@protocol FirstCatStyleTableViewCellDelegate <NSObject>

- (void)firstCatStyleTableViewCellSubCellDidSelectActiveAndIndex:(NSIndexPath *)indexPath;

@end

@interface FirstCatStyleTableViewCell : FirstBasicTableViewCell

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, weak) id<FirstCatStyleTableViewCellDelegate>delegate;

@end
