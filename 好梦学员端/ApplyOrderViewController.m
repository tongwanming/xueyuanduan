//
//  ApplyOrderViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/4/24.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "ApplyOrderViewController.h"
#import "ApplyOrderTableViewCell.h"
#import "ApplyOrderPaidTableViewCell.h"
#import "OnlineConsultViewController.h"
#import "DefaultManager.h"

#import "PaidWaysModel.h"
#import "PaidNormalModel.h"

#import "QuitAlertView.h"
#import "IPopView.h"
#import <AlipaySDK/AlipaySDK.h>

#import "SamailerImgBtn.h"
#import "SubjectTwoPopWebViewController.h"
#import "UIImageView+WebCache.h"

#import "installment_ViewController.h"

//第二个section
#import "ChoosedTypeViewController.h"
#import "ChoosedPlaceViewController.h"
#import "ChoosedCocchViewController.h"

#import "BillNewsViewController.h"
#import "YHNAdditionManager.h"
#import "OffLineServerStation.h"
#import "CustomAlertView.h"
#import "IPricePopView.h"

#import "PersonIndentViewController.h"
#import "OrderValidityManager.h"


#define COLOR_WITH_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]

@interface ApplyOrderViewController ()<UITableViewDataSource,UITableViewDelegate,QuitAlertViewBtnClickedDelegate,IPopUpWithPromptViewDelegate,YHNAdditionManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSString *payNum;

@end

