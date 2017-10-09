//
//  LearningProgressOneViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/7/10.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "BasicViewController.h"

@protocol LearningProgressOneViewControllerDelegate <NSObject>

- (void)LearningProgressOneViewControllerActiveWitnIndex:(NSString *)index;

@end

@interface LearningProgressOneViewController : BasicViewController

@property (nonatomic, weak)id<LearningProgressOneViewControllerDelegate>delegate;

@end
