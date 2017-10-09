//
//  LoginSucceedViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/4/25.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "LoginSucceedViewController.h"
#import "CustomAlertView.h"
#import "JPUSHService.h"
#import "PersonIndentModel.h"
#import "OrderValidityManager.h"
#import "NSDictionary+objectForKeyWitnNoNsnull.h"

@interface LoginSucceedViewController ()

@end

@implementation LoginSucceedViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Disappear"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Appear"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadPayNumWithUserId:_userid];
    NSSet *set = [[NSSet alloc] initWithObjects:_userid, nil];
    [JPUSHService setTags:set alias:_userid fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
        NSLog(@"%@",iTags);
    }];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClick:(id)sender {
    NSLog(@"立即进入按钮！");
    [[NSUserDefaults standardUserDefaults] setObject:@"login" forKey:@"isLogin"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)reloadPayNumWithUserId:(NSString *)userid{
//    [CustomAlertView showAlertViewWithVC:self];
    NSDictionary *dic =@{@"userId":userid};
    
    
    NSData *data1 = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
    
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonStr];
    
    NSRange range = {0,jsonStr.length};
    
    [mutStr replaceOccurrencesOfString:@" "withString:@""options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    [mutStr replaceOccurrencesOfString:@"\n"withString:@""options:NSLiteralSearch range:range2];
    NSRange range3 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\\"withString:@""options:NSLiteralSearch range:range3];
    NSData *jsonData = [mutStr dataUsingEncoding:NSUTF8StringEncoding];
    
    
    //    NSURL *url = [NSURL URLWithString:urlstr];
    NSURL *url = [NSURL URLWithString:@"http://101.37.29.125:7071/api/order/query/queryOrderList"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    [request setHTTPBody:jsonData];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    [CustomAlertView showAlertViewWithVC:self];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *success = [NSString stringWithFormat:@"%@",[jsonDict objectForKey:@"success"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                
            [CustomAlertView hideAlertView];
            });
            if (success.boolValue) {
                NSArray *arr = [jsonDict objectForKey:@"data"];
                NSDictionary *dic = arr[0];
                
                NSDictionary *imageDic = @{@"1001":@"http://or3qk800m.bkt.clouddn.com/101@2x.png",@"1002":@"http://or3qk800m.bkt.clouddn.com/201@2x.png",@"1003":@"http://or3qk800m.bkt.clouddn.com/301@2x.png",@"1004":@"http://or3qk800m.bkt.clouddn.com/501@2x.png"};
                
                PersonIndentModel *model = [[PersonIndentModel alloc] init];
                if ([[dic objectForKeyWithNoNsnull:@"projectTypeName"] isEqualToString:@"C2"]) {
                    model.name = [NSString stringWithFormat:@"%@自动挡",[dic objectForKeyWithNoNsnull:@"projectTypeName"]];
                }else{
                    model.name = [NSString stringWithFormat:@"%@手动挡",[dic objectForKeyWithNoNsnull:@"projectTypeName"]];
                }
                model.type = [dic objectForKeyWithNoNsnull:@"productName"];
                model.price = [self changeTypeWithStr:[dic objectForKeyWithNoNsnull:@"originalPrice"]];
                model.indentNum = [dic objectForKeyWithNoNsnull:@"orderNo"];
                model.data = @[[dic objectForKeyWithNoNsnull:@"buyerName"],[dic objectForKeyWithNoNsnull:@"trainplaceName"],model.type,[dic objectForKeyWithNoNsnull:@"coachName"]];
                model.createTimeStr = [dic objectForKeyWithNoNsnull:@"createTime"];
                if ([imageDic objectForKey:@"categoryCode"]) {
                    model.urlName = [imageDic objectForKey:@"categoryCode"];
                }else{
                    model.urlName = @"http://or3qk800m.bkt.clouddn.com/501@2x.png";
                }
                model.indentStatus = [dic objectForKeyWithNoNsnull:@"status"];
                model.payTime = [dic objectForKeyWithNoNsnull:@"payTime"];
                if ([[dic objectForKeyWithNoNsnull:@"status"] isEqualToString:@"FINISH"]) {
                    model.bigTitle = @"订单已完成";
                }else{
                    model.bigTitle = @"等待付款中...";
                }
//               model.desribeStr = @"120";
                
                [[OrderValidityManager defaultManager] setModelWithData:model];
                
                NSDateFormatter *formatter1 = [[NSDateFormatter alloc]init];
                [formatter1 setDateFormat:@"yyyy-MM-dd HH-mm-sss"];
                
                NSDate *resDate = [formatter1 dateFromString:[dic objectForKeyWithNoNsnull:@"createTime"]];
                NSMutableDictionary *mutDic = [[NSMutableDictionary alloc] init];
                [mutDic setObject:resDate forKey:@"date"];
                [[NSUserDefaults standardUserDefaults] setObject:mutDic forKey:@"date"];
                
                
                NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
                if (!userDic) {
                    userDic = [[NSMutableDictionary alloc] init];
                }
                [userDic setObject:[dic objectForKey:@"orderNo"] forKey:@"payNum"];
                [userDic setObject:[dic objectForKeyWithNoNsnull:@"payType"] forKey:@"choosedPayType"];
                [userDic setObject:[dic objectForKeyWithNoNsnull:@"productName"] forKey:@"myClass"];
                [userDic setObject:[dic objectForKeyWithNoNsnull:@"trainplaceName"] forKey:@"myPlace"];
                [userDic setObject:[dic objectForKeyWithNoNsnull:@"coachName"] forKey:@"myConsult"];
                [[NSUserDefaults standardUserDefaults] setObject:userDic forKey:@"personNews"];
                
            }else{
                //登录失败
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    //验证码输入错误
//                    UIAlertController *v = [UIAlertController alertControllerWithTitle:@"获取订单信息失败" message:@"你还没有订单信息" preferredStyle:UIAlertControllerStyleAlert];
//                    UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                        
//                    }];
//                    [v addAction:active];
//                    [self presentViewController:v animated:YES completion:^{
//                        
//                    }];
//                });
            }
        }else{
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                [CustomAlertView hideAlertView];
//                UIAlertController *v = [UIAlertController alertControllerWithTitle:@"更新数据失败" message:@"没有成功获取账号信息" preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                    
//                }];
//                [v addAction:active];
//                [self presentViewController:v animated:YES completion:^{
//                    
//                }];
//            });
        }
    }];
    [dataTask resume];
    
}

- (NSString *)changeTypeWithStr:(NSString *)str{
    int n = [str intValue];
    int newN = n/100;
    
    NSString *newStr = [NSString stringWithFormat:@"%d",newN];
    
    NSMutableString *mutStr = [NSMutableString stringWithString:newStr];
    [mutStr insertString:@"," atIndex:1];
    
    NSString *resultStr = [NSString stringWithString:mutStr];
    
    return resultStr;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
