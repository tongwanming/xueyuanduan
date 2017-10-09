//
//  SettingPersonNewsModel.h
//  好梦学车
//
//  Created by haomeng on 2017/6/6.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingPersonNewsModel : NSObject

@property (nonatomic, strong) NSString *timeStr;

@property (nonatomic, strong) NSString *titleStr;

@property (nonatomic, strong) NSString *describeStr;

@property (nonatomic, strong) NSString *imageUrl;

@property (nonatomic, strong) NSString *htmlUrl;

@property (nonatomic, strong) NSString *coachId;

@property (nonatomic, strong) NSString *recordId;

@property (nonatomic, assign) int newsId;//此处为了表示消息id

@property (nonatomic, strong) NSString *newsState;//表示消息有没有读，未读为0，已读为1；

@end
