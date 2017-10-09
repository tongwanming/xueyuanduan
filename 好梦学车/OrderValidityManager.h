//
//  OrderValidityManager.h
//  testDemo
//
//  Created by haomeng on 2017/7/25.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersonIndentModel.h"

@interface OrderValidityManager : NSObject

+ (OrderValidityManager *)defaultManager;

//清空时效性的方法,清空不会建立新的实效性
- (void)destroyOrderValidity;

//清空以前的实效性，建立新的实效性
- (void)initOrderValidity;

//检测当前实效性
- (BOOL)orderValidity;

//获取当前的还剩余的时间
- (NSInteger)getOrderValidityTime;

//存储生成的订单信息
- (void)setModelWithData:(PersonIndentModel *)model;

//获取生成的订单信息
- (PersonIndentModel *)getPersonIndentModel;

//获取当前状态的方法
- (NSString *)getCurrentOrderStyle;

//记录当前的场地id

-(void)saveCurrentPlaceID:(NSString *)placeID;

-(NSString *)getCurrentPlaceID;

@end
