//
//  SubjectForthViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/5/11.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "BasicAlertViewController.h"

@protocol SubjectForthViewControllerDelegate <NSObject>

- (void)subjectForthViewControllerTapWithIndex:(NSString *)index;

@end

@interface SubjectForthViewController : UIViewController

@property (nonatomic, weak)id<SubjectForthViewControllerDelegate>delegate;

@end
