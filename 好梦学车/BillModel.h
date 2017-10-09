//
//  BillModel.h
//  好梦学车
//
//  Created by haomeng on 2017/8/31.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BillModel : NSObject

@property (nonatomic, strong) NSString *allPrice;//总的价格

@property (nonatomic, strong) NSString *price1;//第一次价格

@property (nonatomic, strong) NSString *price2;//第二次价格

@property (nonatomic, strong) NSString *price3;//第三次价格

@property (nonatomic, strong) NSString *firstTime;//首次订单完成时间

@property (nonatomic, strong) NSString *secondTime;//第二次订单完成时间

@property (nonatomic, strong) NSString *thirdTime;//第三次订单完成时间

@property (nonatomic, strong) NSString *payNum;//订单号

@property (nonatomic, assign) int instalmentsNum;//当前所在其数

@property (nonatomic, strong) NSString *handingChnage;//手续费

@property (nonatomic, strong) NSString *currentPay;//当前需要支付的钱

@end
