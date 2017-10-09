//
//  LearningProgressTwoViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/7/10.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "BasicViewController.h"

@protocol LearningProgressTwoViewControllerDelegate <NSObject>

- (void)LearningProgressTwoViewControllerActiveWithIndex:(NSString *)index;

@end

@interface LearningProgressTwoViewController : BasicViewController

@property (nonatomic, weak)id<LearningProgressTwoViewControllerDelegate>delegate;

@end
