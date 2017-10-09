//
//  URLConnectionHelper.h
//  好梦学车
//
//  Created by haomeng on 2017/6/2.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLConnectionModel.h"

@interface URLConnectionHelper : NSObject


+(URLConnectionHelper *)shareDefaulte;


- (void)getPostDataWithUrl:(NSString *)urlstr andConnectModel:(URLConnectionModel *)model andSuccessBlock:(void(^)(NSData *data))successedBlock andFailedBlock:(void(^)(NSError *error))failedBlock;

@end