@implementation ApplyOrderViewController{
    NSMutableArray *_paidWaysData;
    NSInteger _choosedPaidWay;
    NSArray *_imageeData;
    NSMutableDictionary *_firstDic;
    NSMutableDictionary *_secondDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _firstDic = [[NSMutableDictionary alloc] init];
    _secondDic = [[NSMutableDictionary alloc] init];
    self.title = @"报名订单详情";
    self.appleType = @"C1手动挡";
    _coach = @"";
    _userName = @"";
    if (_location == nil) {
        _location = @"";
    }
//    _location = @"";
    _choosedPaidWay = 0;
    self.navigationItem.hidesBackButton = YES;

    UIButton *letBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [letBtn setImage:[UIImage imageNamed:@"btn_back_gray"] forState:UIControlStateNormal];
    letBtn.contentMode = UIViewContentModeScaleAspectFit;
//    letBtn.backgroundColor = [UIColor redColor];
    [letBtn addTarget:self action:@selector(leftBtnActive:) forControlEvents:UIControlEventTouchUpInside];
    letBtn.frame = CGRectMake(0, 0, 40, 40);
    [letBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:letBtn];
    
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    
    SamailerImgBtn *righBtn = [SamailerImgBtn buttonWithType:UIButtonTypeCustom];
    [righBtn setImage:[UIImage imageNamed:@"btn_service"] forState:UIControlStateNormal];
    righBtn.contentMode = UIViewContentModeScaleAspectFit;
    //    letBtn.backgroundColor = [UIColor redColor];
    [righBtn addTarget:self action:@selector(rightBtnActive:) forControlEvents:UIControlEventTouchUpInside];
    righBtn.frame = CGRectMake(0, 0, 40, 40);
    [righBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:righBtn];
   
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    
    NSArray *title1Arr = @[@"线上支付",@"分期付款（3期免息+50元手续费）"];
    NSArray *title2Arr = @[@"土豪富二代学员请选我！",@"首付890元，科目二、三上车前支付剩余分期款"];
    NSArray *imageArr = @[@"icon-home0",@"icon-home",@"icon-home"];
    _imageeData = @[@"pic_four",@"pic_one",@"pic_vip"];
//    _backGroundImageView.image = _imageeData[0];
    _paidWaysData = [[NSMutableArray alloc] init];
    for (int i = 0; i < title1Arr.count; i++) {
        PaidWaysModel *model = [[PaidWaysModel alloc] init];
        model.choosedImage = [UIImage imageNamed:imageArr[i]];
        model.title1 = title1Arr[i];
        model.title2 = title2Arr[i];
        [_paidWaysData addObject:model];
        
    }
    
   
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if ([self.appleType isEqualToString:@"C2自动挡"]) {
        _priceLabel.text = [NSString stringWithFormat:@"¥%@",_model.price2];
        _practicalpriceLabel.text = [NSString stringWithFormat:@"¥%@",_model.price2];
        _typeLabel.text = @"C2自动挡";
    }else{
        _priceLabel.text = [NSString stringWithFormat:@"¥%@",_model.price];
        _practicalpriceLabel.text = [NSString stringWithFormat:@"¥%@",_model.price];
        _typeLabel.text = @"C1手动挡";
    }
    _peopleNumberLabel.text = _model.type;
    NSLog(@"--:%@",_model.price);
    [_backGroundImageView sd_setImageWithURL:[NSURL URLWithString:_model.backGroundImageName] placeholderImage:[UIImage imageNamed:@""]];
    if (self.navigationController.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Disappear"];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:TEXT_COLOR,NSFontAttributeName:[UIFont systemFontOfSize:18]};
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)setModel:(FirstCatStyleModel *)model{
    _model = model;
    
}

- (void)leftBtnActive:(id)leftBtnActive{
    
//    QuitAlertView *_quitrView = [QuitAlertView createShowView];
//    _quitrView.delegate = self;
//    _quitrView.frame = self.view.bounds;
//    [_quitrView presentAddView:self.view];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)rightBtnActive:(id)rightBtnActive{
    SubjectTwoPopWebViewController *v = [[SubjectTwoPopWebViewController alloc] init];
    v.url = @"https://eco-api.meiqia.com/dist/standalone.html?eid=10708";
    v.titleStr = @"在线咨询";
    [self.navigationController pushViewController:v animated:YES];
    
//    OnlineConsultViewController *vc = [[OnlineConsultViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 3;
    }else if (section == 2){
        return 1;
    }else{
        return 2;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGFLOAT_MIN;
    }else if (section == 1){
        return 10;
    }else if (section == 2){
        return 10;
    }else{
        return 47;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        return 70;
    }else
        return 55;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 3) {
        UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width - 50, 34)];
        subView.backgroundColor = COLOR_WITH_HEX(0xF4F6F9);
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(16, 10, [UIScreen mainScreen].bounds.size.width - 50, 34)];
        lab.font = [UIFont systemFontOfSize:14];
        lab.textAlignment = NSTextAlignmentLeft;
        lab.text = @"支付方式";
        lab.textColor = COLOR_WITH_HEX(0xadb1b9);
        lab.backgroundColor = COLOR_WITH_HEX(0xF4F6F9);
        [subView addSubview:lab];
        return subView;
        
        
    }else
        return nil;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *index = @"ddd";
    UITableViewCell *cell;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
    if (indexPath.section == 3) {
        cell = [_firstDic objectForKey:indexPath];
        if (!cell) {

            cell = [[[NSBundle mainBundle] loadNibNamed:@"ApplyOrderPaidTableViewCell" owner:nil options:nil] lastObject];
            [_firstDic setObject:cell forKey:indexPath];
        }
        ((ApplyOrderPaidTableViewCell *)cell).accessoryType = UITableViewCellAccessoryNone;
        if (indexPath.row == _choosedPaidWay) {
            ((ApplyOrderPaidTableViewCell *)cell).logoImageView.image = [UIImage imageNamed:@"btn_box_click"];
        }else{
            ((ApplyOrderPaidTableViewCell *)cell).logoImageView.image = [UIImage imageNamed:@"btn_box_normal"];
        }
        
        ((ApplyOrderPaidTableViewCell *)cell).FirstLabel.text = ((PaidWaysModel *)_paidWaysData[indexPath.row]).title1;
        ((ApplyOrderPaidTableViewCell *)cell).SecondLabel.text = ((PaidWaysModel *)_paidWaysData[indexPath.row]).title2;
        if (indexPath.row == 2) {
            ((ApplyOrderPaidTableViewCell *)cell).accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }else{
        cell = [_secondDic objectForKey:indexPath];
        if (!cell) {
//            cell = [[ApplyOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:index];
            cell = [[[NSBundle mainBundle] loadNibNamed:@"ApplyOrderTableViewCell" owner:nil options:nil] lastObject];
            [_secondDic setObject:cell forKey:indexPath];
        }
        ((ApplyOrderTableViewCell *)cell).accessoryType = UITableViewCellAccessoryNone;
        
        if (indexPath.section == 0) {
            ((ApplyOrderTableViewCell *)cell).titleLabel.text = @"用户昵称";
            ((ApplyOrderTableViewCell *)cell).secondName.text = [dic objectForKey:@"userName"];
            _userName = [dic objectForKey:@"userName"];
        }else if (indexPath.section == 1){
            ((ApplyOrderTableViewCell *)cell).accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            switch (indexPath.row) {
                case 0:
                    ((ApplyOrderTableViewCell *)cell).titleLabel.text = @"报名类型";
                    ((ApplyOrderTableViewCell *)cell).secondName.text = self.appleType;
                    ((ApplyOrderTableViewCell *)cell).secondName.textColor = UNMAIN_TEXT_COLOR;
                    ((ApplyOrderTableViewCell *)cell).secondName.font = [UIFont systemFontOfSize:15];
                    if ([self.peopleNumberLabel.text isEqualToString:@"B2大货车班"]) {
                        ((ApplyOrderTableViewCell *)cell).accessoryType = UITableViewCellAccessoryNone;
                    }
                    break;
                case 1:
                    ((ApplyOrderTableViewCell *)cell).titleLabel.text = @"预选场地";
                    ((ApplyOrderTableViewCell *)cell).secondName.text = self.location;
                    ((ApplyOrderTableViewCell *)cell).secondName.textColor = UNMAIN_TEXT_COLOR;
                    ((ApplyOrderTableViewCell *)cell).secondName.font = [UIFont systemFontOfSize:15];
                    break;
                case 2:
                    ((ApplyOrderTableViewCell *)cell).titleLabel.text = @"预选教练";
                    ((ApplyOrderTableViewCell *)cell).secondName.text = self.coach;
                    ((ApplyOrderTableViewCell *)cell).secondName.textColor = UNMAIN_TEXT_COLOR;
                    ((ApplyOrderTableViewCell *)cell).secondName.font = [UIFont systemFontOfSize:15];
                    break;
                    
                default:
                    break;
            }
        }else if (indexPath.section == 2){
            switch (indexPath.row) {
                case 0:
//                    ((ApplyOrderTableViewCell *)cell).accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//                    ((ApplyOrderTableViewCell *)cell).titleLabel.text = @"发票信息";
//                    ((ApplyOrderTableViewCell *)cell).secondName.text = @"请联系客服";
//                    ((ApplyOrderTableViewCell *)cell).secondName.textColor = UNMAIN_TEXT_COLOR;
//                    ((ApplyOrderTableViewCell *)cell).secondName.font = [UIFont systemFontOfSize:15];
                    
                    ((ApplyOrderTableViewCell *)cell).titleLabel.text = @"学车费用";
                    if ([self.appleType isEqualToString:@"C2自动挡"]) {
                        ((ApplyOrderTableViewCell *)cell).secondName.text = [NSString stringWithFormat:@"¥%@",_model.price2];
                    }else{
                        ((ApplyOrderTableViewCell *)cell).secondName.text = [NSString stringWithFormat:@"¥%@",_model.price];
                    }
                    
                    ((ApplyOrderTableViewCell *)cell).secondName.textColor = FF8400;
                    ((ApplyOrderTableViewCell *)cell).secondName.font = [UIFont systemFontOfSize:25];
                    break;
                case 1:
                    ((ApplyOrderTableViewCell *)cell).titleLabel.text = @"学车费用";
                    if ([self.appleType isEqualToString:@"C2自动挡"]) {
                        ((ApplyOrderTableViewCell *)cell).secondName.text = [NSString stringWithFormat:@"¥%@",_model.price2];
                    }else{
                        ((ApplyOrderTableViewCell *)cell).secondName.text = [NSString stringWithFormat:@"¥%@",_model.price];
                    }
                    
                    ((ApplyOrderTableViewCell *)cell).secondName.textColor = FF8400;
                    ((ApplyOrderTableViewCell *)cell).secondName.font = [UIFont systemFontOfSize:25];
                    break;
                    
                default:
                    break;
            }
        }else{
        
        }
    }
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        _choosedPaidWay = indexPath.row;
        [_tableView reloadData];
        if (indexPath.row == 0) {
            if ([self.appleType isEqualToString:@"C2自动档"]) {
                _practicalpriceLabel.text = [NSString stringWithFormat:@"¥%@",_model.price2];
            }else{
                _practicalpriceLabel.text = [NSString stringWithFormat:@"¥%@",_model.price];
            }
            
            [_sureBtn setTitle:@"确定下单" forState:UIControlStateNormal];
            _orderLabel.hidden = YES;
        }else{
            _orderLabel.hidden = YES;
            _practicalpriceLabel.text = [NSString stringWithFormat:@"¥%@",@"940"];
            [_sureBtn setTitle:@"确定下单" forState:UIControlStateNormal];
//            NSArray *arr = _data;
//            [IPopView createPopUpBackGroundViewWithRect:self.view.bounds andAddView:self andTitleNameArray:arr andStyle:IPopUpWithPromptViewStyleNormal completion:^(IPopUpWithPromptView *popView_) {
//                popView_.delegate = self;
//            }];
        }
    }
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
            {
                if ([self.peopleNumberLabel.text isEqualToString:@"B2大货车班"]) {
                    return;
                }
                // 报名类型
                ChoosedTypeViewController *typeVc = [[ChoosedTypeViewController alloc] init];
                typeVc.data = [NSArray arrayWithObjects:@"C1手动挡",@"C2自动挡", nil];
                typeVc.choosedType = self.appleType;
                [typeVc returnSelectTypeWithBlock:^(NSString *name) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.appleType = name;
                        if ([self.appleType isEqualToString:@"C2自动挡"]) {
                            _priceLabel.text = [NSString stringWithFormat:@"¥%@",_model.price2];
                            if (_choosedPaidWay == 1) {
                                _practicalpriceLabel.text = [NSString stringWithFormat:@"¥%@",@"940"];
                            }else{
                                _practicalpriceLabel.text = [NSString stringWithFormat:@"¥%@",_model.price2];
                            }
                            
                            _typeLabel.text = @"C2自动挡";
                            _model.projectTypeCode = @"002";
                        }else{
                            _priceLabel.text = [NSString stringWithFormat:@"¥%@",_model.price];
                            if (_choosedPaidWay == 1) {
                                _practicalpriceLabel.text = [NSString stringWithFormat:@"¥%@",@"940"];
                            }else{
                                _practicalpriceLabel.text = [NSString stringWithFormat:@"¥%@",_model.price];
                            }
                            
                            _typeLabel.text = @"C1手动挡";
                            _model.projectTypeCode = @"001";
                        }
                        
                        [_tableView reloadData];
                    });
                    
                    NSLog(@"name:---%@",name);
                }];
                [self.navigationController pushViewController:typeVc animated:YES];
            }
                break;
            case 1:
            {
                //预选场地
                ChoosedPlaceViewController *typeVc = [[ChoosedPlaceViewController alloc] init];
                typeVc.allExerciseLocationData = [DefaultManager shareDefaultManager].locationData;
                [typeVc returnHasChooedExercisePlaceBlock:^(FirstLocationModel *place) {
                    
                    if (![self.location isEqualToString:place.name]) {
                        self.coach = @"";
                    }
                    self.location = place.name;
                    
                    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
                    [dic setObject:place.name forKey:@"myPlace"];
                    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"personNews"];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_tableView reloadData];
                    });
                    [[OrderValidityManager defaultManager] saveCurrentPlaceID:place.currentId];
                }];
                [self.navigationController pushViewController:typeVc animated:YES];
            }
                break;
            case 2:
            {
                //预选教练
               
                if (self.location && self.location.length > 0) {
                    ChoosedCocchViewController *v = [[ChoosedCocchViewController alloc] init];
                    v.isByPersonVC = NO;
                    [v returnSelectCocchWithBlock:^(NSString *name) {
                        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
                        [dic setObject:name forKey:@"myConsult"];
                        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"personNews"];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.coach = name;
                            [_tableView reloadData];
                        });
                    }];
                    [self.navigationController pushViewController:v animated:YES];
                }else{
                    ChoosedPlaceViewController *v = [[ChoosedPlaceViewController alloc] init];
                    v.isByPersonVC = NO;
                    v.allExerciseLocationData = _locationData;
                    [v returnHasChooedExercisePlaceBlock:^(FirstLocationModel *place) {
                        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
                        [dic setObject:place.name forKey:@"myPlace"];
                        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"personNews"];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            self.location = place.name;
                            [_tableView reloadData];
                        });
                        [[OrderValidityManager defaultManager] saveCurrentPlaceID:place.currentId];
                    }];
                    
                    [self.navigationController pushViewController:v animated:YES];
                }
            }
                break;
                
            default:
                break;
        }
    }
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            return;
            //发票信息
            BillNewsViewController *billNewVC = [[BillNewsViewController alloc] init];
            [self.navigationController pushViewController:billNewVC animated:YES];
        }else{
            if ([self.appleType isEqualToString:@"C2自动挡"]) {
                [IPricePopView createPopviewWithName:@"费用详情" andPrice:_model.price2 andExamPrice:@"390" andVC:self];
            }else{
                [IPricePopView createPopviewWithName:@"费用详情" andPrice:_model.price andExamPrice:@"390" andVC:self];
            }
            
        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - QuitAlertViewBtnClickedDelegate
- (void)btnClickedWithBtn:(UIButton *)btn{
    if (btn.tag == 1001) {
        NSLog(@"再看看");
    }else if (btn.tag == 1002){
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"离开");
    }else{
    
    }
}
- (IBAction)sureBtnClick:(id)sender {
    
    if (_choosedPaidWay == 1) {
//        [self showNotAllowIn];
//        return;
        if ([_model.isInstalments isEqualToString:@"0"] || _model.isInstalments == nil) {
            [self showNotAllowIn];
            return;
        }
        //分期付款
        [CustomAlertView showAlertViewWithVC:self];
        NSMutableDictionary *personDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
        NSDictionary *dic = @{
                              @"billType": @"",
                              @"categoryCode": _model.categoryCode,
                              @"coachUid": @"",
                              @"header": @{
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
                              @"needBill": @"N",
                              @"payType": @"INSTALLMENT",
                              @"price": @1,
                              @"projectTypeCode": _model.projectTypeCode,
                              @"serviceStationId": @"",
                              @"studentUid": [personDic objectForKey:@"userId"],
                              @"trainPlaceId": @"",
                              @"coachName":_coach,
                              @"trainPlaceName":_location
                              };
        NSData *data1 = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonStr = [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
        NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url = [NSURL URLWithString:@"http://101.37.29.125:7072/order-service/api/order/handle/create"];
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
                NSString *mesg = [jsonDict objectForKey:@"success"];
                if ([mesg boolValue]) {
                    NSDictionary *did = [jsonDict objectForKey:@"data"];
                    _payNum = [did objectForKey:@"orderNo"];
                    NSLog(@"---:%@",@"请求成功");
                    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
                    if (!userDic) {
                        userDic = [[NSMutableDictionary alloc] init];
                    }
                    [userDic setObject:@"INSTALLMENT" forKey:@"choosedPayType"];
                    [userDic setObject:_payNum forKey:@"payNum"];
                    [userDic setObject:_model.type forKey:@"myClass"];
                    [[NSUserDefaults standardUserDefaults] setObject:userDic forKey:@"personNews"];
                    
                    NSDate *date = [NSDate date];
                    
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    
                    
                    [formatter setDateStyle:NSDateFormatterMediumStyle];
                    
                    [formatter setTimeStyle:NSDateFormatterShortStyle];
                    
                    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
                    NSString *DateTime = [formatter stringFromDate:date];
                    
                    installment_ViewController *v = [[installment_ViewController alloc] init];
                    PersonIndentModel *model = [[PersonIndentModel alloc] init];
                    //                    v.model = model;
                    model.name = _typeLabel.text;
                    model.type = _peopleNumberLabel.text;
                    model.price = _priceLabel.text;
                    model.urlName = _model.backGroundImageName;
                    model.bigTitle = @"等待付款中...";
                    model.desribeStr = @"120";
                    model.data = @[_userName,_location,_typeLabel.text,_coach];
                    model.indentNum = _payNum;
                    model.createTimeStr = DateTime;
                   
                    
                    [[OrderValidityManager defaultManager] setModelWithData:model];
                    [[OrderValidityManager defaultManager] initOrderValidity];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.navigationController pushViewController:v animated:YES];
                    });
                }
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showNotAllowIn];
                });
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [CustomAlertView hideAlertView];
            });
        }];
        [dataTask resume];
        
    }else{
        [CustomAlertView showAlertViewWithVC:self];
        NSMutableDictionary *personDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
        NSDictionary *dic = @{
                              @"billType": @"",
                              @"categoryCode": _model.categoryCode,
                              @"coachUid": @"",
                              @"header": @{
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
                              @"needBill": @"N",
                              @"payType": @"ONLINE",
                              @"price": @1,
                              @"projectTypeCode": _model.projectTypeCode,
                              @"serviceStationId": @"",
                              @"studentUid": [personDic objectForKey:@"userId"],
                              @"trainPlaceId": @"",
                              @"coachName":_coach,
                              @"trainPlaceName":_location
                              };
        NSData *data1 = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonStr = [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
        NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url = [NSURL URLWithString:@"http://101.37.29.125:7072/order-service/api/order/handle/create"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
        NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"];
        [request setValue:token forHTTPHeaderField:@"HMAuthorization"];
        [request setHTTPBody:jsonData];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [CustomAlertView hideAlertView];
            });
            if (error == nil) {
                NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSString *mesg = [jsonDict objectForKey:@"success"];
                if ([mesg boolValue]) {
                    NSDictionary *did = [jsonDict objectForKey:@"data"];
                    _payNum = [did objectForKey:@"orderNo"];
                    NSLog(@"---:%@",@"请求成功");
                    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
                    if (!userDic) {
                        userDic = [[NSMutableDictionary alloc] init];
                    }
                    [userDic setObject:@"ONLINE" forKey:@"choosedPayType"];
                     [userDic setObject:_payNum forKey:@"payNum"];
                     [userDic setObject:_model.type forKey:@"myClass"];
                    [[NSUserDefaults standardUserDefaults] setObject:userDic forKey:@"personNews"];
                    NSDate *date = [NSDate date];
                    
                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                    
                    
                    [formatter setDateStyle:NSDateFormatterMediumStyle];
                    
                    [formatter setTimeStyle:NSDateFormatterShortStyle];
                    
                    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
                    NSString *DateTime = [formatter stringFromDate:date];
                    
                    PersonIndentViewController *v = [[PersonIndentViewController alloc] init];
                    PersonIndentModel *model = [[PersonIndentModel alloc] init];
//                    v.model = model;
                    model.name = _typeLabel.text;
                    model.type = _peopleNumberLabel.text;
                    model.price = _priceLabel.text;
                    model.urlName = _model.backGroundImageName;
                    model.bigTitle = @"等待付款中...";
                    model.desribeStr = @"120";
                    model.data = @[_userName,_location,_typeLabel.text,_coach];
                    model.indentNum = _payNum;
                    model.createTimeStr = DateTime;
                    
                    [[OrderValidityManager defaultManager] setModelWithData:model];
                    [[OrderValidityManager defaultManager] initOrderValidity];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.navigationController pushViewController:v animated:YES];
                    });
                }
                
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

