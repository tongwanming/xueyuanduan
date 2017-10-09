//
//  OrderValidityManager.m
//  testDemo
//
//  Created by haomeng on 2017/7/25.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "OrderValidityManager.h"

#define ORDERTIMER 4320

@implementation OrderValidityManager

static OrderValidityManager *_manager;

+ (OrderValidityManager *)defaultManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_manager == nil) {
            _manager = [[OrderValidityManager alloc] init];
        }
    });
    return _manager;
}

- (void)initOrderValidity{
    
    NSMutableDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    if (dic) {
        NSDate *date = [NSDate date];
        [dic setObject:date forKey:@"date"];
        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"date"];
        
    }else{
        NSDate *date = [NSDate date];
        dic = [[NSMutableDictionary alloc] init];
        [dic setObject:date forKey:@"date"];
        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"date"];
    }
}

- (void)destroyOrderValidity{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"PersonIndentModelData"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"orderStyle"];
    NSMutableDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    if (dic) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"date"];
    }
}

- (BOOL)orderValidity{
    BOOL _order = NO;
    unsigned int unitFlags = NSCalendarUnitMinute;
    NSMutableDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    if (dic) {
        NSDate * formatterDate = [dic objectForKey:@"date"];
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *d = [cal components:unitFlags fromDate:formatterDate toDate:[NSDate date] options:0];
        if ([d minute] >= ORDERTIMER) {
            _order = NO;
            [self destroyOrderValidity];
        }else{
            _order = YES;
            NSLog(@"年：%ld,天：%ld,小时：%ld,分钟：%ld",(long)[d year],(long)[d day],(long)[d hour],(long)[d minute]);
        }
        
        
    }else{
        
    }
    
    return _order;
}

- (NSInteger)getOrderValidityTime{
    NSInteger _integer = 0;
    if ([self orderValidity]) {
        _integer = [self getOrderValidityTimePrivate];
    }else{
    
    }
    return _integer;
}

- (NSInteger)getOrderValidityTimePrivate{
    
    NSInteger _integer = 0;;
    unsigned int unitFlags = NSCalendarUnitMinute;
    NSMutableDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"date"];
    if (dic) {
        NSDate * formatterDate = [dic objectForKey:@"date"];
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDateComponents *d = [cal components:unitFlags fromDate:formatterDate toDate:[NSDate date] options:0];
        
        _integer = ORDERTIMER - [d minute];
        
    }else{
        
    }
    return _integer;
}

- (void)setModelWithData:(PersonIndentModel *)model{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"PersonIndentModelData"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"orderStyle"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    [self insertObject:model.name toDic:dic andKey:@"name"];
    [self insertObject:model.type toDic:dic andKey:@"type"];
    [self insertObject:model.price toDic:dic andKey:@"price"];
    [self insertObject:model.urlName toDic:dic andKey:@"urlName"];
    [self insertObject:model.bigTitle toDic:dic andKey:@"bigTitle"];
    [self insertObject:model.desribeStr toDic:dic andKey:@"desribeStr"];
    [self insertObject:model.createTimeStr toDic:dic andKey:@"createTimeStr"];
    [self insertObject:model.payTime toDic:dic andKey:@"payTime"];
    [self insertObject:model.indentNum toDic:dic andKey:@"indentNum"];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:model.data];
    NSString *dataStr = [arr componentsJoinedByString:@","];
    [self insertObject:dataStr toDic:dic andKey:@"data"];
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"PersonIndentModelData"];
    [[NSUserDefaults standardUserDefaults] setObject:model.bigTitle forKey:@"orderStyle"];

}

- (PersonIndentModel *)getPersonIndentModel{
    PersonIndentModel *model = [[PersonIndentModel alloc] init];
    NSMutableDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"PersonIndentModelData"];
    if (dic) {
        model.name = [dic objectForKey:@"name"];
        model.type = [dic objectForKey:@"type"];
        model.price = [dic objectForKey:@"price"];
        model.urlName = [dic objectForKey:@"urlName"];
        model.bigTitle = [dic objectForKey:@"bigTitle"];
        model.desribeStr = [dic objectForKey:@"desribeStr"];
        model.createTimeStr = [dic objectForKey:@"createTimeStr"];
        model.payTime = [dic objectForKey:@"payTime"];
        model.indentNum = [dic objectForKey:@"indentNum"];
        NSString *data = [dic objectForKey:@"data"];
        NSArray *arr = [data componentsSeparatedByString:@","];
        model.data = arr;
    }else{
        dic = [[NSMutableDictionary alloc] init];
    }
    
    return model;
}

- (void)removePersonIndentModelData{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"PersonIndentModelData"];
}

- (void)insertObject:(NSString *)str toDic:(NSMutableDictionary *)dic andKey:(NSString *)key{
    if (str) {
        [dic setObject:str forKey:key];
    }else{
        [dic setObject:@"" forKey:key];
    }
}

- (NSString *)getCurrentOrderStyle{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"orderStyle"];
    return str;
}

- (void)saveCurrentPlaceID:(NSString *)placeID{
    [[NSUserDefaults standardUserDefaults] setObject:placeID forKey:@"placeID"];
}

- (NSString *)getCurrentPlaceID{
    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"placeID"];
    if (str) {
        return str;
    }else
        return @"";
}

@end
