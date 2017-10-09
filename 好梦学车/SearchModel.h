//
//  SearchModel.h
//  好梦学员端
//
//  Created by haomeng on 2017/9/29.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Search/BMKPoiSearch.h>

@interface SearchModel : NSObject

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *address;

@property (nonatomic, assign)CLLocationCoordinate2D pt;

@end
