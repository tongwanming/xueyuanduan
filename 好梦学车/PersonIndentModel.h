//
//  PersonIndentModel.h
//  好梦学车
//
//  Created by haomeng on 2017/6/5.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonIndentModel : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSString *price;

@property (nonatomic, strong) NSString *urlName;

@property (nonatomic, strong) NSString *bigTitle;

@property (nonatomic, strong) NSString *desribeStr;

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, strong) NSString *createTimeStr;//创建订单时间

@property (nonatomic, strong) NSString *payTime;

@property (nonatomic, strong) NSString *indentNum;//订单号

@property (nonatomic, strong) NSString *indentStatus;//订单的状态 INIT("INIT", "待支付"),ACCEPTED("ACCEPTED", "已受理"),CANCELED("CANCELED", "已取消"),FINISH("FINISH", "已完成"),


@end
