//
//  SubjectPractiseViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/5/12.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectPractiseViewController.h"
#import "SubjectPractiseBtn.h"
#import "SubjectPractisePageViewController.h"
#import "SubjectPractisePopView.h"
#import "SubjectPractiseTabPanelPopViewModel.h"
#import "URLConnectionModel.h"
#import "URLConnectionHelper.h"
#import "CustomAlertView.h"
#import "SqliteDateManager.h"
#import "SubjectPractiseModel.h"

@interface SubjectPractiseViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource,SubjectPractisePagDeleaget,SubjectPractisePopViewDelegate>

@property (nonatomic, strong) NSArray *imageData;

@property (nonatomic, strong) NSArray *selectImageData;

@property (nonatomic, strong) NSArray *titleNameData;

@property (nonatomic, strong) UIPageViewController *pageViewController;

@property (nonatomic, strong) NSArray *pageContentArray;

@property (nonatomic, strong) NSString *testStr;

@property (nonatomic, strong) NSMutableDictionary *finishDic;

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) SubjectPractiseModel *currentModel;

@end

@implementation SubjectPractiseViewController
- (IBAction)btnClick:(id)sender {
    UIButton *btn = sender;
    if (btn.tag == 1001) {
        [self.navigationController popViewControllerAnimated:YES];
//        [self.navigationController popToRootViewControllerAnimated:YES];
    }else if (btn.tag == 1002){
        [_orderBtn setTitleColor:BLUE_BACKGROUND_COLOR forState:UIControlStateNormal];
        [_noOorderBtn setTitleColor:UNMAIN_TEXT_COLOR forState:UIControlStateNormal];
        _type = @"order";
        for (UIView *v in self.subView.subviews) {
            [v removeFromSuperview];
        }
        for (UIView *v in self.subMidView.subviews) {
            [v removeFromSuperview];
        }
        [self getTestStr];
    }else if (btn.tag == 1003){
        [_orderBtn setTitleColor:UNMAIN_TEXT_COLOR forState:UIControlStateNormal];
        [_noOorderBtn setTitleColor:BLUE_BACKGROUND_COLOR forState:UIControlStateNormal];
        _type = @"noOrder";
        for (UIView *v in self.subView.subviews) {
            [v removeFromSuperview];
        }
        for (UIView *v in self.subMidView.subviews) {
            [v removeFromSuperview];
        }
        [self getTestStr];
    }else if (btn.tag == 1004){
        if (self.practiseType == PractiseViewControllerTypeForth || self.practiseType == PractiseViewControllerTypeForthMistake || self.practiseType == PractiseViewControllerTypeForthSpecial || self.practiseType == PractiseViewControllerTypeForthCollection) {
            _currentModel.sqliteType = @"myMistakef";
        }else{
            _currentModel.sqliteType = @"myMistake";
        }
        [CustomAlertView showAlertViewWithVC:self];
        [[SqliteDateManager sharedManager] deleteSubjectPractiseModel:_currentModel];
        [CustomAlertView hideAlertView];
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"删除当前的这道题");
    }else{
    
    }
    NSLog(@"%ld",(long)btn.tag);
}

