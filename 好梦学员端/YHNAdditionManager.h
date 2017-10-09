//
//  FDLMAdditionManager.h
//  FDLM
//
//  Created by weitong on 16/1/12.
//  Copyright © 2016年 WangtianSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define kAlipay_Scheme @"wxf5f3953299feaaa1"

#define kWeChatAppID 359209162@qq.com

@protocol YHNAdditionManagerDelegate;

@interface YHNAdditionManager : NSObject

@property(nonatomic,weak) id<YHNAdditionManagerDelegate>        delegate;

+ (YHNAdditionManager *)sharedManager;
- (BOOL)handleOpenURL:(NSURL *)url;

- (void)setup:(NSDictionary *)launchOptions;

//  微信支付
- (BOOL)sendWeiXinPayRequestWithString:(NSDictionary*)str withDelegate:(id<YHNAdditionManagerDelegate>)delegate;
//  支付宝支付
- (void)sendAliPayRequestWithString:(NSString*)str withDelegate:(id<YHNAdditionManagerDelegate>)delegate;

@end


@protocol YHNAdditionManagerDelegate <NSObject>

@optional
- (void)ACPaySuccess;
- (void)ACPayFail:(NSString *)msg;

@end
