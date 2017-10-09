//
//  DefaultManager.h
//  好梦学车
//
//  Created by haomeng on 2017/7/5.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DefaultManager : NSObject

@property (nonatomic, strong) NSArray *locationData;

@property (nonatomic, strong) NSArray *carStyleData;

+ (DefaultManager *)shareDefaultManager;

@end