- (NSArray *)pageContentArray {
    if (!_pageContentArray) {
//         [self getTestStr];
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
            model.questionID = [dic objectForKey:@"questionId"];
            [arrayM addObject:model];
            NSLog(@"当前的图片地址：%@",model.picUrl);
        }
        _pageContentArray = [[NSArray alloc] initWithArray:arrayM];
        
    }
    return _pageContentArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
     [self getTestStr];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    if (self.practiseType == PractiseViewControllerTypeOne) {
        //科目一练习
        _removeBtn.hidden = YES;
        _allMistakeLabel.hidden = YES;
    }else if (self.practiseType == PractiseViewControllerTypeForth){
        //科目四练习
        _removeBtn.hidden = YES;
        _allMistakeLabel.hidden = YES;
    }else if (self.practiseType == PractiseViewControllerTypeOneMistake){
        //科目一我的错题
        _orderBtn.hidden = YES;
        _noOorderBtn.hidden = YES;
        
        
    }else if (self.practiseType == PractiseViewControllerTypeOneCollection){
        //科目一我的收藏
        _orderBtn.hidden = YES;
        _noOorderBtn.hidden = YES;
        _removeBtn.hidden = YES;
        _allMistakeLabel.text = @"我的收藏";
        
    }else if (self.practiseType == PractiseViewControllerTypeTwoCollection){
        //科目二我的收藏
        _orderBtn.hidden = YES;
        _noOorderBtn.hidden = YES;
        _removeBtn.hidden = YES;
        _allMistakeLabel.text = @"我的收藏";
    }else if (self.practiseType == PractiseViewControllerTypeThreeCollection){
        //科目三我的收藏
        _orderBtn.hidden = YES;
        _noOorderBtn.hidden = YES;
        _removeBtn.hidden = YES;
        _allMistakeLabel.text = @"我的收藏";
    }else if (self.practiseType == PractiseViewControllerTypeForthMistake){
        //科目四我的错题
        _orderBtn.hidden = YES;
        _noOorderBtn.hidden = YES;
        
    }else if (self.practiseType == PractiseViewControllerTypeForthCollection){
        //科目四我的收藏
        _orderBtn.hidden = YES;
        _noOorderBtn.hidden = YES;
        _removeBtn.hidden = YES;
        _allMistakeLabel.text = @"我的收藏";
    }else if (self.practiseType == PractiseViewControllerTypeOneSpecial) {
        //科目一专项练习
        _orderBtn.hidden = YES;
        _noOorderBtn.hidden = YES;
        _removeBtn.hidden = YES;
        _allMistakeLabel.text = _titleStr;
    }else if (self.practiseType == PractiseViewControllerTypeForthSpecial) {
        //科目四专项练习
        _orderBtn.hidden = YES;
        _noOorderBtn.hidden = YES;
        _removeBtn.hidden = YES;
        _allMistakeLabel.text = _titleStr;
    }else{
    
    }
    if ([_type isEqualToString:@"order"]) {
        [_orderBtn setTitleColor:BLUE_BACKGROUND_COLOR forState:UIControlStateNormal];
    }else{
        [_noOorderBtn setTitleColor:BLUE_BACKGROUND_COLOR forState:UIControlStateNormal];
    }
    self.view.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.98f alpha:1.00f];
   
    
}

- (void)showData{
    if (self.practiseType == PractiseViewControllerTypeOneCollection || self.practiseType == PractiseViewControllerTypeForthCollection) {
        if (self.pageContentArray.count == 0) {
            self.subView.hidden = YES;
            
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"save"]];
            imageView.frame = CGRectMake(0, 0, 192/2, 214/2);
            imageView.center = CGPointMake(CURRENT_BOUNDS.width/2, 406/2+214/4);
//            imageView.backgroundColor = [UIColor redColor];
            [self.view addSubview:imageView];
            
            UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+40, CURRENT_BOUNDS.width, 16)];
            title.text = @"您还没有添加任何收藏！";
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
            return;
        }
    }
    [self createBtnUI];
    
    
    
    // 设置UIPageViewController的配置项
    NSDictionary *options = @{UIPageViewControllerOptionInterPageSpacingKey : @(0)};
    
    // 根据给定的属性实例化UIPageViewController
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                        options:options];
    
    // 设置UIPageViewController代理和数据源
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    SubjectPractisePageViewController *initialViewController;
    
    if (self.practiseType == PractiseViewControllerTypeOne || self.practiseType == PractiseViewControllerTypeForth) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@and%ld",_type,(long)self.practiseType]]) {
            NSString *index = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@and%ld",_type,(long)self.practiseType]];
            initialViewController = [self viewControllerAtIndex:[index intValue]-1];// 得到第n页
            [self refreshBtnWithIndexNormal:index];
            NSMutableDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%ldand%@",(long)self.practiseType,index]];
            _finishDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        }else{
            _finishDic = [[NSMutableDictionary alloc] init];
            initialViewController = [self viewControllerAtIndex:0];// 得到第一页
        }
    }else{
        _finishDic = [[NSMutableDictionary alloc] init];
        initialViewController = [self viewControllerAtIndex:0];// 得到第一页
    }

    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [_pageViewController setViewControllers:viewControllers
                                  direction:UIPageViewControllerNavigationDirectionReverse
                                   animated:NO
                                 completion:nil];
    
    // 设置UIPageViewController 尺寸
    _pageViewController.view.frame = CGRectMake(0, 0, self.subMidView.frame.size.width, self.subMidView.frame.size.height);
    
    
    // 在页面上，显示UIPageViewController对象的View
    [self addChildViewController:_pageViewController];
    [self.subMidView addSubview:_pageViewController.view];
}

