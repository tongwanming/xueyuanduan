//
//  SqliteDateManager.m
//  好梦学车
//
//  Created by haomeng on 2017/5/27.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SqliteDateManager.h"
#import "FMDatabase.h"
#import "SubjectPractiseModel.h"

@implementation SqliteDateManager{
    FMDatabase *_db;
}

+ (SqliteDateManager *)sharedManager{
    static SqliteDateManager *manager = nil;
    if (!manager) {
        manager = [[self alloc] initPrivate];
        
        [manager initDataBase];
    }
    return manager;
}

- (instancetype)initPrivate{
    if (self = [super init]) {
        
    }
    return self;
}

//初始化数据库表格
- (void)initDataBase{
    // 获得Documents目录路径
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 文件路径
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"model.sqlite"];
    
    // 实例化FMDataBase对象
    
    _db = [FMDatabase databaseWithPath:filePath];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"createSqliteTableView"]) {
        
    }else{
       
        
        [_db open];
        
        // 初始化数据表
        NSString *normalTab = @"create table normal(pID integer primary key autoincrement,questionId text unique,question text,course text,pic text,option1 text,option2 text,option3 text,option4 text,difficulty text,chapter text,answer text,explain text,type text,questionType text)";
        NSString *normalTabf = @"create table normalf(pID integer primary key autoincrement,questionId text unique,question text,course text,pic text,option1 text,option2 text,option3 text,option4 text,difficulty text,chapter text,answer text,explain text,type text,questionType text)";
        //科目一
        NSString *myMistake = @"create table myMistake(pID integer primary key autoincrement,questionId text unique,question text,course text,pic text,option1 text,option2 text,option3 text,option4 text,difficulty text,chapter text,answer text,explain text,type text,questionType text)";
        NSString *myCollection = @"create table myCollection(pID integer primary key autoincrement,questionId text unique,question text,course text,pic text,option1 text,option2 text,option3 text,option4 text,difficulty text,chapter text,answer text,explain text,type text,questionType text)";
        //科目四
        NSString *myMistakef = @"create table myMistakef(pID integer primary key autoincrement,questionId text unique,question text,course text,pic text,option1 text,option2 text,option3 text,option4 text,difficulty text,chapter text,answer text,explain text,type text,questionType text)";
        NSString *myCollectionf = @"create table myCollectionf(pID integer primary key autoincrement,questionId text unique,question text,course text,pic text,option1 text,option2 text,option3 text,option4 text,difficulty text,chapter text,answer text,explain text,type text,questionType text)";
        
        [_db executeUpdate:normalTab];
        [_db executeUpdate:normalTabf];
        [_db executeUpdate:myMistake];
        [_db executeUpdate:myCollection];
        [_db executeUpdate:myMistakef];
        [_db executeUpdate:myCollectionf];
        
        
        [_db close];
        [[NSUserDefaults standardUserDefaults] setObject:@"tableView" forKey:@"createSqliteTableView"];
    }

}

- (BOOL)selectSubjectPractiseModel:(SubjectPractiseModel *)model{
    [_db open];
    BOOL _hasData = NO;
    FMResultSet *res;
    if ([model.sqliteType isEqualToString:@"collection"]) {
        res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM myCollection where questionId = '%@'",model.questionID]];
    }else if ([model.sqliteType isEqualToString:@"collectionf"]){
        res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM myCollectionf where questionId = '%@'",model.questionID]];
    }else{
    
    }
    
    NSLog(@"%@",res);
    while ([res next]) {
        _hasData = YES;
//        NSLog(@"---:%@",[res stringForColumn:@"questionId"]);
    }
    
 
    [_db close];
    return _hasData;
}

