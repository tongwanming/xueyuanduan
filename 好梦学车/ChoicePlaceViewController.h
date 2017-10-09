//
//  ChoicePlaceViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/7/3.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "BasicViewController.h"

typedef void(^choicePlaceBlock)(NSString *place);

@interface ChoicePlaceViewController : BasicViewController

@property (nonatomic, copy) choicePlaceBlock chosedPlaceBlock;

- (void)returnPlaceBlock:(choicePlaceBlock)block;

@end
