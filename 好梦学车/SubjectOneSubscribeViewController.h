//
//  SubjectOneSubscribeViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/5/12.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectOneBasicViewController.h"

typedef NS_ENUM(NSInteger,SubjectOneSubscribeType) {
    SubjectOneSubscribeTypeOne,
    SubjectOneSubscribeTypeTwo,
    SubjectOneSubscribeTypeThree,
    SubjectOneSubscribeTypeForth,
};

@interface SubjectOneSubscribeViewController : SubjectOneBasicViewController

@property (nonatomic, assign) SubjectOneSubscribeType type;

@end
