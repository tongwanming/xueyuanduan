//
//  SqliteDateManager.h
//  好梦学车
//
//  Created by haomeng on 2017/5/27.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SubjectPractiseModel;

@interface SqliteDateManager : NSObject

+ (SqliteDateManager *)sharedManager;

#pragma mark - SqliteDateManager
//插入数据
- (void)addSubjectPractiseModel:(SubjectPractiseModel *)model;

//删除数据
- (void)deleteSubjectPractiseModel:(SubjectPractiseModel *)model;

//查询数据
- (BOOL)selectSubjectPractiseModel:(SubjectPractiseModel *)model;

//获取数据

- (NSMutableArray *)getAllDataWithType:(NSString *)type;

//获取某一数据

- (NSMutableArray *)getMistakeDataWithType:(NSString *)type andSubType:(NSString *)subType;

//删除指定的sqliteType的数据库

- (void)deleteSubjectPractiseWithSqlieType:(NSString *)type;

//获取指定id 的数据

- (SubjectPractiseModel *)getDataWithType:(NSString *)type andID:(NSString *)questionID;

@end
