//
//  SubjectRecordAndRankViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/5/14.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubjectExamResultModel.h"

@protocol SubjectRecordAndRankViewControllerDelegate <NSObject>

- (void)subjectRecordAndRankViewControllerTap:(UIButton *)btn;

- (void)subjectRecordAndRankViewControllerWithIndex:(NSIndexPath *)index;

@end

@interface SubjectRecordAndRankViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalTimesLabel;
@property (weak, nonatomic) IBOutlet UILabel *passTimesLabel;
@property (weak, nonatomic) IBOutlet UILabel *exerciseTimesLabel;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, weak) id<SubjectRecordAndRankViewControllerDelegate>delegate;

@property (nonatomic, strong) NSMutableArray *tureData;

@property (nonatomic, strong) NSMutableArray *errorData;

@property (nonatomic, strong) NSString *course;

@property (nonatomic, strong) NSMutableArray *allData;

@property (nonatomic, strong) NSString *topGoal;

@property (nonatomic, strong) NSString *passTime;

@property (nonatomic, strong) NSString *totalExercise;

@property (nonatomic, strong) NSString *meanExercise;

@end
