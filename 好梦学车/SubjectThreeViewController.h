//
//  SubjectThreeViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/5/11.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "BasicAlertViewController.h"

@protocol SubjectThreeViewControllerDelegate <NSObject>

- (void)SubjectThreeViewControllerDelegateTapWithIndex:(NSString *)index;

@end

@interface SubjectThreeViewController : UIViewController

@property (nonatomic, weak) id<SubjectThreeViewControllerDelegate>delegate;

@end
