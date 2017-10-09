//
//  LearningGraduateViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/7/10.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "BasicViewController.h"

@protocol LearningGraduateViewControllerDelegate <NSObject>

- (void)LearningGraduateViewControllerActiveWithIndex:(NSString *)index;

@end

@interface LearningGraduateViewController : BasicViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, weak)id<LearningGraduateViewControllerDelegate>delegate;

@end
