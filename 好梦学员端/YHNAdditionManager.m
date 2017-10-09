//
//  FDLMAdditionManager.m
//  FDLM
//
//  Created by weitong on 16/1/12.
//  Copyright © 2016年 WangtianSoft. All rights reserved.
//

#import "YHNAdditionManager.h"
#import <AlipaySDK/AlipaySDK.h>

#import <WXApi.h>

@interface YHNAdditionManager()<WXApiDelegate>

@property(nonatomic,strong) NSDictionary                *launchOptions;

@end

@implementation YHNAdditionManager


+ (YHNAdditionManager *)sharedManager
{
    static YHNAdditionManager *sharedManagerInstance = nil;
    static dispatch_once_t predicate; dispatch_once(&predicate, ^{
        sharedManagerInstance = [[self alloc] init];
    });
    return sharedManagerInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)setup:(NSDictionary *)launchOptions
{
    self.launchOptions = launchOptions;
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    if (url.scheme && [url.scheme rangeOfString:kAlipay_Scheme].location != NSNotFound
        && url.host && [url.host isEqualToString:@"safepay"]) {
//        跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSString *orderStatus = [resultDic objectForKey:@"resultStatus"];
            switch ([orderStatus integerValue]) {
                case 9000:
                {
                    if (_delegate && [_delegate respondsToSelector:@selector(ACPaySuccess)]) {
                        [_delegate ACPaySuccess];
                    }
                }
                    break;
                    
                default:
                {
                    if (_delegate && [_delegate respondsToSelector:@selector(ACPayFail:)]) {
                        [_delegate ACPayFail:orderStatus];
                    }
                }
                    break;
            }

        }];
    }
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)sendWeiXinPayRequestWithString:(NSDictionary*)str withDelegate:(id<YHNAdditionManagerDelegate>)delegate;
{
    self.delegate = delegate;
    
    NSMutableString *stamp  = [str objectForKey:@"timestamp"];
//    NSString *aaa = [stamp substringToIndex:10];
    //调起微信支付
    PayReq *req             = [[PayReq alloc] init];
    //    req.openID              = [str objectForKey:@"appid"];
    req.partnerId           = [str objectForKey:@"partnerid"];
    req.prepayId            = [str objectForKey:@"prepayid"];
    req.nonceStr            = [str objectForKey:@"noncestr"];
    req.timeStamp           = stamp.intValue;
    req.package             = [str objectForKey:@"packagestr"];
    req.sign                = [str objectForKey:@"sign"];
//    NSLog(@"----%d",[WXApi sendReq:req]);
    
    return [WXApi sendReq:req];
    
}

- (void)onResp:(BaseResp*)resp
{
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp *response= (PayResp*)resp;
        switch(response.errCode){
            case WXSuccess:
            {
                if (_delegate && [_delegate respondsToSelector:@selector(ACPaySuccess)]) {
                    [_delegate ACPaySuccess];
                }
            }
                break;
            default:
            {
                if (_delegate && [_delegate respondsToSelector:@selector(ACPayFail:)]) {
                    [_delegate ACPayFail:response.errStr];
                }
            }
                break;
        }
    }
}



#pragma mark - 支付宝支付

- (void)sendAliPayRequestWithString:(NSString*)str withDelegate:(id<YHNAdditionManagerDelegate>)delegate;
{
    self.delegate = delegate;

    [[AlipaySDK defaultService] payOrder:str fromScheme:kAlipay_Scheme callback:^(NSDictionary *resultDic) {
        NSString *orderStatus = [resultDic objectForKey:@"resultStatus"];
        NSLog(@"%@",resultDic);
        switch ([orderStatus integerValue]) {
            case 9000:
            {
                if (_delegate && [_delegate respondsToSelector:@selector(ACPaySuccess)]) {
                    [_delegate ACPaySuccess];
                }
            }
                break;
                
            default:
            {
                if (_delegate && [_delegate respondsToSelector:@selector(ACPayFail:)]) {
                    [_delegate ACPayFail:orderStatus];
                }
            }
                break;
        }
    }];
    
}
@end
