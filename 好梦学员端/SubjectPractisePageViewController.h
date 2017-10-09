//
//  SubjectPractisePageViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/5/15.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubjectPractiseModel.h"
#import "SubjectPractiseViewController.h"

@protocol SubjectPractisePagDeleaget <NSObject>

- (void)SubjectPractisePagViewSelectWithAnswer:(NSString *)answer andIndex:(NSString *)index;

- (void)showBtnState:(NSString *)state;

@end

@interface SubjectPractisePageViewController : UIViewController

@property (nonatomic, strong) SubjectPractiseModel *model;

@property (nonatomic, weak) id<SubjectPractisePagDeleaget>delegate;

@property (nonatomic, strong) NSString  *index;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, assign) PractiseViewControllerType practiseType;

@end
