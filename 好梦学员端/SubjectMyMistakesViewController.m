//
//  SubjectMyMistakesViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/5/25.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectMyMistakesViewController.h"
#import "testViewController.h"
#import "SqliteDateManager.h"
#import "SubjectPractiseModel.h"
#import "CustomAlertView.h"

@interface SubjectMyMistakesViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) NSArray *dataArr1;


@property (nonatomic, strong) NSMutableArray *allDataArr;

@property (nonatomic, strong) NSArray *allData;

@property (nonatomic, strong) NSMutableArray *data1;

@property (nonatomic, strong) NSMutableArray *data2;

@property (nonatomic, strong) NSMutableArray *data3;

@property (nonatomic, strong) NSMutableArray *data4;

@property (nonatomic, strong) NSMutableArray *data5;

@property (nonatomic, strong) NSMutableArray *data6;

@property (nonatomic, strong) NSMutableArray *data7;

@end

@implementation SubjectMyMistakesViewController


- (IBAction)btnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSArray *)dataArr{
    if (!_dataArr) {
        if (self.type == PractiseViewControllerTypeOneMistake) {
            _dataArr = [NSArray arrayWithObjects:@"道路交通安全法律、法规和规章",@"交通信号",@"安全行车、文明驾车基础知识",@"机动车驾驶操作相关基础知识", nil];
        }else{
            _dataArr = [NSArray arrayWithObjects:@"违法行为综合判断与案例分析",@"安全行车常识",@"常见交通标志、标线和交通手势辨识",@"驾驶职业道德和文明驾驶常识",@"恶劣气候和复杂道路条件下驾驶常识",@"紧急情况下避险常识",@"交通事故救护与常见危机化品处置常识", nil];
        }
        
    }
    return _dataArr;
}
- (IBAction)bottonBtnClick:(id)sender {
    [CustomAlertView showAlertViewWithVC:self];
    if (_type == PractiseViewControllerTypeForthMistake) {
        [[SqliteDateManager sharedManager] deleteSubjectPractiseWithSqlieType:@"myMistakef"];
    }else{
        [[SqliteDateManager sharedManager] deleteSubjectPractiseWithSqlieType:@"myMistake"];
    }
    
//    sleep(1);
    [CustomAlertView hideAlertView];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (NSArray *)dataArr1{
    if (!_dataArr1) {
        _dataArr1 = [NSArray arrayWithObjects:@"查看所有错题",@"练习所有错题", nil];
    }
    return _dataArr1;
}

- (NSMutableArray *)allDataArr{
    if (!_allDataArr) {
        _allDataArr = [[NSMutableArray alloc] init];
        [_allDataArr addObject:self.dataArr1];
        [_allDataArr addObject:self.dataArr];
        
    }
    return _allDataArr;

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    _allData = [self getSqlite];
    [_tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _data1 = [[NSMutableArray alloc] init];
    _data2 = [[NSMutableArray alloc] init];
    _data3 = [[NSMutableArray alloc] init];
    _data4 = [[NSMutableArray alloc] init];
    _data5 = [[NSMutableArray alloc] init];
    _data6 = [[NSMutableArray alloc] init];
    _data7 = [[NSMutableArray alloc] init];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.96f alpha:1.00f];
    _bottonBtn.layer.cornerRadius = 18;
    _bottonBtn.layer.masksToBounds = YES;
    [_bottonBtn setTitleColor:ADB1B9 forState:UIControlStateNormal];
    
    _bottonBtn.layer.borderWidth = 0.5;
    _bottonBtn.layer.borderColor = ADB1B9.CGColor;
   _allData = [self getSqlite];
    if (_allData.count < 1) {
        _tableView.hidden = YES;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"save"]];
        imageView.frame = CGRectMake(0, 0, 192/2, 214/2);
        imageView.center = CGPointMake(CURRENT_BOUNDS.width/2, 406/2+214/4);
        //            imageView.backgroundColor = [UIColor redColor];
        [self.view addSubview:imageView];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+40, CURRENT_BOUNDS.width, 16)];
        title.text = @"您还没有任何错题记录！";
        title.textColor = UNMAIN_TEXT_COLOR;
        title.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:title];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(CURRENT_BOUNDS.width/2-320/4, CGRectGetMaxY(title.frame)+30, 160, 45);
        [btn setTitle:@"去练题" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.backgroundColor = BLUE_BACKGROUND_COLOR;
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn addTarget:self action:@selector(doExerciseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _bottonBtn.hidden = YES;
        return;
    }
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
//    _tableView.scrollEnabled = NO;
    [_tableView setTableFooterView:[[UIView alloc] init]];
    // Do any additional setup after loading the view from its nib.
}

