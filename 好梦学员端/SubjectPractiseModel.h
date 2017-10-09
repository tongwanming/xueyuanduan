//
//  SubjectPractiseModel.h
//  好梦学车
//
//  Created by haomeng on 2017/5/15.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubjectPractiseModel : NSObject

@property (nonatomic, strong) NSString *questionID;//唯一标志符
@property (nonatomic ,strong) NSString *question;//问题描述
@property (nonatomic ,strong) NSString *answer1;//第一个答案选项
@property (nonatomic ,strong) NSString *answer2;//第二答案选项
@property (nonatomic ,strong) NSString *answer3;//第三个答案选项
@property (nonatomic ,strong) NSString *answer4;//第四个答案选项
@property (nonatomic ,strong) NSString *answer;//正确答案
@property (nonatomic ,strong) NSString *explain;//答案解析
@property (nonatomic ,strong) NSString *picUrl;//图片地址
@property (nonatomic ,strong) NSString *type;//题目类型
@property (nonatomic ,strong) NSString *chapter;//章节
@property (nonatomic, strong) NSString *course;//科目
@property (nonatomic, strong) NSString *difficlty;//难度系数
@property (nonatomic, strong) NSString *questionType;//题目类别


//此类型为全部题库、我的错题、收藏,在创建数据库时操作不同的数据库:normal;myMistake;collection
@property (nonatomic, strong) NSString *sqliteType;

@end
