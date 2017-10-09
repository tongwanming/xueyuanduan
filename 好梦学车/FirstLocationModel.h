//
//  FirstLocationModel.h
//  好梦学车
//
//  Created by haomeng on 2017/5/3.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FirstLocationModel : NSObject



@property (nonatomic, strong) NSString *LocationName;//场地名称

@property (nonatomic, strong) NSString *backGroundImageName;//预留部分


//上面部分为测试部分
@property (nonatomic, strong) NSString *currentId;//id

@property (nonatomic, strong) NSString *descrip;//描述

@property (nonatomic, strong) NSString *trainDrivingLicense;

@property (nonatomic, strong) NSString *contactPersonPhone;

@property (nonatomic, strong) NSString *trainSubjects;

@property (nonatomic, strong) NSString *contactPersonName;

@property (nonatomic, strong) NSString *province;

@property (nonatomic, strong) NSString *longitude;

@property (nonatomic, strong) NSString *latitude;

@property (nonatomic, strong) NSString *pictures;

@property (nonatomic, strong) NSString *belongSchool;

@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSString *city;

@property (nonatomic, strong) NSString *addTime;

@property (nonatomic, strong) NSString *district;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *distance;//距离

@property (nonatomic, strong) NSString *updateTime;


@end
