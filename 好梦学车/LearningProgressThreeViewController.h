//
//  LearningProgressThreeViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/7/10.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "BasicViewController.h"

@protocol LearningProgressThreeViewControllerDelegate <NSObject>

- (void)LearningProgressThreeViewControllerActivieWithIndex:(NSString *)index;

@end

@interface LearningProgressThreeViewController : BasicViewController

@property (nonatomic, weak)id<LearningProgressThreeViewControllerDelegate>delegate;

@end
