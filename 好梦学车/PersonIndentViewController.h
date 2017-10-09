//
//  PersonIndentViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/6/5.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "BasicViewController.h"
#import "PersonIndentModel.h"
#import "OrderValidityManager.h"

@interface PersonIndentViewController : BasicViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) PersonIndentModel *model;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *contentBtn;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
