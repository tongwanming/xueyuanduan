//
//  IPricePopView.h
//  好梦学车
//
//  Created by haomeng on 2017/6/28.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IPricePopView : UIView

- (instancetype)initWithPopViewWithName:(NSString *)name andPrice:(NSString *)price andExamPrice:(NSString *)examPrice andVC:(UIViewController *)vc;

+ (void)createPopviewWithName:(NSString *)name andPrice:(NSString *)price andExamPrice:(NSString *)examPrice andVC:(UIViewController *)vc;

+ (void)createPopviewWithName:(NSString *)name
                       title1:(NSString *)title1
                       title2:(NSString *)title2
                       title3:(NSString *)title3
                       descr1:(NSString *)descr1
                       descr2:(NSString *)descr2
                       descr3:(NSString *)descr3
                        andVC:(UIViewController *)vc;

+ (void)popClose;

@end
