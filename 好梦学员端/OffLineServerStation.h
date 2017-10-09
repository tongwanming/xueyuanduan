//
//  OffLineServerStation.h
//  好梦学车
//
//  Created by haomeng on 2017/6/22.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OffLineServerStation : NSObject

@property (nonatomic, strong) NSString *address;

@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *district;
@property (nonatomic, strong) NSString *offLineServerId;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *province;

@end