- (void)addSubjectPractiseModel:(SubjectPractiseModel *)model{
    [_db open];
    NSNumber *maxID = @(0);
    FMResultSet *res;

    if ([model.sqliteType isEqualToString:@"normal"]) {
        res = [_db executeQuery:@"SELECT * FROM normal "];
        while ([res next]) {
            if ([maxID integerValue] < [res intForColumn:@"pID"]) {
                maxID = @([res intForColumn:@"pID"]) ;
            }
        }
        
        maxID = @([maxID integerValue] + 1);
        [_db executeUpdate:@"INSERT INTO normal(questionId,question,course,pic,option1,option2,option3,option4,difficulty,chapter,answer,explain,type,questionType)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)",model.questionID,model.question,model.course,model.picUrl,model.answer1,model.answer2,model.answer3,model.answer4,model.difficlty,model.chapter,model.answer,model.explain,model.type,model.questionType];
        
    }else if ([model.sqliteType isEqualToString:@"normalf"]){
        res = [_db executeQuery:@"SELECT * FROM normalf "];
        while ([res next]) {
            if ([maxID integerValue] < [res intForColumn:@"pID"]) {
                maxID = @([res intForColumn:@"pID"]) ;
            }
        }
        
        maxID = @([maxID integerValue] + 1);
        [_db executeUpdate:@"INSERT INTO normalf(questionId,question,course,pic,option1,option2,option3,option4,difficulty,chapter,answer,explain,type,questionType)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)",model.questionID,model.question,model.course,model.picUrl,model.answer1,model.answer2,model.answer3,model.answer4,model.difficlty,model.chapter,model.answer,model.explain,model.type,model.questionType];
    
    }else if ([model.sqliteType isEqualToString:@"myMistake"]){
        res = [_db executeQuery:@"SELECT * FROM myMistake "];
        
        while ([res next]) {
            if ([maxID integerValue] < [res intForColumn:@"pID"]) {
                maxID = @([res intForColumn:@"pID"]) ;
            }
        }
        
        maxID = @([maxID integerValue] + 1);
        [_db executeUpdate:@"INSERT INTO myMistake(questionId,question,course,pic,option1,option2,option3,option4,difficulty,chapter,answer,explain,type,questionType)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)",model.questionID,model.question,model.course,model.picUrl,model.answer1,model.answer2,model.answer3,model.answer4,model.difficlty,model.chapter,model.answer,model.explain,model.type,model.questionType];
    }else if ([model.sqliteType isEqualToString:@"collection"]){
        res = [_db executeQuery:@"SELECT * FROM myCollection "];
        
        while ([res next]) {
            if ([maxID integerValue] < [res intForColumn:@"pID"]) {
                maxID = @([res intForColumn:@"pID"]) ;
            }
        }
        
        maxID = @([maxID integerValue] + 1);
        [_db executeUpdate:@"INSERT INTO myCollection(questionId,question,course,pic,option1,option2,option3,option4,difficulty,chapter,answer,explain,type,questionType)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)",model.questionID,model.question,model.course,model.picUrl,model.answer1,model.answer2,model.answer3,model.answer4,model.difficlty,model.chapter,model.answer,model.explain,model.type,model.questionType];
    }else if ([model.sqliteType isEqualToString:@"myMistakef"]){
        res = [_db executeQuery:@"SELECT * FROM myMistakef "];
        
        while ([res next]) {
            if ([maxID integerValue] < [res intForColumn:@"pID"]) {
                maxID = @([res intForColumn:@"pID"]) ;
            }
        }
        
        maxID = @([maxID integerValue] + 1);
        [_db executeUpdate:@"INSERT INTO myMistakef(questionId,question,course,pic,option1,option2,option3,option4,difficulty,chapter,answer,explain,type,questionType)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)",model.questionID,model.question,model.course,model.picUrl,model.answer1,model.answer2,model.answer3,model.answer4,model.difficlty,model.chapter,model.answer,model.explain,model.type,model.questionType];
    }else if ([model.sqliteType isEqualToString:@"collectionf"]){
        res = [_db executeQuery:@"SELECT * FROM myCollectionf "];
        
        while ([res next]) {
            if ([maxID integerValue] < [res intForColumn:@"pID"]) {
                maxID = @([res intForColumn:@"pID"]) ;
            }
        }
        
        maxID = @([maxID integerValue] + 1);
        [_db executeUpdate:@"INSERT INTO myCollectionf(questionId,question,course,pic,option1,option2,option3,option4,difficulty,chapter,answer,explain,type,questionType)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)",model.questionID,model.question,model.course,model.picUrl,model.answer1,model.answer2,model.answer3,model.answer4,model.difficlty,model.chapter,model.answer,model.explain,model.type,model.questionType];
    }else{
        res = [_db executeQuery:@"SELECT * FROM normal "];
        
        while ([res next]) {
            if ([maxID integerValue] < [res intForColumn:@"pID"]) {
                maxID = @([res intForColumn:@"pID"]) ;
            }
        }
        
        maxID = @([maxID integerValue] + 1);
        [_db executeUpdate:@"INSERT INTO normal(questionId,question,course,pic,option1,option2,option3,option4,difficulty,chapter,answer,explain,type,questionType)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)",model.questionID,model.question,model.course,model.picUrl,model.answer1,model.answer2,model.answer3,model.answer4,model.difficlty,model.chapter,model.answer,model.explain,model.type,model.questionType];
    }
    
    [_db close];
}

