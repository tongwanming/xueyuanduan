//
//  SubjectOneExamViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/5/12.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectOneExamViewController.h"
#import "SubjectPractisePageViewController.h"
#import "SubjectPractisePopView.h"
#import "QuitAlertView.h"
#import "CustomAlertView.h"
#import "URLConnectionModel.h"
#import "URLConnectionHelper.h"
#import "SubjectExamResultViewController.h"
#import "SubjectExamResultModel.h"

@interface SubjectOneExamViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource,SubjectPractisePagDeleaget,QuitAlertViewBtnClickedDelegate,SubjectPractisePopViewDelegate>

@property (nonatomic, strong) NSArray *imageData;

@property (nonatomic, strong) NSArray *selectImageData;

@property (nonatomic, strong) NSArray *titleNameData;

@property (nonatomic, strong) UIPageViewController *pageViewController;

@property (nonatomic, strong) NSArray *pageContentArray;

@property (nonatomic, strong) NSString *testStr;

@property (nonatomic, strong) NSMutableDictionary *finishDic;

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) NSMutableArray *trueData;

@property (nonatomic, strong) NSMutableArray *errorData;

@property (nonatomic, strong) NSMutableDictionary *finishExercise;


@end

@implementation SubjectOneExamViewController
{
    NSTimer *_timer;
    int _totalTimer;
    NSInteger _currentInteger;
    NSInteger _total;
    NSInteger _finshed;
    NSInteger _true;
    NSInteger _fault;
}

#pragma mark - QuitAlertViewBtnClickedDelegate
- (void)btnClickedWithBtn:(UIButton *)btn{
    if (btn.tag == 1001) {
        NSLog(@"再看看");
    }else if (btn.tag == 1002){
//        [self.navigationController popViewControllerAnimated:YES];
        SubjectExamResultViewController *v = [[SubjectExamResultViewController alloc] init];
        v.examType = _examType;
        v.errorData = _errorData;
        v.trueData = _trueData;
        v.timeStr = _totalTimer;
        
        NSMutableArray *trueData = [[NSMutableArray alloc] init];
        NSMutableArray *errorData = [[NSMutableArray alloc] init];
        for (SubjectPractiseModel *model in _trueData) {
            [trueData addObject:model.questionID];
        }
        
        for (SubjectPractiseModel *model in _errorData) {
             [errorData addObject:model.questionID];
        }
        
        NSDate *data = [NSDate date];
        
        NSString *dateStr = [NSString stringWithFormat:@"%@",data];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        
        NSDate *date = [NSDate date];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        
        [formatter setDateFormat:@"YYYY.MM.dd"];
        NSString *DateTime = [formatter stringFromDate:date];
        
        int _finshedTime;
        if (_examType == ExamViewControllerTypeOne) {
            _finshedTime = 2700-_totalTimer;
        }else{
            _finshedTime = 1800-_totalTimer;
        }
        int seconds = _finshedTime % 60;
        int minutes = (_finshedTime / 60) % 60;
        
        [dic setObject:DateTime forKey:@"dateTime"];
        [dic setObject:trueData forKey:@"trueData"];
        [dic setObject:errorData forKey:@"errorData"];
        [dic setObject:@(_examType) forKey:@"examType"];
        [dic setObject:[NSString stringWithFormat:@"%d:%d",minutes,seconds] forKey:@"totalTimer"];
        
        if (_examType == ExamViewControllerTypeOne) {
            NSDictionary *oldDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"ExerciseResultDic"];
            NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:oldDic];
            
            if (resultDic == nil) {
                resultDic = [[NSMutableDictionary alloc] init];
            }else{
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ExerciseResultDic"];
            }
            [resultDic setObject:dic forKey:dateStr];
            NSDictionary *dicNew = [NSDictionary dictionaryWithDictionary:resultDic];
            [[NSUserDefaults standardUserDefaults] setObject:dicNew forKey:@"ExerciseResultDic"];
            [self.navigationController pushViewController:v animated:YES];
        }else{
            NSDictionary *oldDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"ExerciseResultDicf"];
            NSMutableDictionary *resultDic = [NSMutableDictionary dictionaryWithDictionary:oldDic];
            
            if (resultDic == nil) {
                resultDic = [[NSMutableDictionary alloc] init];
            }else{
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"ExerciseResultDicf"];
            }
            [resultDic setObject:dic forKey:dateStr];
            NSDictionary *dicNew = [NSDictionary dictionaryWithDictionary:resultDic];
            [[NSUserDefaults standardUserDefaults] setObject:dicNew forKey:@"ExerciseResultDicf"];
            [self.navigationController pushViewController:v animated:YES];
        }
        
        
    }else{
        
    }
}

