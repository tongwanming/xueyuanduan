//
//  ChoosePayTypeViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/7/20.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "ChoosePayTypeViewController.h"
#import "ChoosePayTypeCell.h"
#import "YHNAdditionManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "PersonIndentViewControllerOther.h"
#import "PersonIndentModel.h"
#import "OrderValidityManager.h"
#import "installment_ViewController.h"

@interface ChoosePayTypeViewController ()<UITableViewDelegate,UITableViewDataSource,YHNAdditionManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *firstData;

@property (nonatomic, strong) NSArray *secondData;

@property (nonatomic, strong) NSArray *imageData;

@end

@implementation ChoosePayTypeViewController{
    NSInteger _choosedPaidWay;
}

- (NSArray *)firstData{
    if (!_firstData) {
        _firstData = @[@"微信支付",@"支付宝支付"];
    }
    
    return _firstData;
}

- (NSArray *)secondData{
    if (!_secondData) {
        _secondData = @[@"微信快捷支付，2.0版本以上",@"建议安装手机客户端5.0版本以上使用"];
    }
    return _secondData;
}

- (NSArray *)imageData{
    if (!_imageData) {
        _imageData = @[@"icon_weichat",@"icon_zhifubao"];
    }
    return _imageData;
}


- (IBAction)btnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Disappear"];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Appear"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _choosedPaidWay = 0;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView setTableHeaderView:[self createHeadView]];
    [_tableView setTableFooterView:[self createFootView]];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 77;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *index = @"index";
    ChoosePayTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:index];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ChoosePayTypeCell" owner:nil options:nil] lastObject];
    }
    
    if (indexPath.row == _choosedPaidWay) {
        cell.checkImage.image = [UIImage imageNamed:@"btn_box_click"];
    }else{
        cell.checkImage.image = [UIImage imageNamed:@"btn_box_normal"];
    }
    cell.logoImage.image = [UIImage imageNamed:self.imageData[indexPath.row]];
    cell.firstLabel.text = self.firstData[indexPath.row];
    cell.secondLabel.text = self.secondData[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _choosedPaidWay = indexPath.row;
    [_tableView reloadData];
}


- (UIView *)createHeadView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, 25+15+15+30+25+20+10)];
    view.backgroundColor = [UIColor clearColor];
    
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, CURRENT_BOUNDS.width, view.frame.size.height-10)];
    subView.backgroundColor = [UIColor whiteColor];
    [view addSubview:subView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, CURRENT_BOUNDS.width, 15)];
    titleLabel.textColor = UNMAIN_TEXT_COLOR;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"需支付:";
    [subView addSubview:titleLabel];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame)+15, CURRENT_BOUNDS.width, 30)];
    priceLabel.textAlignment = NSTextAlignmentCenter;
    priceLabel.font = [UIFont systemFontOfSize:30];
    priceLabel.textColor = TEXT_COLOR;
//    priceLabel.text = @"¥:2,800";
    priceLabel.text = [NSString stringWithFormat:@"%@",_priceStr];
    [subView addSubview:priceLabel];
    
//    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 1)];
//    lineView.center = CGPointMake(CURRENT_BOUNDS.width/2, CGRectGetMaxY(priceLabel.frame)+25);
//    lineView.backgroundColor = [UIColor redColor];
//    [subView addSubview:lineView];
    
    return view;
}

