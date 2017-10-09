//
//  URLConnectionModel.h
//  好梦学车
//
//  Created by haomeng on 2017/6/2.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <Foundation/Foundation.h>

//    PageId		number	@mock=4
//    Platform		string	@mock=app
//    Skip		number	@mock=0
//    Take		number	@mock=10
//    chapter	考题所属章节	string	非必填（例如 1 2 ...）
//    course	考题所属科目	string	必填（1,4）
//isRand	是否随机查询题目	string	非必填 （Y ）
//    questionId	考题ID（唯一标识）	string	非必填
//    serviceName	接口服务名称	string	必填（例如：hm.question.bank.list.query）
//    type	考题类型	string	非必填
//    isRand  是否是随机，是随机就是Y

@interface URLConnectionModel : NSObject

@property (nonatomic, strong) NSString *serviceName;

@property (nonatomic, strong) NSString *course;

@property (nonatomic, strong) NSString *chapter;

@property (nonatomic, strong) NSString *isRand;

@property (nonatomic, strong) NSString *type;

@end
