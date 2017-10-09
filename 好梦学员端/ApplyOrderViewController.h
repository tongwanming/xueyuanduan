//
//  ApplyOrderViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/4/24.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "BasicViewController.h"
#import "FirstCatStyleModel.h"

@interface ApplyOrderViewController : BasicViewController
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@property (weak, nonatomic) IBOutlet UILabel *actuallyPaidLabel;
@property (weak, nonatomic) IBOutlet UILabel *practicalpriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;

@property (nonatomic, strong) NSString *userName;

@property (nonatomic, strong) NSString *appleType;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *coach;

@property (nonatomic, strong) NSString *billNews;
@property (nonatomic, strong) NSString *cost;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;

@property (nonatomic, strong) FirstCatStyleModel *model;

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, strong) NSArray *locationData;//场地数据信息


@end