- (void)topViewBtnClcikWithBtn:(UIButton *)btn{
    NSLog(@"aaa:%ld",btn.tag);
}

- (void)SubjectPractiseTabPanelPopViewDelegateWithCollection:(NSIndexPath *)index{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SubjectPractisePopView popClose];
        SubjectPractisePageViewController *initialViewController = [self viewControllerAtIndex:index.row];// 得到第一页
        NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
        [_pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:nil];
    });
}


- (IBAction)btnClick:(id)sender {
    UIButton *btn = sender;
    
    if (self.examType == ExamViewControllerTypeOne) {
        NSString *objectTure = [[NSUserDefaults standardUserDefaults] objectForKey:@"objectOneTrue"];
        NSInteger trueNum = [objectTure integerValue];
        if (_true > trueNum || objectTure == nil) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(long)_true] forKey:@"objectOneTrue"];
        }
    }else{
        NSString *objectTure = [[NSUserDefaults standardUserDefaults] objectForKey:@"objectOneTrue"];
        NSInteger trueNum = [objectTure integerValue];
        if (_true > trueNum || objectTure == nil) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(long)_true] forKey:@"objectForthTrue"];
        }
    }
    
    
    if (btn.tag == 1001) {
        QuitAlertView *_quitrView = [QuitAlertView createShowView];
        _quitrView.delegate = self;
        _quitrView.frame = self.view.bounds;
        
        [_quitrView presentAddView:self.view];
        if (_true >= 90) {
            if (self.examType == ExamViewControllerTypeOne) {
                _quitrView.describeStr = [NSString stringWithFormat:@"你已经答错%ld题，得分%ld分，考试成绩合格，是否交卷",_fault,_true];
            }else{
                _quitrView.describeStr = [NSString stringWithFormat:@"你已经答错%ld题，得分%ld分，考试成绩合格，是否交卷",_fault,_true*2];
            }
            
        }else{
            if (self.examType == ExamViewControllerTypeOne) {
                _quitrView.describeStr = [NSString stringWithFormat:@"你已经答错%ld题，得分%ld分，考试成绩不合格，是否交卷",_fault,_true];
            }else{
                _quitrView.describeStr = [NSString stringWithFormat:@"你已经答错%ld题，得分%ld分，考试成绩不合格，是否交卷",_fault,_true*2];
            }
            
        }
        
        _quitrView.letfTitle = @"继续答题";
        _quitrView.rightTitle = @"确认交卷";
//        [self.navigationController popToRootViewControllerAnimated:YES];
    }else if (btn.tag == 1002){
        QuitAlertView *_quitrView = [QuitAlertView createShowView];
        _quitrView.delegate = self;
        _quitrView.frame = self.view.bounds;
        
        [_quitrView presentAddView:self.view];
        if (_true >= 90) {
            if (self.examType == ExamViewControllerTypeOne) {
                _quitrView.describeStr = [NSString stringWithFormat:@"你已经答错%ld题，得分%ld分，考试成绩合格，是否交卷",_fault,_true];
            }else{
                _quitrView.describeStr = [NSString stringWithFormat:@"你已经答错%ld题，得分%ld分，考试成绩合格，是否交卷",_fault,_true*2];
            }
            
        }else{
            if (self.examType == ExamViewControllerTypeOne) {
                _quitrView.describeStr = [NSString stringWithFormat:@"你已经答错%ld题，得分%ld分，考试成绩不合格，是否交卷",_fault,_true];
            }else{
                _quitrView.describeStr = [NSString stringWithFormat:@"你已经答错%ld题，得分%ld分，考试成绩不合格，是否交卷",_fault,_true*2];
            }
            
        }
        
        _quitrView.letfTitle = @"继续答题";
        _quitrView.rightTitle = @"确认交卷";
    
    }else if(btn.tag == 1003){
        __weak __typeof(&*self) weakSelf = self;
        SubjectPractiseTabPanelPopViewModel *model = [[SubjectPractiseTabPanelPopViewModel alloc] init];
        model.dic = _finishDic;
        model.totalNum = [NSString stringWithFormat:@"%lu",(unsigned long)self.pageContentArray.count];
        [SubjectPractisePopView creatPopUpBackGroundViewWithRect:self.view.frame andAddView:self andData:model completion:^(SubjectPractiseTabPanelPopView *popView_) {
            popView_.delegate = weakSelf;
        } andIndex:^(NSInteger integer_) {
            
        }];
    }else{
    
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
}

