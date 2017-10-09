//
//  PushNewsModel.h
//  好梦学车
//
//  Created by haomeng on 2017/9/4.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushNewsModel : NSObject

@property (nonatomic, strong) NSString *time;//推送时间

@property (nonatomic, strong) NSString *titleStr;//标题

@property (nonatomic, strong) NSString *describeStr;//描述

@property (nonatomic, strong) NSString *imageUrl;//图片地址

@property (nonatomic, strong) NSString *htmlUrl;//跳转的h5链接

@end