- (UIView *)createFootView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, 110)];
    view.backgroundColor = [UIColor clearColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width-98, 50)];
    btn.center = CGPointMake(CURRENT_BOUNDS.width/2, 25+30);
    btn.backgroundColor = BLUE_BACKGROUND_COLOR;
    [btn setTintColor:[UIColor whiteColor]];
    [btn setTitle:@"支付" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [view addSubview:btn];
    [btn addTarget:self action:@selector(btnClickaaa:) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 5;
    btn.layer.masksToBounds = YES;
    return view;
}

- (void)btnClickaaa:(UIButton *)btn{
    if (_choosedPaidWay == 0) {
    // 微信支付
        NSDictionary *dic =@{@"header":@{
                                     @"cmd": @"",
                                     @"deviceId": @"",
                                     @"deviceName": @"",
                                     @"osName": @"",
                                     @"osVersion": @"",
                                     @"source": @"app",
                                     @"ssost": @"",
                                     @"token": @"",
                                     @"versionCode": @""
                                     },
                             @"orderNo":_payNum,
                             @"openId":@""};
        
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
        NSURL *url = [NSURL URLWithString:@"http://101.37.29.125:7072/payment-service/api/pay/weChatAppPay/toPay"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"];
        [request setValue:token forHTTPHeaderField:@"HMAuthorization"];
        [request setHTTPBody:jsonData];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error == nil) {
                NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSDictionary *dic = [jsonDict objectForKey:@"data"];
                //            // NOTE: 调用支付结果开始支付
                [[YHNAdditionManager sharedManager] sendWeiXinPayRequestWithString:dic withDelegate:self];
                
            }else{
                
            }
        }];
        [dataTask resume];
        
    }else{
    //支付宝支付
        //支付宝支付
        NSDictionary *dic =@{@"header":@{
                                     @"cmd": @"",
                                     @"deviceId": @"",
                                     @"deviceName": @"",
                                     @"osName": @"",
                                     @"osVersion": @"",
                                     @"source": @"app",
                                     @"ssost": @"",
                                     @"token": @"",
                                     @"versionCode": @""
                                     },
                             @"orderNo":_payNum,
                             @"openId":@""};
        
        NSData *data1 = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonStr = [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
        NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        
        //    NSURL *url = [NSURL URLWithString:urlstr];
        NSURL *url = [NSURL URLWithString:@"http://101.37.29.125:7072/payment-service/api/pay/alipayAppPay/toPay"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"];
        [request setValue:token forHTTPHeaderField:@"HMAuthorization"];
        [request setHTTPBody:jsonData];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error == nil) {
                NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSString *appScheme = @"alisdkdemo";
                NSDictionary *dic = [jsonDict objectForKey:@"data"];
                NSString *text = [dic objectForKey:@"text"];

                [[YHNAdditionManager sharedManager] sendAliPayRequestWithString:text withDelegate:self];
                
            }else{
                UIAlertController *v = [UIAlertController alertControllerWithTitle:@"验证失败" message:@"服务器异常！！" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [v addAction:active];
                [self presentViewController:v animated:YES completion:^{
                    
                }];
            }
        }];
        [dataTask resume];

        
    }
}

- (void)ACPaySuccess{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
        NSString *choosedType = [userDic objectForKey:@"choosedPayType"];
        NSString *payNum = [userDic objectForKey:@"payNum"];
        if ([choosedType isEqualToString:@"ONLINE"]) {
            NSDate *date = [NSDate date];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            
            
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            
            [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
            NSString *DateTime = [formatter stringFromDate:date];
            
            PersonIndentViewControllerOther*v = [[PersonIndentViewControllerOther alloc] init];
            
            PersonIndentModel *oldModel = [[OrderValidityManager defaultManager] getPersonIndentModel];
            
            PersonIndentModel *model = [[PersonIndentModel alloc] init];
            v.model = model;
            model.name = oldModel.name;
            model.type = oldModel.type;
            model.price = oldModel.price;
            model.urlName = oldModel.urlName;
            model.bigTitle = @"订单已完成";
            model.desribeStr = @"感谢你使用好梦学车平台进行驾照培训！";
            model.data = oldModel.data;
            model.indentNum = oldModel.indentNum;
            model.createTimeStr = oldModel.createTimeStr;
            model.payTime = DateTime;
            [[OrderValidityManager defaultManager] setModelWithData:model];
            [self.navigationController pushViewController:v animated:YES];
        }else{
            installment_ViewController *v = [[installment_ViewController alloc] init];
//            PersonIndentModel *model = [[PersonIndentModel alloc] init];
            [self.navigationController pushViewController:v animated:YES];
        }
        
    });
    NSLog(@"支付成功");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
