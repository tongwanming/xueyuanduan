//
//  CocchShowCollectionViewCell.h
//  好梦学车
//
//  Created by haomeng on 2017/5/4.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChoosedCocchModel.h"

@interface CocchShowCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) ChoosedCocchModel *model;

@property (nonatomic, strong) NSIndexPath *index;

@end
