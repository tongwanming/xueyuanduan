//
//  installment ViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/8/29.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "installment_ViewController.h"
#import "SubjectTwoPopWebViewController.h"
#import "ChoosePayTypeViewController.h"
#import "OrderValidityManager.h"
#import "QuitAlertView.h"
#import "UIImageView+WebCache.h"
#import "ChoosedPlaceViewController.h"
#import "DefaultManager.h"
#import "ChoosedTypeViewController.h"
#import "ChoosedCocchViewController.h"
#import "installmentProgressView.h"
#import "CustomAlertView.h"
#import "BillModel.h"
#import "Masonry.h"

@interface installment_ViewController ()<UITableViewDelegate,UITableViewDataSource,QuitAlertViewBtnClickedDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *nameData;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) BillModel *billModel;

@end

@implementation installment_ViewController{
    UILabel *indetNum;
    UILabel *createLabel;
    UILabel *nameLabel;
    UILabel *nameLabelOne;
    UILabel *nameLabelTwo;
   
    UILabel *priceLabel1;
}

- (NSArray *)nameData{
    if (!_nameData) {
        _nameData = [NSArray arrayWithObjects:@"报名人",@"训练场地",@"报名类型",@"训练教练", nil];
    }
    return _nameData;
}
- (IBAction)btnClick:(id)sender {
    UIButton *btn = sender;
    if (btn.tag == 1001) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else if (btn.tag == 1002){
        SubjectTwoPopWebViewController *v = [[SubjectTwoPopWebViewController alloc] init];
        v.url = @"https://eco-api.meiqia.com/dist/standalone.html?eid=10708";
        v.titleStr = @"在线咨询";
        [self.navigationController pushViewController:v animated:YES];
    }
    else if (btn.tag == 1003){
        ChoosePayTypeViewController *v = [[ChoosePayTypeViewController alloc] init];
        v.priceStr = priceLabel1.text;
        v.payNum = _model.indentNum;
        [self.navigationController pushViewController:v animated:YES];
    }else if (btn.tag == 1004){
        //取消订单
        QuitAlertView *_quitrView = [QuitAlertView createShowView];
        _quitrView.delegate = self;
        _quitrView.frame = self.view.bounds;
        [_quitrView presentAddView:self.view];
        NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
        [userDic setObject:@"" forKey:@"choosedPayType"];
        [[NSUserDefaults standardUserDefaults] setObject:userDic forKey:@"personNews"];
        NSLog(@"%@",userDic);
    }else{
    
    }
}

