//
//  URLConnectionHelper.m
//  好梦学车
//
//  Created by haomeng on 2017/6/2.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "URLConnectionHelper.h"

@implementation URLConnectionHelper

+ (URLConnectionHelper *)shareDefaulte{
    static URLConnectionHelper *sharedDefaulte;
    if (!sharedDefaulte) {
        sharedDefaulte = [[URLConnectionHelper alloc] init];
    }
    return sharedDefaulte;
}

- (void)getPostDataWithUrl:(NSString *)urlstr andConnectModel:(URLConnectionModel *)model andSuccessBlock:(void (^)(NSData *))successedBlock andFailedBlock:(void (^)(NSError *))failedBlock{
    NSDictionary *dic = @{
                          @"isRand":model.isRand,
                          @"serviceName": model.serviceName,
                          @"course": model.course,
                          @"Take": @0,
                          @"Skip": @0,
                          @"PageId": @0,
                          @"header": @{
                                  @"SSOST":@"",
                                  @"cmd": @"",
                                  @"deviceId": @"a35d5fd0-bc80-3c2c-90f9-131a6b0191fb",
                                  @"deviceName": @"vivo X3L",
                                  @"osName": @"Android",
                                  @"osVersion": @"4.3",
                                  @"source": @"3",
                                  @"versionCode": @"22"
                                  },
                          @"uncheck": @"sign"
                          };
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    if (model.type) {
        [mutDic setObject:model.type forKey:@"type"];
    }
    NSDictionary *newDic = [NSDictionary dictionaryWithDictionary:mutDic];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    [data setObject:newDic forKey:@"data"];
    
//    [data setObject:@"sign" forKey:@"uncheck"];
    
    NSData *data1 = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    
//    NSURL *url = [NSURL URLWithString:urlstr];
     NSURL *url = [NSURL URLWithString:@"http://101.37.29.125:8088/openApi/app/gateway.htm"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    [request setHTTPBody:jsonData];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            successedBlock(data);
        }else{
            failedBlock(error);
        }
    }];
    [dataTask resume];
}

@end
