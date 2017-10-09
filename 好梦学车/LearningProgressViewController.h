//
//  LearningProgressViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/7/10.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "BasicViewController.h"

@protocol LearningProgressViewControllerDelegate <NSObject>

- (void)LearningProgressViewControllerActiveWithIndex:(NSString *)index;

@end

@interface LearningProgressViewController : BasicViewController

@property (nonatomic, weak)id<LearningProgressViewControllerDelegate>delegate;

@property (nonatomic, strong) NSArray *data;

@end