- (void)deleteSubjectPractiseWithSqlieType:(NSString *)type{
    [_db open];
    if ([type isEqualToString:@"normal"]) {
        [_db executeUpdate:@"DELETE FROM normal"];
    }else if ([type isEqualToString:@"normalf"]){
        [_db executeUpdate:@"DELETE FROM normalf"];
    }
    else if ([type isEqualToString:@"myMistake"]){
        [_db executeUpdate:@"DELETE FROM myMistake"];
    }else if ([type isEqualToString:@"collection"]){
        [_db executeUpdate:[NSString stringWithFormat:@"DELETE FROM myCollection"]];
    }else if ([type isEqualToString:@"myMistakef"]){
        [_db executeUpdate:@"DELETE FROM myMistakef"];
    }else if ([type isEqualToString:@"collectionf"]){
        [_db executeUpdate:@"DELETE FROM myCollectionf"];
    }else{
        [_db executeUpdate:@"DELETE FROM normal"];
    }
    [_db close];
}

- (void)deleteSubjectPractiseModel:(SubjectPractiseModel *)model{
    [_db open];
    if ([model.sqliteType isEqualToString:@"normal"]) {
        [_db executeUpdate:@"DELETE FROM normal WHERE questionId = ?",model.questionID];
    }else if ([model.sqliteType isEqualToString:@"normalf"]){
        [_db executeUpdate:@"DELETE FROM normalf WHERE questionId = ?",model.questionID];
    }
    else if ([model.sqliteType isEqualToString:@"myMistake"]){
        [_db executeUpdate:@"DELETE FROM myMistake WHERE questionId = ?",model.questionID];
    }else if ([model.sqliteType isEqualToString:@"collection"]){
        [_db executeUpdate:[NSString stringWithFormat:@"DELETE FROM myCollection WHERE questionId = '%@'",model.questionID]];
    }else if ([model.sqliteType isEqualToString:@"myMistakef"]){
        [_db executeUpdate:@"DELETE FROM myMistakef WHERE questionId = ?",model.questionID];
    }else if ([model.sqliteType isEqualToString:@"collectionf"]){
        [_db executeUpdate:@"DELETE FROM myCollectionf WHERE questionId = ?",model.questionID];
    }else{
        [_db executeUpdate:@"DELETE FROM normal WHERE questionId = ?",model.questionID];
    }
    [_db close];
}

- (NSMutableArray *)getAllDataWithType:(NSString *)type{
    [_db open];
    FMResultSet *res;
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    if ([type isEqualToString:@"normal"]) {
        res = [_db executeQuery:@"SELECT * FROM normal"];
    }else if ([type isEqualToString:@"normalf"]){
        res = [_db executeQuery:@"SELECT * FROM normal"];
    }else if ([type isEqualToString:@"myMistake"]){
        res = [_db executeQuery:@"SELECT * FROM myMistake"];
    }else if ([type isEqualToString:@"collection"]){
        res = [_db executeQuery:@"SELECT * FROM myCollection"];
    }else if ([type isEqualToString:@"myMistakef"]){
        res = [_db executeQuery:@"SELECT * FROM myMistakef"];
    }else if ([type isEqualToString:@"collectionf"]){
        res = [_db executeQuery:@"SELECT * FROM myCollectionf"];
    }else{
        res = [_db executeQuery:@"SELECT * FROM normal"];
    }
    
    while ([res next]) {
        SubjectPractiseModel *model = [[SubjectPractiseModel alloc] init];
        model.questionID = [res stringForColumn:@"questionId"];
        model.question = [res stringForColumn:@"question"];
        model.course = [res stringForColumn:@"course"];
        model.picUrl = [res stringForColumn:@"pic"];
        model.answer1 = [res stringForColumn:@"option1"];
        model.answer2 = [res stringForColumn:@"option2"];
        model.answer3 = [res stringForColumn:@"option3"];
        model.answer4 = [res stringForColumn:@"option4"];
        model.difficlty = [res stringForColumn:@"difficulty"];
        model.chapter = [res stringForColumn:@"chapter"];
        model.answer = [res stringForColumn:@"answer"];
        model.explain = [res stringForColumn:@"explain"];
        model.type = [res stringForColumn:@"type"];
        model.questionType = [res stringForColumn:@"questionType"];
        [dataArray addObject:model];
        
    }
    [_db close];
    return dataArray;
}

