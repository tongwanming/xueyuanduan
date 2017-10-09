//
//  SubjectOneSpecialProjectViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/5/12.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectOneBasicViewController.h"

@interface SubjectOneSpecialProjectViewController : SubjectOneBasicViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSString *type;

@end
