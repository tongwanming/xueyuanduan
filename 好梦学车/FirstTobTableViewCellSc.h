//
//  FirstTobTableViewCellSc.h
//  好梦学车
//
//  Created by haomeng on 2017/6/30.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "FirstBasicTableViewCell.h"

typedef void(^firstTapTableViewCellBlock)(NSInteger tag);

@interface FirstTobTableViewCellSc : FirstBasicTableViewCell

@property (nonatomic, strong) NSArray *arr;

@property (nonatomic, copy)firstTapTableViewCellBlock block;

- (void)addBlockActive:(firstTapTableViewCellBlock)block;

@end
