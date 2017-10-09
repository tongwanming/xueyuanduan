//
//  SubjectSingleAnalyzeViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/5/26.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectOneBasicViewController.h"
#import "SubjectSingleAnalyzeViewModel.h"

typedef NS_ENUM(NSInteger,SubjectSingleAnalyzeViewType) {
    SubjectSingleAnalyzeViewTypeTwo,
    SubjectSingleAnalyzeViewTypeThree,
};

@interface SubjectSingleAnalyzeViewController : SubjectOneBasicViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, assign) SubjectSingleAnalyzeViewType type;

@end