#pragma mark - QuitAlertViewBtnClickedDelegate
- (void)btnClickedWithBtn:(UIButton *)btn{
    if (btn.tag == 1001) {
        NSLog(@"再看看");
    }else if (btn.tag == 1002){
        [[OrderValidityManager defaultManager] destroyOrderValidity];
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"离开");
    }else{
        
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if (!self.navigationController.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Disappear"];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Appear"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _model = [[OrderValidityManager defaultManager] getPersonIndentModel];
    if (_payNum && _payNum.length > 0) {
        _model.indentNum = _payNum;
    }
    [self getData];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    

//    if ([[OrderValidityManager defaultManager] orderValidity]) {
//        _model = [[OrderValidityManager defaultManager] getPersonIndentModel];
//    }else{
//        _tableView.hidden = YES;
//        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, 30)];
//        _titleLabel.center = CGPointMake(CURRENT_BOUNDS.width/2, [[UIScreen mainScreen] bounds].size.height/2);
//        _titleLabel.textColor = UNMAIN_TEXT_COLOR;
//        _titleLabel.font = [UIFont systemFontOfSize:18];
//        _titleLabel.textAlignment = NSTextAlignmentCenter;
//        _titleLabel.text = @"当前你还没有任何订单";
//        _cancelBtn.hidden = YES;
//        _contentBtn.hidden = YES;
//        _payBtn.hidden = YES;
//        _lineView.hidden = YES;
//        [self.view addSubview:_titleLabel];
//        
//    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)getData{
    [CustomAlertView showAlertViewWithVC:self];
    NSDictionary *dic =@{@"orderNo":_model.indentNum};
    
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
    NSURL *url = [NSURL URLWithString:@"http://101.37.29.125:7071/api/order/query/queryByNo"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    [request setHTTPBody:jsonData];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *str = [jsonDict objectForKey:@"success"];
            if ([str boolValue]) {
                
                NSDictionary *arrDic = [jsonDict objectForKey:@"data"];
                _billModel = [[BillModel alloc] init];
                _billModel.allPrice = [self changeTypeWithStr:[arrDic objectForKeyWithNoNsnull:@"originalPrice"]];
                _billModel.handingChnage = [self changeTypeWithStr:[NSString stringWithFormat:@"%@",[arrDic objectForKey:@"chargePrice"]]];
                _billModel.instalmentsNum = [[NSString stringWithFormat:@"%@",[arrDic objectForKey:@"instalmentsNum"]] intValue];
               
                NSArray *listArr = [arrDic objectForKey:@"instalmentsOrderList"];
                
                
                __weak __typeof(&*self) weakSelf = self;
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if (_billModel.instalmentsNum == 4) {
                        //  支付完成
                        _payBtn.alpha = 0.5;
                        _payBtn.userInteractionEnabled = NO;
                    }else{
                        //在支付阶段
                        _payBtn.alpha = 1;
                        _payBtn.userInteractionEnabled = YES;
                    }
                    for (NSDictionary *dic in listArr) {
                        switch ([[NSString stringWithFormat:@"%@",[dic objectForKey:@"instalmentsNum"]] intValue]) {
                            case 1:
                            {
                                _billModel.price1 = [self changeTypeWithStr:[NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]]];
                                _billModel.firstTime = [dic objectForKeyWithNoNsnull:@"repayDate"];
                            }
                                break;
                                
                            case 2:
                            {
                                _billModel.price2 = [self changeTypeWithStr:[NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]]];
                                _billModel.secondTime = [dic objectForKeyWithNoNsnull:@"repayDate"];
                            }
                                break;
                            case 3:
                            {
                                _billModel.price3 = [self changeTypeWithStr:[NSString stringWithFormat:@"%@",[dic objectForKey:@"price"]]];
                                _billModel.thirdTime = [dic objectForKeyWithNoNsnull:@"repayDate"];
                            }
                                break;
                                
                            default:
                                break;
                        }
                    }
                    [CustomAlertView hideAlertView];
                    if (_billModel.instalmentsNum == 1) {
                        _cancelBtn.hidden = NO;
                    }else{
                        _cancelBtn.hidden = YES;
                    }
                    if (_billModel.instalmentsNum == 4) {
                        [weakSelf.bottonSubView remakeConstraints:^(MASConstraintMaker *make) {
                            make.height.equalTo(0);
                        }];
                    }
                    [weakSelf.tableView reloadData];
                   
                });
             
            }else{
                UIAlertController *v = [UIAlertController alertControllerWithTitle:@"验证失败" message:@"服务器异常！！" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [v addAction:active];
                [self presentViewController:v animated:YES completion:^{
                    
                }];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [CustomAlertView hideAlertView];
                    _tableView.hidden = YES;
                   
                });
            }
            
        }
        
        
    }];
    [dataTask resume];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, 232)];
    v.backgroundColor = [UIColor whiteColor];
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 15, CURRENT_BOUNDS.width-32, 90)];
    [topImageView sd_setImageWithURL:[NSURL URLWithString:_model.urlName] placeholderImage:[UIImage imageNamed:@""]];
    topImageView.layer.masksToBounds = YES;
    topImageView.layer.cornerRadius = 4;
    topImageView.layer.shouldRasterize = YES;
    [v addSubview:topImageView];
    
    UILabel *nameLabela = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, CURRENT_BOUNDS.width-32, 13)];
    nameLabela.textColor = [UIColor whiteColor];
    nameLabela.text = _model.name;
    nameLabela.font = [UIFont systemFontOfSize:13];
    [topImageView addSubview:nameLabela];
    
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(nameLabela.frame)+14, CURRENT_BOUNDS.width-32-100, 25)];
    typeLabel.textColor = [UIColor whiteColor];
    typeLabel.font = [UIFont systemFontOfSize:25];
    typeLabel.text = _model.type;
    [topImageView addSubview:typeLabel];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width - 140-32, 45, 120, 24)];
    priceLabel.textColor = [UIColor whiteColor];
    priceLabel.textAlignment = NSTextAlignmentRight;
    priceLabel.font = [UIFont systemFontOfSize:24];
    priceLabel.text = [NSString stringWithFormat:@"%@",_model.price];
    [topImageView addSubview:priceLabel];
    
    UILabel *bigLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topImageView.frame)+40, CURRENT_BOUNDS.width, 23)];
    bigLabel.font = [UIFont systemFontOfSize:23];
    bigLabel.textColor = TEXT_COLOR;
    bigLabel.textAlignment = NSTextAlignmentCenter;
    if (_billModel.instalmentsNum == 4) {
        bigLabel.text = @"订单已完成";

    }else{
        bigLabel.text = @"分期付款中...";

    }
    [v addSubview:bigLabel];
    if (_billModel) {
//        installmentProgressView *mindView = [[installmentProgressView alloc] initWithPrice:[_billModel.allPrice intValue] andProgress:_billModel.instalmentsNum andFrame:CGRectMake(0, CGRectGetMaxY(bigLabel.frame)+30, CURRENT_BOUNDS.width, 107)];
        installmentProgressView *mindView = [[installmentProgressView alloc] initWithPrice1:[_billModel.price1 intValue] andPrice2:[_billModel.price2 intValue] andPrice3:[_billModel.price3 intValue] andHandPrice:[_billModel.handingChnage intValue] andProgress:_billModel.instalmentsNum andFrame:CGRectMake(0, CGRectGetMaxY(bigLabel.frame)+30, CURRENT_BOUNDS.width, 107)];
        [v addSubview:mindView];
    }
    
    
    return v;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, 163)];
    v.backgroundColor = [UIColor whiteColor];
    
    indetNum = [[UILabel alloc] initWithFrame:CGRectMake(16, 30, CURRENT_BOUNDS.width-32, 13)];
    indetNum.textColor = UNMAIN_TEXT_COLOR;
    indetNum.font = [UIFont systemFontOfSize:13];
    indetNum.text = [NSString stringWithFormat:@"订单号     %@",_model.indentNum];
    [v addSubview:indetNum];
    createLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(indetNum.frame)+15, CURRENT_BOUNDS.width-32, 13)];
    createLabel.textColor = UNMAIN_TEXT_COLOR;
    createLabel.font = [UIFont systemFontOfSize:13];
    createLabel.text = [NSString stringWithFormat:@"创建日期   %@",_model.createTimeStr];;
    [v addSubview:createLabel];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(createLabel.frame)+15, CURRENT_BOUNDS.width, 13)];
    nameLabel.textColor = UNMAIN_TEXT_COLOR;
    
    nameLabel.font = [UIFont systemFontOfSize:13];
    [v addSubview:nameLabel];
    
    nameLabelOne = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(nameLabel.frame), CURRENT_BOUNDS.width, 13)];
    nameLabelOne.textColor = UNMAIN_TEXT_COLOR;
    
    nameLabelOne.font = [UIFont systemFontOfSize:13];
    nameLabelOne.hidden = YES;
    [v addSubview:nameLabelOne];
    
    nameLabelTwo = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(nameLabelOne.frame), CURRENT_BOUNDS.width, 13)];
    nameLabelTwo.textColor = UNMAIN_TEXT_COLOR;
    
    nameLabelTwo.font = [UIFont systemFontOfSize:13];
    nameLabelTwo.hidden = YES;
    [v addSubview:nameLabelTwo];
    
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(nameLabel.frame)+15, 200, 13)];
    priceLabel.text = [NSString stringWithFormat:@"支付方式：线上分期付款"];
    priceLabel.textColor = UNMAIN_TEXT_COLOR;
    priceLabel.font = [UIFont systemFontOfSize:13];
    [v addSubview:priceLabel];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(priceLabel.frame)+30, CURRENT_BOUNDS.width, 0.5)];
    lineView.backgroundColor = EEEEEE;
    [v addSubview:lineView];
    
    UILabel *nameLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width-180, CGRectGetMaxY(lineView.frame)+27, 80, 13)];
    nameLabel1.textColor = UNMAIN_TEXT_COLOR;
    nameLabel1.textAlignment = NSTextAlignmentRight;
    if (_billModel.instalmentsNum == 4) {
        nameLabel1.text = @"已支付:";
    }else{
        nameLabel1.text = @"本期应支付:";
    }
    priceLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel1.frame), CGRectGetMaxY(lineView.frame)+20, 100, 25)];
    
    switch (_billModel.instalmentsNum) {
        case 1:
            priceLabel1.text = [NSString stringWithFormat:@"¥%d",[_billModel.price1 intValue] + [_billModel.handingChnage intValue]];
            nameLabel.text = [NSString stringWithFormat:@"付款记录   %@  付款： ¥%d+¥%d",_model.createTimeStr,[_billModel.price1 intValue], [_billModel.handingChnage intValue]];
            break;
        case 2:
            priceLabel1.text = [NSString stringWithFormat:@"¥%@",_billModel.price2];
            nameLabel.text = [NSString stringWithFormat:@"付款记录   %@  付款： ¥%@+¥%@",_billModel.firstTime,_billModel.price1,_billModel.handingChnage];
            break;
        case 3:
            priceLabel1.text = [NSString stringWithFormat:@"¥%@",_billModel.price3];
            nameLabel.text = [NSString stringWithFormat:@"付款记录   %@  付款： ¥%@+¥%@",_billModel.firstTime,_billModel.price1,_billModel.handingChnage];
            nameLabelOne.text = [NSString stringWithFormat:@"                 %@  付款： ¥%@",_billModel.secondTime,_billModel.price2];
            priceLabel.frame = CGRectMake(16, CGRectGetMaxY(nameLabelOne.frame)+15, 200, 13);
            nameLabelOne.hidden = NO;
            break;
        case 4:
            priceLabel1.text = [NSString stringWithFormat:@"¥%d",[_billModel.allPrice intValue] + [_billModel.handingChnage intValue]];
            priceLabel.textColor = TEXT_COLOR;
            nameLabel.text = [NSString stringWithFormat:@"付款记录   %@  付款： ¥%@+¥%@",_billModel.firstTime,_billModel.price1,_billModel.handingChnage];
            nameLabelOne.text = [NSString stringWithFormat:@"                 %@  付款： ¥%@",_billModel.secondTime,_billModel.price2];
            nameLabelTwo.text = [NSString stringWithFormat:@"                 %@  付款： ¥%@",_billModel.thirdTime,_billModel.price3];
            priceLabel.frame = CGRectMake(16, CGRectGetMaxY(nameLabelTwo.frame)+15, 200, 13);
            nameLabelOne.hidden = NO;
            nameLabelTwo.hidden = NO;
            
            break;
            
        default:
            break;
    }
    
    
    
    nameLabel1.font = [UIFont systemFontOfSize:13];
    [v addSubview:nameLabel1];
    
    priceLabel1.textColor = FF8400;
    priceLabel1.font = [UIFont systemFontOfSize:25];
//    priceLabel.text = [NSString stringWithFormat:@"¥:%d",([_billModel.allPrice intValue] + [_billModel.handingChnage intValue])];
    //    priceLabel.backgroundColor = [UIColor redColor];
    [v addSubview:priceLabel1];
  
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 225;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 332;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *index = @"index";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:index];
    if (!cell) {
        cell = [[UITableViewCell alloc ] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:index];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.textColor = TEXT_COLOR;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = self.nameData[indexPath.row];
    
    cell.detailTextLabel.textColor = TEXT_COLOR;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    NSString *detailStr = self.model.data[indexPath.row];
    if (detailStr && detailStr.length > 0) {
        cell.detailTextLabel.text = self.model.data[indexPath.row];
    }else{
        cell.detailTextLabel.text = @"未选择";
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)changeTypeWithStr:(NSString *)str{
    int n = [str intValue];
    int newN = n/100;
    
    NSString *newStr = [NSString stringWithFormat:@"%d",newN];
    
    NSMutableString *mutStr = [NSMutableString stringWithString:newStr];
    [mutStr insertString:@"," atIndex:1];
    
    NSString *resultStr = [NSString stringWithString:mutStr];
    
    return newStr;
    
}

@end
