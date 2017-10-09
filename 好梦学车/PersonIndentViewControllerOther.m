//
//  PersonIndentViewControllerOther.m
//  好梦学车
//
//  Created by haomeng on 2017/6/5.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "PersonIndentViewControllerOther.h"
#import "PersonIndentModel.h"
#import "OrderValidityManager.h"
#import "UIImageView+WebCache.h"

@interface PersonIndentViewControllerOther ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *nameData;

@end

@implementation PersonIndentViewControllerOther

- (NSArray *)nameData{
    if (!_nameData) {
        _nameData = [NSArray arrayWithObjects:@"报名人",@"训练场地",@"报名类型",@"训练教练", nil];
    }
    return _nameData;
}

- (IBAction)btnClick:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
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
    _model = [[OrderValidityManager defaultManager] getPersonIndentModel];
    // Do any additional setup after loading the view from its nib.
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, 232)];
    v.backgroundColor = [UIColor whiteColor];
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 15, CURRENT_BOUNDS.width-32, 90)];
    [topImageView sd_setImageWithURL:[NSURL URLWithString:_model.urlName] placeholderImage:[UIImage imageNamed:@""]];
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
    if ([_model.bigTitle isEqualToString:@"订单已完成"]) {
        describeLabel.text = @"感谢你使用好梦学车平台进行驾照培训！";
    }else{
        describeLabel.text = _model.desribeStr;
    }
    
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
    
    UILabel *payLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(createLabel.frame)+15, CURRENT_BOUNDS.width-32, 13)];
    payLabel.textColor = UNMAIN_TEXT_COLOR;
    payLabel.font = [UIFont systemFontOfSize:13];
    payLabel.text = [NSString stringWithFormat:@"付款时间   %@",_model.payTime];;
    [v addSubview:payLabel];
    
    UILabel *payWayLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(payLabel.frame)+15, CURRENT_BOUNDS.width-32, 13)];
    payWayLabel.textColor = UNMAIN_TEXT_COLOR;
    payWayLabel.font = [UIFont systemFontOfSize:13];
    payWayLabel.text = [NSString stringWithFormat:@"付款方式   %@",@"线上全款支付"];;
    [v addSubview:payWayLabel];
    
    UILabel *billType = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(payWayLabel.frame)+15, CURRENT_BOUNDS.width-32, 13)];
    billType.textColor = UNMAIN_TEXT_COLOR;
    billType.font = [UIFont systemFontOfSize:13];
    billType.text = [NSString stringWithFormat:@"发票类型   %@",@"电子发票(个人)"];;
    [v addSubview:billType];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 179, CURRENT_BOUNDS.width, 0.5)];
    lineView.backgroundColor = EEEEEE;
    [v addSubview:lineView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width-160, CGRectGetMaxY(lineView.frame)+27, 60, 13)];
    nameLabel.textColor = UNMAIN_TEXT_COLOR;
    nameLabel.textAlignment = NSTextAlignmentRight;
    nameLabel.text = @"已支付:";
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
    return 255;
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
    cell.textLabel.textColor = TEXT_COLOR;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = self.nameData[indexPath.row];
    
    cell.detailTextLabel.textColor = TEXT_COLOR;
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.text = self.model.data[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