- (void)doExerciseBtnClick:(UIButton *)btn{
   SubjectPractiseViewController *v = [[SubjectPractiseViewController alloc] init];
    ((SubjectPractiseViewController *)v).type = @"order";
    ((SubjectPractiseViewController *)v).practiseType = PractiseViewControllerTypeOne;
    [self.navigationController pushViewController:v animated:YES];
}

- (void)createBtnUI{
    for (int i = 0; i < 3; i++) {
        SubjectPractiseBtn *btn = [SubjectPractiseBtn buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(CURRENT_BOUNDS.width/3*i, 0.5, CURRENT_BOUNDS.width/3, 60);
        [btn setImage:[UIImage imageNamed:self.imageData[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:self.selectImageData[i]] forState:UIControlStateSelected];
        [btn setTitleColor:UNMAIN_TEXT_COLOR forState:UIControlStateNormal];
        [btn setTitleColor:BLUE_BACKGROUND_COLOR forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:11];
        [btn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 1) {
            [btn setTitle:[NSString stringWithFormat:@"0/%lu",(unsigned long)self.pageContentArray.count] forState:UIControlStateNormal];
        }else{
            [btn setTitle:self.titleNameData[i] forState:UIControlStateNormal];
        }
        btn.tag = i+10;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.backgroundColor = [UIColor clearColor];
        [self.subView addSubview:btn];
    }
}

- (void)bottomBtnClick:(UIButton *)btn{
    if (btn.tag == 10) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeShowState" object:nil];
    }
    if (btn.tag == 11) {
        
        __weak __typeof(&*self) weakSelf = self;
        SubjectPractiseTabPanelPopViewModel *model = [[SubjectPractiseTabPanelPopViewModel alloc] init];
        model.dic = _finishDic;
        model.totalNum = [NSString stringWithFormat:@"%lu",(unsigned long)self.pageContentArray.count];
        [SubjectPractisePopView creatPopUpBackGroundViewWithRect:self.view.frame andAddView:self andData:model completion:^(SubjectPractiseTabPanelPopView *popView_) {
            popView_.delegate = weakSelf;
        } andIndex:^(NSInteger integer_) {
            
        }];
    }
    if (btn.tag == 12) {
        if (btn.selected) {
            if (self.practiseType == PractiseViewControllerTypeForth || self.practiseType == PractiseViewControllerTypeForthMistake || self.practiseType == PractiseViewControllerTypeForthSpecial || self.practiseType == PractiseViewControllerTypeForthCollection) {
                _currentModel.sqliteType = @"collectionf";
            }else{
                _currentModel.sqliteType = @"collection";
            }
            [[SqliteDateManager sharedManager] deleteSubjectPractiseModel:_currentModel];
        }else{
            if (self.practiseType == PractiseViewControllerTypeForth || self.practiseType == PractiseViewControllerTypeForthMistake || self.practiseType == PractiseViewControllerTypeForthSpecial || self.practiseType == PractiseViewControllerTypeForthCollection) {
                _currentModel.sqliteType = @"collectionf";
            }else{
                _currentModel.sqliteType = @"collection";
            }
            [[SqliteDateManager sharedManager] addSubjectPractiseModel:_currentModel];
        }
        btn.selected = !btn.selected;
    }
   
    NSLog(@"btn.tag%ld",(long)btn.tag);
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
    
    NSLog(@"bb:%@",index);
}

#pragma mark - UIPageViewControllerDataSource And UIPageViewControllerDelegate

#pragma mark 返回上一个ViewController对象

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:(SubjectPractisePageViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    [_finishDic setObject:@"" forKey:[NSString stringWithFormat:@"%ld",index]];
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
    [_finishDic setObject:@"" forKey:[NSString stringWithFormat:@"%ld",index]];
    index++;
    
    if (index == [self.pageContentArray count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
    
    
}

#pragma mark - 根据index得到对应的UIViewController

- (SubjectPractisePageViewController *)viewControllerAtIndex:(NSUInteger)index{
    if (([self.pageContentArray count] == 0) || (index >= [self.pageContentArray count])) {
        return nil;
    }
    
    SubjectPractiseModel *model = [self.pageContentArray objectAtIndex:index];
    if (self.practiseType == PractiseViewControllerTypeOne || self.practiseType == PractiseViewControllerTypeOneMistake || self.practiseType == PractiseViewControllerTypeOneSpecial || self.practiseType == PractiseViewControllerTypeOneCollection) {
        model.sqliteType = @"collection";
    }else{
        model.sqliteType = @"collectionf";
    }
    [self refreshCollectionWithSelect:[[SqliteDateManager sharedManager] selectSubjectPractiseModel:model]];
    // 创建一个新的控制器类，并且分配给相应的数据
    SubjectPractisePageViewController *contentVC = [[SubjectPractisePageViewController alloc] init];
    contentVC.view.frame = CGRectMake(0, 0, CURRENT_BOUNDS.width, CURRENT_BOUNDS.height - 124-100);
    contentVC.delegate = self;
    contentVC.model = model;
    contentVC.index = [NSString stringWithFormat:@"%ld",index];
    _currentModel = [self.pageContentArray objectAtIndex:index];
    contentVC.practiseType = self.practiseType;
    
    NSLog(@"当前页：%@",[NSString stringWithFormat:@"%ld",index]);
    return contentVC;
}



#pragma mark - subjectPractiseView

- (void)SubjectPractisePagViewSelectWithAnswer:(NSString *)answer andIndex:(NSString *)index{
    [self refreshBtnWithIndex:[NSString stringWithFormat:@"%ld",[index integerValue]+1]];
    [_finishDic setObject:answer forKey:index];
    if ([answer isEqualToString:@"NO"]) {
        return;
    }
    if ([answer integerValue] == [self.pageContentArray count]-1) {
        return;
    }else{
        SubjectPractisePageViewController *initialViewController = [self viewControllerAtIndex:[index integerValue]+1];// 得到第一页
        NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
        [_pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:YES
                                     completion:nil];
        
    }
    NSLog(@"answer:%@",answer);
}

- (void)refreshCollectionWithSelect:(BOOL)select{
    for (UIButton *btn in self.subView.subviews) {
        if (btn.tag == 12) {
            [btn setSelected:select];
        }
    }
}

- (void)refreshBtnWithIndex:(NSString *)index{
    for (UIButton *btn in self.subView.subviews) {
        if (btn.tag == 11) {
            [btn setTitle:[NSString stringWithFormat:@"%@/%lu",index,self.pageContentArray.count] forState:UIControlStateNormal];
            [[NSUserDefaults standardUserDefaults] setObject:index forKey:[NSString stringWithFormat:@"%@and%ld",_type,(long)self.practiseType]];
            [[NSUserDefaults standardUserDefaults] setObject:_finishDic forKey:[NSString stringWithFormat:@"%ldand%@",(long)self.practiseType,index]];
        }
    }
}

- (void)refreshBtnWithIndexNormal:(NSString *)index{
    for (UIButton *btn in self.subView.subviews) {
        if (btn.tag == 11) {
            [btn setTitle:[NSString stringWithFormat:@"%@/%lu",index,self.pageContentArray.count] forState:UIControlStateNormal];
        }
    }
}

- (void)showBtnState:(NSString *)state{
    for (UIButton *btn in self.subView.subviews) {
        if (btn.tag == 10) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([state isEqualToString:@"YES"]) {
                    [btn setSelected:YES];
                }else{
                    [btn setSelected:NO];
                }
            });
        }
    }
    
}

