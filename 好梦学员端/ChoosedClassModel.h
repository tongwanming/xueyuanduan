//
//  ChoosedClassModel.h
//  好梦学车
//
//  Created by haomeng on 2017/6/28.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChoosedClassModel : NSObject

@property (nonatomic, strong) NSString *imageStr;

@property (nonatomic, strong) NSString *titleStr;

@property (nonatomic, strong) NSString *priceStr;

@property (nonatomic, strong) NSString *descStr;

@property (nonatomic, strong) NSString *C1Str;

@property (nonatomic, strong) NSString *C2Str;

@property (nonatomic, strong) NSString *projectTypeName;

@property (nonatomic, strong) NSString *isInstalmentsC1;

@property (nonatomic, strong) NSString *isInstalmentsC2;

@property (nonatomic, strong) NSString *categoryCode;//版型代号

@property (nonatomic, strong) NSString *projectTypeCode;//C1,C2代号
@end
