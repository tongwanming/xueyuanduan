//
//  SubjectRecordViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/5/14.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectRecordViewController.h"
#import "SubjectRecordAndRankViewController.h"
#import "SubjectRankViewController.h"
#import "SubjectOneExamViewController.h"
#import "SubjectExamResultModel.h"
#import "SqliteDateManager.h"
#import "SubjectPractiseModel.h"
#import "CustomAlertView.h"
#import "SubjectOneAnalysisViewController.h"
#import "SubjectPractiseViewController.h"

@interface SubjectRecordViewController ()<SubjectRecordAndRankViewControllerDelegate>

@end

@implementation SubjectRecordViewController{
    SubjectRecordAndRankViewController *_v1;
    SubjectRankViewController *_v2;
    NSMutableArray *_allTrueArr;
    NSMutableArray *_allErrorArr;
    NSMutableArray *_allData;
}

- (IBAction)btnClick:(id)sender {
    UIButton *btn = sender;
    if (btn.tag == 1003) {
        [self.navigationController popViewControllerAnimated:YES];
    };
    return;

    if (btn.tag == 1003) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (btn.tag == 1001){
       
        dispatch_async(dispatch_get_main_queue(), ^{
            [btn setTitleColor:BLUE_BACKGROUND_COLOR forState:UIControlStateNormal];
            [_title1 setTitleColor:UNMAIN_TEXT_COLOR forState:UIControlStateNormal];
            for (UIView *view in self.subView.subviews) {
                [view removeFromSuperview];
            }
            [self.subView addSubview:_v1.view];
        });
        
    }else if (btn.tag == 1002){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [btn setTitleColor:BLUE_BACKGROUND_COLOR forState:UIControlStateNormal];
            [_title2 setTitleColor:UNMAIN_TEXT_COLOR forState:UIControlStateNormal];
            for (UIView *view in self.subView.subviews) {
                [view removeFromSuperview];
            }
            [self.subView addSubview:_v2.view];
        });
        
    }else{
    
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    if (_allData && _allData.count >= 1) {
        return;
    }
     [CustomAlertView showAlertViewWithVC:self];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        int _passTime = 0;
        NSUInteger _greatestGold = 0;
        NSUInteger _totalNum = 0;
        NSUInteger _meanGoal = 0;
        if ([_course isEqualToString:@"1"]) {
            NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"ExerciseResultDic"];
            if (dic == nil || dic.allValues.count < 1) {
                [self showNilView];
                [CustomAlertView hideAlertView];
                return ;
            }
            for (NSMutableDictionary *subDic  in dic.allValues) {
                SubjectExamResultModel *model = [[SubjectExamResultModel alloc] init];
                //错误的questionId
                NSArray *arr = [subDic objectForKey:@"errorData"];
                
                //通过questionId查询对应的数据模型
                NSMutableArray *mutArr = [[NSMutableArray alloc] init];
                for (NSString *str in arr) {
                    SubjectPractiseModel *model = [[SqliteDateManager sharedManager] getDataWithType:@"normal" andID:str];
                    [mutArr addObject:model];
                }
                
                [_allErrorArr addObject:mutArr];
                //正确的questionId
                NSArray *trueArr = [subDic objectForKey:@"trueData"];
                
                //通过questionId查询对应的数据模型
                NSMutableArray *trueMutArr = [[NSMutableArray alloc] init];
                for (NSString *str in trueArr) {
                    SubjectPractiseModel *model = [[SqliteDateManager sharedManager] getDataWithType:@"normal" andID:str];
                    NSLog(@"questionType------%@----",model.questionType);
                    [trueMutArr addObject:model];
                }
                
                model.dateStr = [subDic objectForKey:@"dateTime"];
                model.finishTimeStr = [subDic objectForKey:@"totalTimer"];
                [_allData addObject:model];
                [_allTrueArr addObject:trueMutArr];
                
                //最高得分
                if (trueArr.count > _greatestGold) {
                    _greatestGold = trueArr.count;
                }
                
                //总的分数
                _meanGoal += trueArr.count;
                
                //及格次数
                if (trueArr.count >= 90) {
                    _passTime++;
                }
                
                //累计做题
                _totalNum += trueArr.count + arr.count;
                
            }
            
            _meanGoal = _meanGoal/dic.allKeys.count;
            
            
        }else{
            NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"ExerciseResultDicf"];
            if (dic == nil || dic.allValues.count < 1) {
                [self showNilView];
                [CustomAlertView hideAlertView];
                return;
            }
            
            for (NSMutableDictionary *subDic  in dic.allValues) {
                SubjectExamResultModel *model = [[SubjectExamResultModel alloc] init];
                //错误的questionId
                NSArray *arr = [subDic objectForKey:@"errorData"];
                //通过questionId查询对应的数据模型
                NSMutableArray *mutArr = [[NSMutableArray alloc] init];
                for (NSString *str in arr) {
                    SubjectPractiseModel *model = [[SqliteDateManager sharedManager] getDataWithType:@"normalf" andID:str];
                    [mutArr addObject:model];
                }
                [_allErrorArr addObject:mutArr];
                //正确的questionId
                NSArray *trueArr = [subDic objectForKey:@"trueData"];
                //通过questionId查询对应的数据模型
                NSMutableArray *trueMutArr = [[NSMutableArray alloc] init];
                for (NSString *str in trueArr) {
                    SubjectPractiseModel *model = [[SqliteDateManager sharedManager] getDataWithType:@"normalf" andID:str];
                    [trueMutArr addObject:model];
                }
                
                model.dateStr = [subDic objectForKey:@"dateTime"];
                model.finishTimeStr = [subDic objectForKey:@"totalTimer"];
                [_allData addObject:model];
                [_allTrueArr addObject:trueMutArr];
             
                //最高得分
                if (trueArr.count > _greatestGold) {
                    _greatestGold = trueArr.count*2;
                }
                
                //总的分数
                _meanGoal += trueArr.count;
                
                //及格次数
                if (trueArr.count >= 90) {
                    _passTime++;
                }
                
                //累计做题
                _totalNum += trueArr.count + arr.count;
                
            }
            _meanGoal = _meanGoal/dic.allKeys.count*2;
            
        }
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomAlertView hideAlertView];
            if (_allErrorArr.count < 1 && _allTrueArr.count < 1) {
                NSLog(@"还没有考试记录");
            }else{
                _v1 = [[SubjectRecordAndRankViewController alloc] init];
                _v1.delegate = self;
                _v1.course = _course;
                _v1.allData = _allData;
                _v1.tureData = _allTrueArr;
                _v1.errorData = _allErrorArr;
                
                _v1.topGoal = [NSString stringWithFormat:@"%ld",_greatestGold];
                _v1.passTime = [NSString stringWithFormat:@"%d",_passTime];
                _v1.totalExercise = [NSString stringWithFormat:@"%ld",_totalNum];
                _v1.meanExercise = [NSString stringWithFormat:@"%ld",_meanGoal];
                _v1.view.frame = CGRectMake(0, 0, CURRENT_BOUNDS.width, self.subView.frame.size.height);
                [self addChildViewController:_v1];
                [self.subView addSubview:_v1.view];
            }
        });
    });
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _allErrorArr = [[NSMutableArray alloc] init];
    _allTrueArr = [[NSMutableArray alloc] init];
    _allData = [[NSMutableArray alloc] init];
   
    
    
}

