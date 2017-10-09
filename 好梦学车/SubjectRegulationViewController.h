//
//  SubjectRegulationViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/5/24.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,SubjextRegularType) {
    SubjextRegularTypeOne,
    SubjextRegularTypeTwo,
    SubjextRegularTypeThree,
    SubjextRegularTypeForth,
};


@interface SubjectRegulationViewController : UIViewController

@property (nonatomic, assign)SubjextRegularType type;

@end
