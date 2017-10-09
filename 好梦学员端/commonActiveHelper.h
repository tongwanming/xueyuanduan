//
//  commonActiveHelper.h
//  safetyProduction
//
//  Created by tongwanming on 16/5/4.
//  Copyright © 2016年 tidalicHifi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^BtnClickActive)(NSInteger);

typedef void(^logiBtnClickActive)(NSInteger);

typedef void(^NormalBtnClickActive)(void);

@interface commonActiveHelper : NSObject

@property (nonatomic, strong) BtnClickActive btnClick;

@property (nonatomic,strong) logiBtnClickActive logoBtnClickActive;

@property (nonatomic, strong) NormalBtnClickActive normalBtnClick;

@property (nonatomic, assign) NSInteger tag;

+ (commonActiveHelper *)shareDefault;

+ (UIButton *)createBtnWithName:(NSString *)name andImage:(UIImage *)image andFrane:(CGRect *)frame andTag:(NSInteger)tag;

+ (UIButton *)createBtnWithTitle:(NSString *)title andTag:(NSInteger)tag andActive:(void(^)(NSInteger integer))completed;

+ (UIControl *)createControlWithImage:(UIImage *)image andTitle:(NSString *)title andWidth:(CGFloat)width andTag:(NSInteger)tag andClickBlock:(void(^)(NSInteger integer))completed;

+ (UIControl *)createControlWithlogoImage:(UIImage *)image andTitle:(NSString *)title andSubTitle:(NSString *)subTitle andTag:(NSInteger)tag andBtnClickBlock:(void(^)(NSInteger integer))completed;

+ (UIButton *)createBtnWithColor:(UIColor *)color andRadius:(CGFloat)radius andTitle:(NSString *)title andCompleteBlook:(void(^)(void))completed;

@end
