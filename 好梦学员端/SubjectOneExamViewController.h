//
//  SubjectOneExamViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/5/12.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectOneBasicViewController.h"

typedef NS_ENUM(NSInteger,ExamViewControllerType) {
    ExamViewControllerTypeOne,
    ExamViewControllerTypeTwo,
};

@interface SubjectOneExamViewController : SubjectOneBasicViewController
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *subView;
@property (weak, nonatomic) IBOutlet UILabel *tureLabel;
@property (weak, nonatomic) IBOutlet UILabel *defaultLabel;
@property (weak, nonatomic) IBOutlet UILabel *finishedLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;

@property (nonatomic, assign) ExamViewControllerType examType;

@end
