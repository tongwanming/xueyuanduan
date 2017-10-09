//
//  SubjectExamResultViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/5/13.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectExamResultViewController.h"
#import "SubjectOneAnalysisTableViewCell.h"
#import "SubjectOneMistakesViewController.h"
#import "SubjectOneAnalysisViewController.h"
#import "SubjectPractiseModel.h"

@interface SubjectExamResultViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SubjectExamResultViewController{

    int _finshedTime;
    NSString *_showTimeStr;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)setTimeStr:(int)timeStr{
    _timeStr = timeStr;
    if (_examType == ExamViewControllerTypeOne) {
        _finshedTime = 2700-timeStr;
    }else{
        _finshedTime = 1800-timeStr;
    }
    int seconds = _finshedTime % 60;
    int minutes = (_finshedTime / 60) % 60;
    _showTimeStr = [NSString stringWithFormat:@"%d分%d秒",minutes,seconds];
}

- (void)setErrorData:(NSMutableArray *)errorData{
    _errorData = errorData;
    
}

- (void)setTrueData:(NSMutableArray *)trueData{
    
    _trueData = trueData;
 

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置时间栏字体的颜色
    
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    [self setNeedsStatusBarAppearanceUpdate];
    
    UIButton *letBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    letBtn.frame = CGRectMake(0, 20, 44, 44);
    [letBtn setImage:[UIImage imageNamed:@"btn_back_white"] forState:UIControlStateNormal];
    letBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [letBtn addTarget:self action:@selector(leftBtnActive:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:letBtn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width/2-50, 20, 100, 44)];
    titleLabel.text = @"错题分析";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:titleLabel];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [self refreshData];
    // Do any additional setup after loading the view from its nib.
}

- (void)refreshData{
    _timeLabel.text = _showTimeStr;
    if (_examType == ExamViewControllerTypeOne) {
        _totalItemsLabel.text = @"100";
        _gardLabel.text = [NSString stringWithFormat:@"%ld",_trueData.count];
        if (_trueData.count > 10) {
            _progressImagevIew.image = [UIImage imageNamed:[NSString stringWithFormat:@"pic_%lu0%%",(_trueData.count )/10]];
        }else{
            _progressImagevIew.image = [UIImage imageNamed:[NSString stringWithFormat:@"pic_%d0%%",1]];
        }
        
        if (_trueData.count >= 90) {
            _nameLabel.text = @"近乎完美";
            _showGardLabel.text = @"合格";
            _backImageView.image = [UIImage imageNamed:@"top_bg_qualified"];
        }else{
            _nameLabel.text = @"马路杀手";
            _showGardLabel.text = @"不合格";
            _backImageView.image = [UIImage imageNamed:@"top_bg_Unqualified"];
        }
        _finishedLabel.text = [NSString stringWithFormat:@"%ld%%",_trueData.count+_errorData.count];
    }else{
        if (_trueData.count > 5) {
            _progressImagevIew.image = [UIImage imageNamed:[NSString stringWithFormat:@"pic_%lu0%%",(_trueData.count )/5]];
        }else{
            _progressImagevIew.image = [UIImage imageNamed:[NSString stringWithFormat:@"pic_%d0%%",1]];
        }
        
        _totalItemsLabel.text = @"50";
        _finishedLabel.text = [NSString stringWithFormat:@"%ld%%",(_trueData.count+_errorData.count)*2];
        _gardLabel.text = [NSString stringWithFormat:@"%ld",_trueData.count*2];
        if (_trueData.count >= 45) {
            _nameLabel.text = @"近乎完美";
            _showGardLabel.text = @"合格";
            _backImageView.image = [UIImage imageNamed:@"top_bg_qualified"];
        }else{
            _nameLabel.text = @"马路杀手";
            _showGardLabel.text = @"不合格";
            _backImageView.image = [UIImage imageNamed:@"top_bg_Unqualified"];
        }
    }
    _mistakeLabel.text = [NSString stringWithFormat:@"%ld",_errorData.count];
}

- (void)leftBtnActive:(UIButton *)btn{
//    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *index = @"index";
    SubjectOneAnalysisTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:index];
    if (!cell) {
        cell = [[SubjectOneAnalysisTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:index];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0) {
        cell.logoImageView.image = [UIImage imageNamed:@"icon_fault"];
        cell.titleLabel.text = @"错题解析";
    }else{
        cell.logoImageView.image = [UIImage imageNamed:@"icon_results"];
        cell.titleLabel.text = @"成绩分析";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        SubjectOneMistakesViewController *v = [[SubjectOneMistakesViewController alloc] init];
        v.gardStr = _gardLabel.text;
        v.errorData = _errorData;
        [self.navigationController pushViewController:v animated:YES];
    }else{
        SubjectOneAnalysisViewController *v = [[SubjectOneAnalysisViewController alloc] init];
        v.gardStr = _gardLabel.text;
        v.errorData = _errorData;
        NSMutableArray *allArr = [[NSMutableArray alloc] init];
        for (SubjectPractiseModel *model in _errorData) {
            [allArr addObject:model];
        }
        for (SubjectPractiseModel *model in _trueData) {
            [allArr addObject:model];
        }
        v.allData = allArr;
        [self.navigationController pushViewController:v animated:YES];
    }
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
