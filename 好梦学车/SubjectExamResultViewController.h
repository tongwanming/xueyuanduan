//
//  SubjectExamResultViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/5/13.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubjectOneExamViewController.h"

@interface SubjectExamResultViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *progressImagevIew;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *gardLabel;
@property (weak, nonatomic) IBOutlet UILabel *showGardLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalItemsLabel;
@property (weak, nonatomic) IBOutlet UILabel *finishedLabel;
@property (weak, nonatomic) IBOutlet UILabel *mistakeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@property (nonatomic, strong) NSMutableArray *trueData;

@property (nonatomic, strong) NSMutableArray *errorData;

@property (nonatomic, assign) int timeStr;

@property (nonatomic, assign) ExamViewControllerType examType;

@end
