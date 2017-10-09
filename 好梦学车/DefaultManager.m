//
//  DefaultManager.m
//  好梦学车
//
//  Created by haomeng on 2017/7/5.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "DefaultManager.h"

@implementation DefaultManager

+ (DefaultManager *)shareDefaultManager{
    static DefaultManager *manager = nil;
    @synchronized (self) {
        if (!manager) {
            manager = [[self alloc] init];
        }
    }
    return manager;
}

- (void)setLocationData:(NSArray *)locationData{
    _locationData = locationData;
}

- (void)setCarStyleData:(NSArray *)carStyleData{
    _carStyleData = carStyleData;
}

@end
