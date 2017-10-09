//
//  SubjectOneSpecialProjectViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/5/12.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectOneSpecialProjectViewController.h"
#import "SubjectOneAnalysisTableViewCell.h"
#import "SubjectOneSpecialProjectModel.h"
#import "SubjectOneSpecialProjectCell.h"
#import "SubjectPractiseViewController.h"
#import "URLConnectionModel.h"
#import "URLConnectionHelper.h"
#import "CustomAlertView.h"

@interface SubjectOneSpecialProjectViewController ()<UITableViewDataSource,UITableViewDelegate,SubjectOneSpecialProjectCellDelegate>

@end

@implementation SubjectOneSpecialProjectViewController{

    NSMutableArray *_dataOne;
    NSMutableArray *_dataTwo;
    NSMutableArray *_dataThree;
    NSMutableDictionary *_dataDic;
}
- (IBAction)btnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _dataDic = [[NSMutableDictionary alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self getData];
    // Do any additional setup after loading the view from its nib.
}

- (void)getData{
    
    _tableView.hidden = YES;
    [CustomAlertView showAlertViewWithVC:self];
    URLConnectionModel *model = [[URLConnectionModel alloc] init];
    model.serviceName = @"hm.question.bank.types.count.query";
    model.chapter = @"";
    model.isRand = @"";
    if ([_type isEqualToString:@"1"]) {
        model.course = @"1";
    }else{
        model.course = @"4";
    }
    [[URLConnectionHelper shareDefaulte] getPostDataWithUrl:@"" andConnectModel:model andSuccessBlock:^(NSData *data) {
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *arr = [jsonDict objectForKey:@"body"];
        NSLog(@"%@",jsonDict);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            for (NSDictionary *dic in arr) {
                [_dataDic setObject:[dic objectForKey:@"totalCount"] forKey:[dic objectForKey:@"typeName"]];
            }
            [CustomAlertView hideAlertView];
            _tableView.hidden = NO;
            [_tableView reloadData];
        });
    } andFailedBlock:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomAlertView hideAlertView];
            _tableView.hidden = NO;
        });
    }];

}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger n = 0;
    if (section == 0) {
        n = 2;
    }else if (section == 1){
        n = 1;
    }else if (section == 2){
        n = 1;
    }else if (section == 3){
        n = 1;
    }else{
        n = 1;
    }
    return n;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CGFloat n = CGFLOAT_MIN;
    if (section == 3) {
        n = 5;
    }else{
        
    }
    return n;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat f = 0;
    if (indexPath.section == 2) {
        f = (116*3+110)/2;
    }else if (indexPath.section == 3){
        f = (116*7+110)/2;
    }else{
        f = 55;
    }
    return f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *index = @"index";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:index];
    
    if (indexPath.section == 2) {
        if (!cell) {
            cell = [[SubjectOneSpecialProjectCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:index];
        }
        ((SubjectOneSpecialProjectCell *)cell).dataArr = [self getOneData];
        ((SubjectOneSpecialProjectCell *)cell).titleStr = @"考题类型（6种）";
        ((SubjectOneSpecialProjectCell *)cell).type = _type;
        ((SubjectOneSpecialProjectCell *)cell).delegate = self;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else if (indexPath.section == 3){
        if (!cell) {
            cell = [[SubjectOneSpecialProjectCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:index];
        }
        ((SubjectOneSpecialProjectCell *)cell).dataArr = [self getTwoData];
        ((SubjectOneSpecialProjectCell *)cell).titleStr = @"考试考点（14点）";
        ((SubjectOneSpecialProjectCell *)cell).delegate = self;
        ((SubjectOneSpecialProjectCell *)cell).type = _type;
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }else{
        
        if (!cell) {
            cell = [[SubjectOneAnalysisTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:index];
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.section == 0) {
            switch (indexPath.row) {
                case 0:
                {
                    ((SubjectOneAnalysisTableViewCell *)cell).logoImageView.image = [UIImage imageNamed:@"icon_difficult"];
                    ((SubjectOneAnalysisTableViewCell *)cell).titleLabel.text = @"难理解题";
                    if ([_dataDic objectForKey:@"难理解题"]) {
                        ((SubjectOneAnalysisTableViewCell *)cell).secondLabel.text = [NSString stringWithFormat:@"%@道", [_dataDic objectForKey:@"难理解题"]];
                    }else{
                        ((SubjectOneAnalysisTableViewCell *)cell).secondLabel.text = @"0";
                    }
                    
                }
                    break;
                case 1:
                {
                    ((SubjectOneAnalysisTableViewCell *)cell).logoImageView.image = [UIImage imageNamed:@"icon_fault"];
                    ((SubjectOneAnalysisTableViewCell *)cell).titleLabel.text = @"易错题";
                    if ([_dataDic objectForKey:@"易错题"]) {
                        ((SubjectOneAnalysisTableViewCell *)cell).secondLabel.text = [NSString stringWithFormat:@"%@道", [_dataDic objectForKey:@"易错题"]];
                    }else{
                        ((SubjectOneAnalysisTableViewCell *)cell).secondLabel.text = @"0";
                    }
                }
                    break;
                    
                default:
                    break;
            }
        }else if (indexPath.section == 1){
            ((SubjectOneAnalysisTableViewCell *)cell).logoImageView.image = [UIImage imageNamed:@"icon_chapter"];
            ((SubjectOneAnalysisTableViewCell *)cell).titleLabel.text = @"按章节";
            ((SubjectOneAnalysisTableViewCell *)cell).secondLabel.text = @"4";
        }else{
        
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
        }else{
        
        }
        SubjectPractiseViewController *v = [[SubjectPractiseViewController alloc] init];
        ((SubjectPractiseViewController *)v).type = @"order";
        ((SubjectPractiseViewController *)v).practiseType = PractiseViewControllerTypeOneSpecial;
       SubjectOneAnalysisTableViewCell *cell =  [tableView cellForRowAtIndexPath:indexPath];
        if ([cell.secondLabel.text isEqualToString:@"0"]) {
            return;
        }
        v.titleStr = cell.titleLabel.text;
         [self.navigationController pushViewController:v animated:YES];
    }else if (indexPath.section == 1){
    
    }else{
        return;
    }
}

- (void)SubjectOneSpecialProjectCellTapWith:(UIButton *)btn andTitle:(NSString *)title{
   SubjectPractiseViewController *v = [[SubjectPractiseViewController alloc] init];
    ((SubjectPractiseViewController *)v).type = @"order";
    if ([_type isEqualToString:@"1"]) {
        ((SubjectPractiseViewController *)v).practiseType = PractiseViewControllerTypeOneSpecial;
    }else{
        ((SubjectPractiseViewController *)v).practiseType = PractiseViewControllerTypeForthSpecial;
    }
    
    if ([title isEqualToString:@"考题类型（6种）"]) {
        v.titleStr = ((SubjectOneSpecialProjectModel *)[self getOneData][btn.tag - 1000]).titleLabel;
    }else{
        v.titleStr = ((SubjectOneSpecialProjectModel *)[self getTwoData][btn.tag - 1000]).titleLabel;
    }
    
    [self.navigationController pushViewController:v animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)getOneData{
    if (!_dataOne) {
        _dataOne = [[NSMutableArray alloc] init];
    }
    if (_dataDic.allKeys.count > 0) {
        NSArray *imageData = @[@"icon_danxuan",@"icon_duoxuan",@"icon_panduan",@"icon_wenzi",@"icon_tupian",@"icon_donghua"];
        NSArray *titleData = @[@"单选题",@"多选题",@"判断题",@"文字题",@"图片题",@"动画题"];
        NSArray *numData = @[@"734",@"489",@"129",@"87",@"129",@"87"];
        NSMutableArray *numberData = [[NSMutableArray alloc] init];
        for (int i = 0; i < titleData.count; i++) {
            NSLog(@"---%@",[_dataDic objectForKey:titleData[i]]);
            if (![_dataDic objectForKey:titleData[i]]) {
                [numberData addObject:@"0"];
            }else{
                [numberData addObject:[_dataDic objectForKey:titleData[i]]];
            }
            
        }
        
        for (int i = 0; i < imageData.count; i++) {
            SubjectOneSpecialProjectModel *model = [[SubjectOneSpecialProjectModel alloc] init];
            model.imageName = imageData[i];
            model.titleLabel = titleData[i];
            model.numLabel = numberData[i];
            [_dataOne addObject:model];
        }
    }
    
    return _dataOne;
}

-(NSMutableArray *)getTwoData{
    
    if (!_dataTwo) {
        _dataTwo = [[NSMutableArray alloc] init];
    }
    
    if (_dataDic.allKeys.count > 0) {
        NSArray *imageData = @[@"icon_shijian",@"icon_sudu",@"icon_fakuan",@"icon_juli",@"icon_biaoxian",@"icon_biaozhi",@"icon_shezhi",@"icon_shoushi",@"icon_xinhaodeng",@"icon_jifen",@"icon_jiujia",@"icon_dengguang",@"icon_yibiao",@"icon_lukuang"];
        NSMutableArray *numberData = [[NSMutableArray alloc] init];
        NSArray *titleData = @[@"时间",@"速度",@"罚款",@"距离",@"标线",@"标志",@"装置",@"手势",@"信号灯",@"记分",@"酒驾",@"灯光",@"仪表",@"路况"];
        for (int i = 0; i < titleData.count; i++) {
            NSLog(@"---%@",[_dataDic objectForKey:titleData[i]]);
            if (![_dataDic objectForKey:titleData[i]]) {
                 [numberData addObject:@"0"];
            }else{
                 [numberData addObject:[_dataDic objectForKey:titleData[i]]];
            }
           
        }
//        NSArray *numData = @[@"734",@"489",@"129",@"87",@"129",@"87",@"734",@"489",@"129",@"734",@"129",@"120",@"123",@"345"];
        
        for (int i = 0; i < imageData.count; i++) {
            SubjectOneSpecialProjectModel *model = [[SubjectOneSpecialProjectModel alloc] init];
            model.imageName = imageData[i];
            model.titleLabel = titleData[i];
            model.numLabel = numberData[i];
            [_dataTwo addObject:model];
        }
    }
    return _dataTwo;
}


@end
