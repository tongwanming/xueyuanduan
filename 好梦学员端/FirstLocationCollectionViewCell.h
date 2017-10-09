//
//  FirstLocationCollectionViewCell.h
//  好梦学车
//
//  Created by haomeng on 2017/5/3.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstLocationModel.h"

@interface FirstLocationCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) FirstLocationModel *model;

@property (nonatomic, assign) BOOL choosed;

@end
