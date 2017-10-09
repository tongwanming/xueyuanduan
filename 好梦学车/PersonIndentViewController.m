//
//  PersonIndentViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/6/5.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "PersonIndentViewController.h"
#import "PersonIndentModel.h"
#import "ChoosePayTypeViewController.h"
#import "SubjectTwoPopWebViewController.h"
#import "UIImageView+WebCache.h"
#import "ChoosedPlaceViewController.h"
#import "ChoosedTypeViewController.h"
#import "ChoosedCocchViewController.h"
#import "DefaultManager.h"
#import "QuitAlertView.h"
#import "OrderValidityManager.h"
#import "ApplyOrderViewController.h"

@interface PersonIndentViewController ()<UITableViewDelegate,UITableViewDataSource,QuitAlertViewBtnClickedDelegate>

@property (nonatomic, strong) NSArray *nameData;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *goBtn;

@end

@implementation PersonIndentViewController

- (NSArray *)nameData{
    if (!_nameData) {
        _nameData = [NSArray arrayWithObjects:@"报名人",@"训练场地",@"报名类型",@"训练教练", nil];
    }
    return _nameData;
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
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    if ([[OrderValidityManager defaultManager] orderValidity]) {
        _model = [[OrderValidityManager defaultManager] getPersonIndentModel];
    }else{
        _tableView.hidden = YES;
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, 30)];
        _titleLabel.center = CGPointMake(CURRENT_BOUNDS.width/2, [[UIScreen mainScreen] bounds].size.height/2-30);
        _titleLabel.textColor = UNMAIN_TEXT_COLOR;
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"当前你还没有任何订单";
        
        _goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _goBtn.frame = CGRectMake(0, 0, 150, 45);
        _goBtn.layer.masksToBounds = YES;
        _goBtn.layer.cornerRadius = 8;
        _goBtn.layer.borderWidth = 0.5;
        _goBtn.layer.borderColor = BLUE_BACKGROUND_COLOR.CGColor;
       [_goBtn setTitleColor:BLUE_BACKGROUND_COLOR forState:UIControlStateNormal];
        [_goBtn setTitle:@"去下单" forState:UIControlStateNormal];
        _goBtn.center = CGPointMake(CURRENT_BOUNDS.width/2, [[UIScreen mainScreen] bounds].size.height/2+30);
        [_goBtn addTarget:self action:@selector(gobtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_goBtn];
        
        _cancelBtn.hidden = YES;
        _contentBtn.hidden = YES;
        _payBtn.hidden = YES;
        _lineView.hidden = YES;
        [self.view addSubview:_titleLabel];
        
    }
//    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // Do any additional setup after loading the view from its nib.
}

