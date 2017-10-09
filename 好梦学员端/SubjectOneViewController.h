//
//  SubjectOneViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/5/11.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "BasicAlertViewController.h"

@protocol SubjectOneViewControllerDelegate <NSObject>

- (void)subjectOneViewControllerTapWithIndex:(NSString *)index;

@end

@interface SubjectOneViewController : UIViewController

@property (nonatomic, weak) id<SubjectOneViewControllerDelegate>delegate;

@end