- (NSArray *)pageContentArray {
    if (!_pageContentArray) {
        NSMutableArray *arrayM = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in _dataArr) {
            SubjectPractiseModel *model = [[SubjectPractiseModel alloc] init];
            model.question = [dic objectForKey:@"question"];
            model.answer1 = [dic objectForKey:@"option1"];
            model.answer2 = [dic objectForKey:@"option2"];
            model.answer3 = [dic objectForKey:@"option3"];
            model.answer4 = [dic objectForKey:@"option4"];
            model.answer = [dic objectForKey:@"answer"];
            model.explain = [dic objectForKey:@"explain"];
            model.picUrl = [dic objectForKey:@"pic"];
            model.type = [dic objectForKey:@"type"];
            model.chapter = [dic objectForKey:@"chapter"];
            model.questionType = [dic objectForKey:@"questionType"];
            model.questionID = [dic objectForKey:@"questionId"];
            [arrayM addObject:model];
        }
        _pageContentArray = [[NSArray alloc] initWithArray:arrayM];
        
    }
    return _pageContentArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _finishExercise = [[NSMutableDictionary alloc] init];
    if (_examType == ExamViewControllerTypeOne) {
        _totalTimer = 2700;
    }else{
        _totalTimer = 1800;
    }
    
    _timeLabel.text = [self timeFormatted:_totalTimer];
    _finishDic = [[NSMutableDictionary alloc] init];
    _true = 0;
    _fault = 0;
    _finshed = 0;
    
    _trueData = [[NSMutableArray alloc] init];
    _errorData = [[NSMutableArray alloc] init];
    
    [self getTestStr];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)showData{
    _currentInteger = self.pageContentArray.count;
    _total = self.pageContentArray.count;
    // 设置UIPageViewController的配置项
    NSDictionary *options = @{UIPageViewControllerOptionInterPageSpacingKey : @(0)};
    
    // 根据给定的属性实例化UIPageViewController
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                        options:options];
    
    // 设置UIPageViewController代理和数据源
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    
    
    SubjectPractisePageViewController *initialViewController = [self viewControllerAtIndex:0];// 得到第一页
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [_pageViewController setViewControllers:viewControllers
                                  direction:UIPageViewControllerNavigationDirectionReverse
                                   animated:NO
                                 completion:nil];
    
    // 设置UIPageViewController 尺寸
    _pageViewController.view.frame = CGRectMake(0, 0, CURRENT_BOUNDS.width, self.subView.frame.size.height);
    
    // 在页面上，显示UIPageViewController对象的View
    [self addChildViewController:_pageViewController];
    [self.subView addSubview:_pageViewController.view];
    self.tureLabel.text = @"0";
    self.defaultLabel.text = @"0";
    self.finishedLabel.text = @"0";
    self.totalLabel.text = [NSString stringWithFormat:@"/%ld",(long)_total];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshTimer:(NSTimer *)timer{
    if (_totalTimer > 1) {
        _totalTimer--;
        _timeLabel.text = [self timeFormatted:_totalTimer];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

//转换成时分秒

- (NSString *)timeFormatted:(int)totalSeconds
{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
//    int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}

#pragma mark - 根据index得到对应的UIViewController

- (SubjectPractisePageViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (([self.pageContentArray count] == 0) || (index >= [self.pageContentArray count])) {
        return nil;
    }
    // 创建一个新的控制器类，并且分配给相应的数据
    SubjectPractisePageViewController *contentVC = [[SubjectPractisePageViewController alloc] init];
    contentVC.view.frame = CGRectMake(0, 0, CURRENT_BOUNDS.width, CURRENT_BOUNDS.height - 124-100);
    contentVC.delegate = self;
    contentVC.model = [self.pageContentArray objectAtIndex:index];
    contentVC.index = [NSString stringWithFormat:@"%ld",index];
    return contentVC;
}

#pragma mark - UIPageViewControllerDataSource And UIPageViewControllerDelegate

#pragma mark 返回上一个ViewController对象

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:(SubjectPractisePageViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    // 返回的ViewController，将被添加到相应的UIPageViewController对象上。
    // UIPageViewController对象会根据UIPageViewControllerDataSource协议方法,自动来维护次序
    // 不用我们去操心每个ViewController的顺序问题
    return [self viewControllerAtIndex:index];
    
    
}

#pragma mark 返回下一个ViewController对象

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:(SubjectPractisePageViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.pageContentArray count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
    
    
}
#pragma mark - subjectPractiseView

- (void)SubjectPractisePagViewSelectWithAnswer:(NSString *)answer andIndex:(NSString *)index{
   [_finishDic setObject:answer forKey:index];
    if ([answer isEqualToString:@"YES"]) {
        _true++;
        [_trueData addObject:self.pageContentArray[[index intValue]]];
    }else{
        _fault++;
        [_errorData addObject:self.pageContentArray[[index intValue]]];
    }
    _finshed++;
    
    if ([index integerValue] == [self.pageContentArray count]-1) {
        return;
    }else{
        SubjectPractisePageViewController *initialViewController = [self viewControllerAtIndex:[index integerValue]+1];// 得到第一页
        NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
        _currentInteger = self.pageContentArray.count - [index integerValue];
        [_pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:nil];
        
    }
    //    if ([answer isEqualToString:@"YES"]) {
    
    //    }else{
    //
    //    }
    
    self.tureLabel.text = [NSString stringWithFormat:@"%ld",_true];
    self.defaultLabel.text = [NSString stringWithFormat:@"%ld",_fault];
    self.finishedLabel.text = [NSString stringWithFormat:@"%ld",_finshed];
    NSLog(@"answer:%@-----index:%@",answer,index);
}

#pragma mark - 数组元素值，得到下标值

- (NSUInteger)indexOfViewController:(SubjectPractisePageViewController *)viewController {
    return [self.pageContentArray indexOfObject:viewController.model];
}

-(NSArray *)imageData{
    if (!_imageData) {
        _imageData = @[@"btn_analysis_normal",@"btn_all_normal",@"btn_save_normal"];
    }
    return _imageData;
}

- (NSArray *)selectImageData{
    if (!_selectImageData) {
        _selectImageData = @[@"btn_analysis_click",@"btn_all_click",@"btn_save_click"];
    }
    return _selectImageData;
}

- (void)getTestStr{
    if (_examType == ExamViewControllerTypeOne) {
        [CustomAlertView showAlertViewWithVC:self];
        URLConnectionModel *model = [[URLConnectionModel alloc] init];
        model.serviceName = @"hm.question.bank.mock_exam";
        model.course = @"1";
        model.chapter = @"";
        model.isRand = @"";
     
        
        [[URLConnectionHelper shareDefaulte] getPostDataWithUrl:@"" andConnectModel:model andSuccessBlock:^(NSData *data) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *arr = [jsonDict objectForKey:@"body"];
            _dataArr = [NSArray arrayWithArray:arr];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshTimer:) userInfo:nil repeats:YES];
                [CustomAlertView hideAlertView];
                [self showData];
            });
            
        } andFailedBlock:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [CustomAlertView hideAlertView];
            });
            NSLog(@"%@",error);
        }];
    }else{
        [CustomAlertView showAlertViewWithVC:self];
        URLConnectionModel *model = [[URLConnectionModel alloc] init];
        model.serviceName = @"hm.question.bank.mock_exam";
        model.course = @"4";
        model.chapter = @"";
        model.isRand = @"";
        
        [[URLConnectionHelper shareDefaulte] getPostDataWithUrl:@"" andConnectModel:model andSuccessBlock:^(NSData *data) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *arr = [jsonDict objectForKey:@"body"];
            _dataArr = [NSArray arrayWithArray:arr];
            dispatch_async(dispatch_get_main_queue(), ^{
                _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshTimer:) userInfo:nil repeats:YES];
                [CustomAlertView hideAlertView];
                [self showData];
            });
            
        } andFailedBlock:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [CustomAlertView hideAlertView];
            });
            NSLog(@"%@",error);
        }];
    }
}


@end