- (void)gobtnClick:(UIButton *)btn{
    ApplyOrderViewController *v = [[ApplyOrderViewController alloc] init];
    FirstCatStyleModel *model = [[FirstCatStyleModel alloc] init];
    ChoosedClassModel *choosedModel = [DefaultManager shareDefaultManager].carStyleData[1];
    model.type = choosedModel.titleStr;
    model.price = choosedModel.C1Str;
    model.price2 = choosedModel.C2Str;
    model.backGroundImageName = choosedModel.imageStr;
    model.isInstalments = choosedModel.isInstalmentsC1;
    model.backGroundImageName = choosedModel.imageStr;
    model.categoryCode = choosedModel.categoryCode;
    model.projectTypeCode = choosedModel.projectTypeCode;
    v.model = model;
    [self.navigationController pushViewController:v animated:YES];
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
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, CURRENT_BOUNDS.width-32, 13)];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.text = _model.name;
    nameLabel.font = [UIFont systemFontOfSize:13];
    [topImageView addSubview:nameLabel];
    
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(nameLabel.frame)+14, CURRENT_BOUNDS.width-32-100, 25)];
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
    bigLabel.text = _model.bigTitle;
    [v addSubview:bigLabel];
    
    UILabel *describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bigLabel.frame)+12, CURRENT_BOUNDS.width, 12)];
    describeLabel.font = [UIFont systemFontOfSize:12];
    describeLabel.textColor = UNMAIN_TEXT_COLOR;
    describeLabel.textAlignment = NSTextAlignmentCenter;
    
    
    NSInteger timeStr = [[OrderValidityManager defaultManager] getOrderValidityTime];
    NSString *timeStrNew = [self changeMinToDayAndHourWithTime:timeStr];
    describeLabel.text = [NSString stringWithFormat:@"%@订单将会自动关闭，请及时支付",timeStrNew];
    [v addSubview:describeLabel];
    
    return v;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, 163)];
    v.backgroundColor = [UIColor whiteColor];
    
    UILabel *indetNum = [[UILabel alloc] initWithFrame:CGRectMake(16, 30, CURRENT_BOUNDS.width-32, 13)];
    indetNum.textColor = UNMAIN_TEXT_COLOR;
    indetNum.font = [UIFont systemFontOfSize:13];
    indetNum.text = [NSString stringWithFormat:@"订单号     %@",_model.indentNum];
    [v addSubview:indetNum];
    
    UILabel *createLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(indetNum.frame)+15, CURRENT_BOUNDS.width-32, 13)];
    createLabel.textColor = UNMAIN_TEXT_COLOR;
    createLabel.font = [UIFont systemFontOfSize:13];
    createLabel.text = [NSString stringWithFormat:@"创建日期   %@",_model.createTimeStr];;
    [v addSubview:createLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 97, CURRENT_BOUNDS.width, 0.5)];
    lineView.backgroundColor = UNMAIN_TEXT_COLOR;
    [v addSubview:lineView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width-160, CGRectGetMaxY(lineView.frame)+27, 60, 13)];
    nameLabel.textColor = UNMAIN_TEXT_COLOR;
    nameLabel.textAlignment = NSTextAlignmentRight;
    nameLabel.text = @"应支付:";
    nameLabel.font = [UIFont systemFontOfSize:13];
    [v addSubview:nameLabel];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame), CGRectGetMaxY(lineView.frame)+20, 100, 25)];
    priceLabel.text = [NSString stringWithFormat:@"%@",_model.price];
    priceLabel.textColor = FF8400;
    priceLabel.font = [UIFont systemFontOfSize:25];
    [v addSubview:priceLabel];
    
    
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 163;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 232;
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
    if (indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else{
//         cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.textColor = TEXT_COLOR;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = self.nameData[indexPath.row];
    
    cell.detailTextLabel.textColor = TEXT_COLOR;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.text = self.model.data[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return;
    if (indexPath.row == 0) {
        return;
    }else if (indexPath.row == 1){
        //预选场地
        ChoosedPlaceViewController *typeVc = [[ChoosedPlaceViewController alloc] init];
        typeVc.allExerciseLocationData = [DefaultManager shareDefaultManager].locationData;
        [typeVc returnHasChooedExercisePlaceBlock:^(FirstLocationModel *place) {
            dispatch_async(dispatch_get_main_queue(), ^{
                UITableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                cell.detailTextLabel.text = place.name;
            });
            [[OrderValidityManager defaultManager] saveCurrentPlaceID:place.currentId];
        }];
        [self.navigationController pushViewController:typeVc animated:YES];
    
    }else if (indexPath.row == 2){
        // 报名类型
        ChoosedTypeViewController *typeVc = [[ChoosedTypeViewController alloc] init];
        typeVc.data = [NSArray arrayWithObjects:@"C1手动挡",@"C2自动挡", nil];
        typeVc.choosedType = self.model.data[2];
        typeVc.personSettingView = YES;
        [typeVc returnSelectTypeWithBlock:^(NSString *name) {
            
            __weak __typeof (&*self)weakSelf = self;
            dispatch_async(dispatch_get_main_queue(), ^{
                UITableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
                cell.detailTextLabel.text = name;

            });
            
            NSLog(@"name:---%@",name);
        }];
        [self.navigationController pushViewController:typeVc animated:YES];
    
    }else if (indexPath.row == 3){
        ChoosedCocchViewController *v = [[ChoosedCocchViewController alloc] init];
        v.isByPersonVC = YES;
        [v returnSelectCocchWithBlock:^(NSString *name) {
          
        }];
        [self.navigationController pushViewController:v animated:YES];
    
    }else{
    
    }
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
    }else if (btn.tag == 1003){
        ChoosePayTypeViewController *v = [[ChoosePayTypeViewController alloc] init];
        v.payNum = _model.indentNum;
        v.priceStr = _model.price;
        [self.navigationController pushViewController:v animated:YES];
    }else if (btn.tag == 1004){
    //取消订单
        QuitAlertView *_quitrView = [QuitAlertView createShowView];
        _quitrView.delegate = self;
        _quitrView.frame = self.view.bounds;
        [_quitrView presentAddView:self.view];
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

- (NSString *)changeMinToDayAndHourWithTime:(NSInteger)timr{
    NSString *str;
    int days = floor(timr/(24*60));
    int hours = floor(timr-days*(24*60))/60;
    int mins = floor(timr-days*(24*60) - hours*60);
    str = [NSString stringWithFormat:@"%d天%d小时%d分钟",days,hours,mins];
   
    
    return str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
