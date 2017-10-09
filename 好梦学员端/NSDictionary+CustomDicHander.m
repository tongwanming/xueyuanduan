//
//  NSDictionary+CustomDicHander.m
//  好梦学车
//
//  Created by haomeng on 2017/7/4.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "NSDictionary+CustomDicHander.h"

@implementation NSDictionary (CustomDicHander)

- (NSObject *)objectForSubKey:(NSString *)key{
    NSString *str = @"";
    if ([self objectForKey:key]) {
        return [self objectForKey:key];
    }else
        return str;
}

@end