- (void)loadData{
   
    
    
    
}

- (void)showNilView{
   
    dispatch_async(dispatch_get_main_queue(), ^{
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"save"]];
        imageView.frame = CGRectMake(0, 0, 192/2, 214/2);
        imageView.center = CGPointMake(CURRENT_BOUNDS.width/2, 406/2+214/4-64);
        //            imageView.backgroundColor = [UIColor redColor];
        [self.subView addSubview:imageView];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+40, CURRENT_BOUNDS.width, 16)];
        title.text = @"您还没有任何考试记录！";
        title.textColor = UNMAIN_TEXT_COLOR;
        title.textAlignment = NSTextAlignmentCenter;
        [self.subView addSubview:title];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(CURRENT_BOUNDS.width/2-320/4, CGRectGetMaxY(title.frame)+30, 160, 45);
        [btn setTitle:@"去考试" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.backgroundColor = BLUE_BACKGROUND_COLOR;
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn addTarget:self action:@selector(doExerciseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.subView addSubview:btn];
    });
}

- (void)doExerciseBtnClick:(UIButton *)btn{
    if ([_course isEqualToString:@"1"]) {
        SubjectOneExamViewController *v = [[SubjectOneExamViewController alloc] init];
        ((SubjectOneExamViewController *)v).examType = ExamViewControllerTypeOne;
        
        [self.navigationController pushViewController:v animated:YES];
    }else{
        SubjectOneExamViewController *v = [[SubjectOneExamViewController alloc] init];
        ((SubjectOneExamViewController *)v).examType = ExamViewControllerTypeTwo;
        
        [self.navigationController pushViewController:v animated:YES];
    }
    
}

#pragma mark - SubjectRecordAndRankViewControllerDelegate

- (void)subjectRecordAndRankViewControllerWithIndex:(NSIndexPath *)index{
    SubjectOneAnalysisViewController *v = [[SubjectOneAnalysisViewController alloc] init];
    v.gardStr = [NSString stringWithFormat:@"%lu",(unsigned long)((NSArray *)_allErrorArr[index.row]).count];
    v.errorData = _allErrorArr[index.row];
    NSMutableArray *allArr = [[NSMutableArray alloc] init];
    for (SubjectPractiseModel *model in _allTrueArr[index.row]) {
        [allArr addObject:model];
    }
    for (SubjectPractiseModel *model in _allErrorArr[index.row]) {
        [allArr addObject:model];
    }
    v.allData = allArr;
    [self.navigationController pushViewController:v animated:YES];
    

}


- (void)subjectRecordAndRankViewControllerTap:(UIButton *)btn{
   SubjectOneExamViewController *v = [[SubjectOneExamViewController alloc] init];
    if ([_course isEqualToString:@"1"]) {
        ((SubjectOneExamViewController *)v).examType = ExamViewControllerTypeOne;
    }else{
        ((SubjectOneExamViewController *)v).examType = ExamViewControllerTypeTwo;
    }
    [self.navigationController pushViewController:v animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
