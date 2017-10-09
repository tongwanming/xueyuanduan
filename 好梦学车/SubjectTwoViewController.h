//
//  SubjectTwoViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/5/11.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "BasicAlertViewController.h"

@protocol SubjectTwoViewControllerDelegate <NSObject>

- (void)subjectTwoViewControllerDelegateTapWithIndex:(NSString *)index;

@end

@interface SubjectTwoViewController : UIViewController

@property (nonatomic, weak)id<SubjectTwoViewControllerDelegate>delegete;

@end