- (NSMutableArray *)getMistakeDataWithType:(NSString *)type andSubType:(NSString *)subType{
    [_db open];
    FMResultSet *res;
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    if ([type isEqualToString:@"normal"]) {
        res = [_db executeQuery:@"SELECT * FROM normal WHERE chapter = ? ",subType];
    }else if ([type isEqualToString:@"normalf"]){
        res = [_db executeQuery:@"SELECT * FROM normalf WHERE chapter = ? ",subType];
    }else if ([type isEqualToString:@"myMistake"]){
        res = [_db executeQuery:@"SELECT * FROM myMistake WHERE chapter = ? ",subType];
    }else if ([type isEqualToString:@"collection"]){
        res = [_db executeQuery:@"SELECT * FROM collection WHERE chapter = ? ",subType];
    }else if ([type isEqualToString:@"myMistakef"]){
        res = [_db executeQuery:@"SELECT * FROM myMistakef WHERE chapter = ? ",subType];
    }else if ([type isEqualToString:@"collectionf"]){
        res = [_db executeQuery:@"SELECT * FROM myCollectionf WHERE chapter = ? ",subType];
    }else{
        res = [_db executeQuery:@"SELECT * FROM normal WHERE chapter = ? ",subType];
    }
    
    while ([res next]) {
        SubjectPractiseModel *model = [[SubjectPractiseModel alloc] init];
        model.questionID = [res stringForColumn:@"questionId"];
        model.question = [res stringForColumn:@"question"];
        model.course = [res stringForColumn:@"course"];
        model.picUrl = [res stringForColumn:@"pic"];
        model.answer1 = [res stringForColumn:@"option1"];
        model.answer2 = [res stringForColumn:@"option2"];
        model.answer3 = [res stringForColumn:@"option3"];
        model.answer4 = [res stringForColumn:@"option4"];
        model.difficlty = [res stringForColumn:@"difficulty"];
        model.chapter = [res stringForColumn:@"chapter"];
        model.answer = [res stringForColumn:@"answer"];
        model.explain = [res stringForColumn:@"explain"];
        model.type = [res stringForColumn:@"type"];
        model.questionType = [res stringForColumn:@"questionType"];
        [dataArray addObject:model];
        
    }
    [_db close];
    return dataArray;
}

- (SubjectPractiseModel *)getDataWithType:(NSString *)type andID:(NSString *)questionID{
    [_db open];
    FMResultSet *res;

    if ([type isEqualToString:@"normal"]) {
        res = [_db executeQuery:@"SELECT * FROM normal WHERE questionId = ?",questionID];
    }else if ([type isEqualToString:@"normalf"]){
        res = [_db executeQuery:@"SELECT * FROM normalf WHERE questionId = ?",questionID];

    }
    else if ([type isEqualToString:@"myMistake"]){
        res = [_db executeQuery:@"SELECT * FROM myMistake WHERE questionId = ?",questionID];
    }else if ([type isEqualToString:@"collection"]){
        res = [_db executeQuery:@"SELECT * FROM myCollection WHERE questionId = ?",questionID];
    }else if ([type isEqualToString:@"myMistakef"]){
        res = [_db executeQuery:@"SELECT * FROM myMistakef WHERE questionId = ?",questionID];
    }else if ([type isEqualToString:@"collectionf"]){
        res = [_db executeQuery:@"SELECT * FROM myCollectionf WHERE questionId = ?",questionID];
    }else{
        res = [_db executeQuery:@"SELECT * FROM normal WHERE questionId = ?",questionID];
    }
    SubjectPractiseModel *model = [[SubjectPractiseModel alloc] init];
    while ([res next]) {
        
        model.questionID = [res stringForColumn:@"questionId"];
        model.question = [res stringForColumn:@"question"];
        model.course = [res stringForColumn:@"course"];
        model.picUrl = [res stringForColumn:@"pic"];
        model.answer1 = [res stringForColumn:@"option1"];
        model.answer2 = [res stringForColumn:@"option2"];
        model.answer3 = [res stringForColumn:@"option3"];
        model.answer4 = [res stringForColumn:@"option4"];
        model.difficlty = [res stringForColumn:@"difficulty"];
        model.chapter = [res stringForColumn:@"chapter"];
        model.answer = [res stringForColumn:@"answer"];
        model.explain = [res stringForColumn:@"explain"];
        model.type = [res stringForColumn:@"type"];
        model.questionType = [res stringForColumn:@"questionType"];
        NSLog(@"去取的的questionType：%@",[res stringForColumn:@"questionType"]);
        
    }
    [_db close];
    return model;
}

@end
