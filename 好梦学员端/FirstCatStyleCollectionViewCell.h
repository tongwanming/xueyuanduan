//
//  FirstCatStyleCollectionViewCell.h
//  好梦学车
//
//  Created by haomeng on 2017/5/3.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstCatStyleModel.h"
#import "ChoosedClassModel.h"

@interface FirstCatStyleCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) ChoosedClassModel *model;

@property (nonatomic, strong) FirstCatStyleModel *locationModel;

@end
