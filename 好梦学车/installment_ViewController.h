//
//  installment ViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/8/29.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "BasicViewController.h"
#import "PersonIndentModel.h"

@interface installment_ViewController : BasicViewController

@property (nonatomic, strong) PersonIndentModel *model;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *contentBtn;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet UIView *bottonSubView;
@property (nonatomic, strong) NSString *payNum;

@end
