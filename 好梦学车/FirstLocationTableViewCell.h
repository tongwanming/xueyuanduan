//
//  FirstLocationTableViewCell.h
//  好梦学车
//
//  Created by haomeng on 2017/5/2.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "FirstBasicTableViewCell.h"

typedef void(^locationBlock)(NSArray *data);

typedef void(^locationBlockProvince)(NSString *province);

@protocol FirstLocationTableViewCellDelegate <NSObject>

- (void)firstLocationTableViewCellSubCellSelectActive:(NSIndexPath *)indexpath andData:(NSArray *)array;

@end

@interface FirstLocationTableViewCell : FirstBasicTableViewCell
@property (weak, nonatomic) IBOutlet UIView *subView;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, weak)id<FirstLocationTableViewCellDelegate>delegate;

@property (nonatomic, copy)locationBlock block;

@property (nonatomic, copy) locationBlockProvince provinceBlock;

- (void)retunLoadDataWithBlock:(locationBlock)block;

- (void)retunLoadDataWithProvinceBlock:(locationBlockProvince)block;

@end
