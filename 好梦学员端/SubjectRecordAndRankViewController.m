//
//  SubjectRecordAndRankViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/5/14.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectRecordAndRankViewController.h"
#import "SubjectRecordTableViewCell.h"

@interface SubjectRecordAndRankViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SubjectRecordAndRankViewController
- (IBAction)btnClick:(id)sender {
    UIButton *btn = sender;
    if ([self.delegate respondsToSelector:@selector(subjectRecordAndRankViewControllerTap:)]) {
        [self.delegate performSelector:@selector(subjectRecordAndRankViewControllerTap:) withObject:btn];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    _logoImageView.backgroundColor = [UIColor orangeColor];
    _logoImageView.layer.cornerRadius = 21;
    _logoImageView.layer.masksToBounds = YES;
    
    _topLabel.text = [NSString stringWithFormat:@"您的历史最高分:%@分",_topGoal];
    
    _passTimesLabel.text = _passTime;
    
    _exerciseTimesLabel.text = _totalExercise;
    
    _gradeLabel.text = _meanExercise;
    
    _totalTimesLabel.text = [NSString stringWithFormat:@"共计%lu次模拟考试",(unsigned long)(_errorData.count>_tureData.count?_errorData.count:_tureData.count)];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger _int = _errorData.count>_tureData.count?_errorData.count:_tureData.count;
    return _int;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
   
    SubjectRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubjectRecordTableViewCell"];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"SubjectRecordTableViewCell" owner:nil options:nil].firstObject;
    }
    cell.gardStr = [NSString stringWithFormat:@"%lu分",(unsigned long)((NSArray *)_tureData[indexPath.row]).count];
    cell.timeStr = [NSString stringWithFormat:@"用时:%@",((SubjectExamResultModel *)_allData[indexPath.row]).finishTimeStr];
    cell.exerciseTime = ((SubjectExamResultModel *)_allData[indexPath.row]).dateStr;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(subjectRecordAndRankViewControllerWithIndex:)]) {
        [self.delegate performSelector:@selector(subjectRecordAndRankViewControllerWithIndex:) withObject:indexPath];
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