- (void)doExerciseBtnClick:(UIButton *)btn{
    SubjectPractiseViewController *v = [[SubjectPractiseViewController alloc] init];
    ((SubjectPractiseViewController *)v).type = @"order";
    ((SubjectPractiseViewController *)v).practiseType = PractiseViewControllerTypeOne;
    [self.navigationController pushViewController:v animated:YES];
}

- (NSArray *)getSqlite{
    NSArray *arr;
    if (_type == PractiseViewControllerTypeForthMistake) {
        arr = [NSArray arrayWithArray:[[SqliteDateManager sharedManager] getAllDataWithType:@"myMistakef"]];
    }else{
        arr = [NSArray arrayWithArray:[[SqliteDateManager sharedManager] getAllDataWithType:@"myMistake"]];
    }
    [_data1 removeAllObjects];
    [_data2 removeAllObjects];
    [_data3 removeAllObjects];
    [_data4 removeAllObjects];
    [_data5 removeAllObjects];
    [_data6 removeAllObjects];
    [_data7 removeAllObjects];
    
    for (SubjectPractiseModel *model in arr) {
        NSLog(@"model.chapter---:%@",model.chapter);
        if ([model.chapter isEqualToString:@"1"]) {
            [_data1 addObject:model];
        }else if ([model.chapter isEqualToString:@"2"]){
            [_data2 addObject:model];
        }else if ([model.chapter isEqualToString:@"3"]){
            [_data3 addObject:model];
        }else if ([model.chapter isEqualToString:@"4"]){
            [_data4 addObject:model];
        }else if ([model.chapter isEqualToString:@"5"]){
            [_data5 addObject:model];
        }else if ([model.chapter isEqualToString:@"6"]){
            [_data6 addObject:model];
        }else{
            [_data7 addObject:model];
        }
    }
    return arr;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else
        if (self.type == PractiseViewControllerTypeOneMistake) {
            return 4;
        }else
            return 7;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *index = @"index";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:index];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:index];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        cell.textLabel.text = (self.allDataArr[indexPath.section])[indexPath.row];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)_allData.count];
    }else{
        cell.textLabel.text = (self.allDataArr[indexPath.section])[indexPath.row];
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)_data1.count];
            cell.accessoryType = _data1.count > 1?UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
        }else if (indexPath.row == 1){
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)_data2.count];
            cell.accessoryType = _data2.count > 1?UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
        }else if (indexPath.row == 2){
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)_data3.count];
            cell.accessoryType = _data3.count > 1?UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
        }else if (indexPath.row == 3){
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)_data4.count];
            cell.accessoryType = _data4.count > 1?UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
        }else if (indexPath.row == 4){
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)_data5.count];
            cell.accessoryType = _data5.count > 1?UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
        }else if (indexPath.row == 5){
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)_data6.count];
            cell.accessoryType = _data6.count > 1?UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
        }else{
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)_data7.count];
            cell.accessoryType = _data7.count > 1?UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
        }
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = TEXT_COLOR;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SubjectPractiseViewController *v = [[SubjectPractiseViewController alloc] init];
        ((SubjectPractiseViewController *)v).type = @"order";
        ((SubjectPractiseViewController *)v).practiseType = self.type;
        v.mistakeType = @"0";
        [self.navigationController pushViewController:v animated:YES];
    }else{
        SubjectPractiseViewController *v = [[SubjectPractiseViewController alloc] init];
        ((SubjectPractiseViewController *)v).type = @"order";
        ((SubjectPractiseViewController *)v).practiseType = self.type;
        v.mistakeType = [NSString stringWithFormat:@"%ld",indexPath.row+1];
        if (indexPath.row == 0) {
            if (_data1.count < 1) {
                return;
            }
            v.mistakeData = _data1;
        }else if (indexPath.row == 1){
            if (_data2.count < 1) {
                return;
            }
            v.mistakeData = _data2;
        }else if (indexPath.row == 2){
            if (_data3.count < 1) {
                return;
            }
            v.mistakeData = _data3;
        }else if (indexPath.row == 3){
            if (_data4.count < 1) {
                return;
            }
            v.mistakeData = _data4;
        }else if (indexPath.row == 4){
            if (_data5.count < 1) {
                return;
            }
            v.mistakeData = _data5;
        }else if (indexPath.row == 5){
            if (_data6.count < 1) {
                return;
            }
            v.mistakeData = _data6;
        }else{
            if (_data7.count < 1) {
                return;
            }
            v.mistakeData = _data7;
        }
        [self.navigationController pushViewController:v animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
