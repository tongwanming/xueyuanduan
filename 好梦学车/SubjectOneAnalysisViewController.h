//
//  SubjectOneAnalysisViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/5/12.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectOneBasicViewController.h"

@interface SubjectOneAnalysisViewController : SubjectOneBasicViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (weak, nonatomic) IBOutlet UILabel *describeLabel;

@property (nonatomic, strong) NSMutableArray *errorData;

@property (nonatomic, strong) NSString *gardStr;

@property (nonatomic, strong) NSMutableArray *allData;

@end