#pragma mark - 数组元素值，得到下标值

- (NSUInteger)indexOfViewController:(SubjectPractisePageViewController *)viewController {
    return [self.pageContentArray indexOfObject:viewController.model];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (NSArray *)titleNameData{
    if (!_titleNameData) {
        _titleNameData = @[@"解析",@"24/1000",@"收藏"];
    }
    return _titleNameData;
}

- (void)getTestStr{
    
    if (self.practiseType == PractiseViewControllerTypeOne) {
        //科目一练习
        NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%ld",_type,(long)self.practiseType]];
        if (arr !=nil && arr.count > 1) {
            
            _dataArr = [NSArray arrayWithArray:arr];
            [self showData];
        }else{
            [CustomAlertView showAlertViewWithVC:self];
            URLConnectionModel *model = [[URLConnectionModel alloc] init];
            model.serviceName = @"hm.question.bank.list.query";
            model.course = @"1";
            model.chapter = @"";
            if ([_type isEqualToString:@"order"]) {
                model.isRand = @"";
            }else{
                model.isRand = @"Y";
            }
            
            [[URLConnectionHelper shareDefaulte] getPostDataWithUrl:@"" andConnectModel:model andSuccessBlock:^(NSData *data) {
                NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSArray *arr = [jsonDict objectForKey:@"body"];
                _dataArr = [NSArray arrayWithArray:arr];
                [[NSUserDefaults standardUserDefaults] setObject:_dataArr forKey:[NSString stringWithFormat:@"%@%ld",_type,self.practiseType]];
                dispatch_async(dispatch_get_main_queue(), ^{
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
        
       
    }else if (self.practiseType == PractiseViewControllerTypeForth){
        //科目四练习
        NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@%ld",_type,(long)self.practiseType]];
        
        if (arr !=nil && arr.count > 1) {
            
            _dataArr = [NSArray arrayWithArray:arr];
            [self showData];
        }else{
            [CustomAlertView showAlertViewWithVC:self];
            URLConnectionModel *model = [[URLConnectionModel alloc] init];
            model.serviceName = @"hm.question.bank.list.query";
            model.course = @"4";
            model.chapter = @"";
            if ([_type isEqualToString:@"order"]) {
                model.isRand = @"";
            }else{
                model.isRand = @"Y";
            }
            
            [[URLConnectionHelper shareDefaulte] getPostDataWithUrl:@"" andConnectModel:model andSuccessBlock:^(NSData *data) {
                NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSArray *arr = [jsonDict objectForKey:@"body"];
                _dataArr = [NSArray arrayWithArray:arr];
                [[NSUserDefaults standardUserDefaults] setObject:_dataArr forKey:[NSString stringWithFormat:@"%@%ld",_type,self.practiseType]];
                dispatch_async(dispatch_get_main_queue(), ^{
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
    }else if (self.practiseType == PractiseViewControllerTypeOneMistake){
        //科目一我的错题
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [CustomAlertView showAlertViewWithVC:self];
            if ([_mistakeType isEqualToString:@"0"]) {
                _pageContentArray = [[NSArray alloc] initWithArray:[[SqliteDateManager sharedManager] getAllDataWithType:@"myMistake"]];
            }else{
                _pageContentArray = [[SqliteDateManager sharedManager] getMistakeDataWithType:@"myMistake" andSubType:_mistakeType];
            }
            
            [CustomAlertView hideAlertView];
            [self showData];
        });
        
        
    }else if (self.practiseType == PractiseViewControllerTypeOneCollection){
        //科目一我的收藏
        dispatch_async(dispatch_get_main_queue(), ^{
        
            [CustomAlertView showAlertViewWithVC:self];
             _pageContentArray = [[NSArray alloc] initWithArray:[[SqliteDateManager sharedManager] getAllDataWithType:@"collection"]];
            [CustomAlertView hideAlertView];
            [self showData];
        });
        
        
    }else if (self.practiseType == PractiseViewControllerTypeTwoCollection){
        //科目二我的收藏
        [CustomAlertView showAlertViewWithVC:self];
        URLConnectionModel *model = [[URLConnectionModel alloc] init];
        model.serviceName = @"hm.question.bank.list.query";
        model.course = @"1";
        model.chapter = @"";
        model.isRand = @"";
        [[URLConnectionHelper shareDefaulte] getPostDataWithUrl:@"" andConnectModel:model andSuccessBlock:^(NSData *data) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *arr = [jsonDict objectForKey:@"body"];
            _dataArr = [NSArray arrayWithArray:arr];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [CustomAlertView hideAlertView];
                [self showData];
            });
            
        } andFailedBlock:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [CustomAlertView hideAlertView];
            });
            NSLog(@"%@",error);
        }];
    }else if (self.practiseType == PractiseViewControllerTypeThreeCollection){
        //科目三我的收藏
        [CustomAlertView showAlertViewWithVC:self];
        URLConnectionModel *model = [[URLConnectionModel alloc] init];
        model.serviceName = @"hm.question.bank.list.query";
        model.course = @"1";
        model.chapter = @"";
        model.isRand = @"";
        [[URLConnectionHelper shareDefaulte] getPostDataWithUrl:@"" andConnectModel:model andSuccessBlock:^(NSData *data) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *arr = [jsonDict objectForKey:@"body"];
            _dataArr = [NSArray arrayWithArray:arr];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [CustomAlertView hideAlertView];
                [self showData];
            });
            
        } andFailedBlock:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [CustomAlertView hideAlertView];
            });
            NSLog(@"%@",error);
        }];
    }else if (self.practiseType == PractiseViewControllerTypeForthMistake){
        //科目四我的错题
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [CustomAlertView showAlertViewWithVC:self];
            if ([_mistakeType isEqualToString:@"0"]) {
                _pageContentArray = [[NSArray alloc] initWithArray:[[SqliteDateManager sharedManager] getAllDataWithType:@"myMistakef"]];
            }else{
                _pageContentArray = [[NSArray array] initWithArray:[[SqliteDateManager sharedManager] getMistakeDataWithType:@"myMistakef" andSubType:_mistakeType]];
            }
            
            [CustomAlertView hideAlertView];
            [self showData];
        });
        
    }else if (self.practiseType == PractiseViewControllerTypeForthCollection){
        //科目四我的收藏
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [CustomAlertView showAlertViewWithVC:self];
            _pageContentArray = [[NSArray alloc] initWithArray:[[SqliteDateManager sharedManager] getAllDataWithType:@"collectionf"]];
            [CustomAlertView hideAlertView];
            [self showData];
        });
        
    }else if (self.practiseType == PractiseViewControllerTypeOneSpecial) {
        //科目一专项练习
        [CustomAlertView showAlertViewWithVC:self];
        URLConnectionModel *model = [[URLConnectionModel alloc] init];
        model.serviceName = @"hm.question.bank.list.query";
        model.course = @"1";
        model.chapter = @"";
        model.isRand = @"";
        [self setTypeWithModel:model andName:_titleStr];
        [[URLConnectionHelper shareDefaulte] getPostDataWithUrl:@"" andConnectModel:model andSuccessBlock:^(NSData *data) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *arr = [jsonDict objectForKey:@"body"];
            _dataArr = [NSArray arrayWithArray:arr];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [CustomAlertView hideAlertView];
                [self showData];
            });
            
        } andFailedBlock:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [CustomAlertView hideAlertView];
            });
            NSLog(@"%@",error);
        }];
    }else if (self.practiseType == PractiseViewControllerTypeForthSpecial) {
        //科目四专项练习
        [CustomAlertView showAlertViewWithVC:self];
        URLConnectionModel *model = [[URLConnectionModel alloc] init];
        model.serviceName = @"hm.question.bank.list.query";
        model.course = @"4";
        model.chapter = @"";
        model.isRand = @"";
        [self setTypeWithModel:model andName:_titleStr];
        [[URLConnectionHelper shareDefaulte] getPostDataWithUrl:@"" andConnectModel:model andSuccessBlock:^(NSData *data) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *arr = [jsonDict objectForKey:@"body"];
            _dataArr = [NSArray arrayWithArray:arr];
            
            dispatch_async(dispatch_get_main_queue(), ^{
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
        
    }
}

- (void)setTypeWithModel:(URLConnectionModel *)model andName:(NSString *)title{
    if ([title isEqualToString:@"难理解题"]) {
        model.type = @"98";
    }else if ([title isEqualToString:@"易错题"]){
        model.type = @"99";
    }else if ([title isEqualToString:@"时间"]){
        model.type = @"100";
    }else if ([title isEqualToString:@"距离"]){
        model.type = @"101";
    }else if ([title isEqualToString:@"罚款"]){
        model.type = @"102";
    }else if ([title isEqualToString:@"标线"]){
        model.type = @"103";
    }else if ([title isEqualToString:@"标志"]){
        model.type = @"104";
    }else if ([title isEqualToString:@"速度"]){
        model.type = @"105";
    }else if ([title isEqualToString:@"手势"]){
        model.type = @"106";
    }else if ([title isEqualToString:@"信号灯"]){
        model.type = @"107";
    }else if ([title isEqualToString:@"记分"]){
        model.type = @"108";
    }else if ([title isEqualToString:@"酒驾"]){
        model.type = @"109";
    }else if ([title isEqualToString:@"灯光"]){
        model.type = @"110";
    }else if ([title isEqualToString:@"仪表"]){
        model.type = @"111";
    }else if ([title isEqualToString:@"装置"]){
        model.type = @"112";
    }else if ([title isEqualToString:@"路况"]){
        model.type = @"113";
    }else if ([title isEqualToString:@"单选题"]){
        model.type = @"200";
    }else if ([title isEqualToString:@"多选题"]){
        model.type = @"201";
    }else if ([title isEqualToString:@"判断题"]){
        model.type = @"202";
    }else if ([title isEqualToString:@"文字题"]){
        model.type = @"203";
    }else if ([title isEqualToString:@"图片题"]){
        model.type = @"204";
    }else if ([title isEqualToString:@"动画题"]){
        model.type = @"205";
    }else{
    
    }
}


@end