#pragma mark - popViewDelegate
- (void)didSelectCurrentViewItemAtIndex:(NSInteger)index andStyle:(IPopUpWithPromptView *)view{
    NSLog(@"%ld",(long)index);
    
    if (view.style == IPopUpWithPromptViewStyleNormal) {
       _orderLabel.text = [NSString stringWithFormat:@"预约:%@支付",((OffLineServerStation *)_data[index]).name];
        
        ApplyOrderPaidTableViewCell *cell = [_firstDic objectForKey:[NSIndexPath indexPathForRow:1 inSection:3]];
        cell.SecondLabel.text = [NSString stringWithFormat:@"支付站点:%@",((OffLineServerStation *)_data[index]).name];
    }else{
        if (index == 1) {
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
                    //            // NOTE: 调用支付结果开始支付
                    [[AlipaySDK defaultService] payOrder:text fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                        NSLog(@"reslut = %@",resultDic);
                    }];
                    
                }else{
                    
                }
            }];
            [dataTask resume];
            
        }else{
            //微信支付
            
            
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
            
        }
    }
}

- (void)showMistake{
    UIAlertController *v = [UIAlertController alertControllerWithTitle:@"验证失败" message:@"服务器异常！！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [v addAction:active];
    [self presentViewController:v animated:YES completion:^{
        
    }];
}

- (void)showNotAllowIn{
    UIAlertController *v = [UIAlertController alertControllerWithTitle:@"提示" message:@"此种班型暂不支持分期！！！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [v addAction:active];
    [self presentViewController:v animated:YES completion:^{
        
    }];
}

@end
