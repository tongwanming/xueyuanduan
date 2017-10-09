//
//  ExerciseViewController.m
//  haomengxueche
//
//  Created by haomeng on 2017/4/18.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "ExerciseViewController.h"
#import "MyExerciseScrollView.h"
#import "PersonCenterViewController.h"
//科目一
#import "SubjectOneViewController.h"
#import "SubjectOneBasicViewController.h"
#import "SubjectPractiseViewController.h"
#import "SubjectOneExamViewController.h"
#import "SubjectOneSpecialProjectViewController.h"
#import "SubjectOneAnalysisViewController.h"
#import "SubjectOneSubscribeViewController.h"
#import "SubjectMyMistakesViewController.h"
#import "SubjectOneCollectViewController.h"
#import "SubjectOneCheatsViewController.h"
#import "SubjectOneTrafficSignViewController.h"
#import "SubjectOneRegulationsViewController.h"
#import "SamailerImgBtn.h"
#import "SubjectRecordViewController.h"
//科目二
#import "SubjectTwoViewController.h"
#import "SubjectTwoPopWebViewController.h"
//科目三
#import "SubjectThreeViewController.h"
//科目四
#import "SubjectForthViewController.h"
//考规
#import "SubjectRegulationViewController.h"
//单项解析
#import "SubjectSingleAnalyzeViewController.h"


@interface ExerciseViewController ()<MyExerciseScrollViewDelegate,SubjectOneViewControllerDelegate,SubjectTwoViewControllerDelegate,SubjectForthViewControllerDelegate,SubjectThreeViewControllerDelegate>

@end

@implementation ExerciseViewController{
    MyExerciseScrollView *myScrollView;
    NSMutableArray *_VCData;
    NSArray *_projectTwoName;
    NSArray *_projectTwoImgUrl;
    NSArray *_projectThreeName;
    NSArray *_projectThreeImgUrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _projectTwoName = @[@"倒车入库",@"陡坡起步",@"侧方位停车",@"直角转弯",@"曲线行驶"];
    _projectTwoImgUrl = @[@"http://ovfnytdqk.bkt.clouddn.com/o_2acbqv5379791c7u02qb137a1tab1.mp4",
                          @"http://ovfnytdqk.bkt.clouddn.com/o_2acbqv5379791c7u04qb137a1tab1.mp4",
                          @"http://ovfnytdqk.bkt.clouddn.com/o_2acbqv5379791c7u01qb137a1tab1.mp4",
                          @"http://ovfnytdqk.bkt.clouddn.com/o_2acbqv5379791c7u09qb137a1tab1.mp4",
                          @"http://ovfnytdqk.bkt.clouddn.com/o_2acbqv5379791c7u06qb137a1tab1.mp4"
                          ];
    _projectThreeName = @[@"夜光灯使用",@"上车准备",@"起步",@"直线行驶",@"变更车道",@"加减档操作",@"掉头",@"超车",@"靠边停车",@"通过人行横道",@"通过学校区域",@"通过公交车站",@"夜间行驶",@"路考全程"];
    _projectThreeImgUrl = @[@"http://ovfnytdqk.bkt.clouddn.com/o_2acbqv5379791c7u21qb137a1tab1.mp4",
                            @"http://ovfnytdqk.bkt.clouddn.com/o_2acbqv5379791c7u18qb137a1tab1.mp4",
                            @"http://ovfnytdqk.bkt.clouddn.com/o_2acbqv5379791c7u10qb137a1tab1.mp4",
                            @"http://ovfnytdqk.bkt.clouddn.com/o_2acbqv5379791c7u07qb137a1tab1.mp4",
                            @"http://ovfnytdqk.bkt.clouddn.com/o_2acbqv5379791c7u03qb137a1tab1.mp4",
                            @"http://ovfnytdqk.bkt.clouddn.com/o_2acbqv5379791c7u20qb137a1tab1.mp4",
                            @"http://ovfnytdqk.bkt.clouddn.com/o_2acbqv5379791c7u05qb137a1tab1.mp4",
                            @"http://ovfnytdqk.bkt.clouddn.com/o_2acbqv5379791c7u11qb137a1tab1.mp4",
                            @"http://ovfnytdqk.bkt.clouddn.com/o_2acbqv5379791c7u17qb137a1tab1.mp4",
                            @"http://ovfnytdqk.bkt.clouddn.com/o_2acbqv5379791c7u14qb137a1tab1.mp4",
                            @"http://ovfnytdqk.bkt.clouddn.com/o_2acbqv5379791c7u16qb137a1tab1.mp4",
                            @"http://ovfnytdqk.bkt.clouddn.com/o_2acbqv5379791c7u15qb137a1tab1.mp4",
                            @"http://ovfnytdqk.bkt.clouddn.com/o_2acbqv5379791c7u21qb137a1tab1.mp4",
                            @"路考全程"];
    
    _VCData = [[NSMutableArray alloc] init];
    //设置时间栏字体的颜色
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    [self setNeedsStatusBarAppearanceUpdate];
    
    //设置时间栏背景的颜色
    UIView* stateView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, CURRENT_BOUNDS.width, 20)];
    [self.navigationController.navigationBar addSubview:stateView];
    stateView.backgroundColor = BLUE_BACKGROUND_COLOR;
    //设置导航栏的颜色
    self.navigationController.navigationBar.backgroundColor = BLUE_BACKGROUND_COLOR;
    self.navigationController.navigationBar.barTintColor = BLUE_BACKGROUND_COLOR;
    //设置导航栏为不透明
    self.navigationController.navigationBar.translucent = NO;
    //隐藏导航栏的分割线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
  
   //添加导航栏上面的内容
    NSMutableArray *array=[NSMutableArray array];//显示的标签页
    myScrollView = [[MyExerciseScrollView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width-50, 44) titleArray:@[@"科目一",@"科目二",@"科目三",@"科目四"] viewArray:array];
    myScrollView.delegate = self;
    myScrollView.backgroundColor = [UIColor clearColor];
     self.navigationItem.titleView = myScrollView;
    
    SamailerImgBtn *rightBtn = [SamailerImgBtn buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"nav_btn_service"] forState:UIControlStateNormal];
//    rightBtn.backgroundColor = [UIColor redColor];
    [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(0, 0, 50*TYPERATION, 50*TYPERATION);
    UIBarButtonItem *rightBtna = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBtna;
    
//    self.view.backgroundColor = BLUE_BACKGROUND_COLOR;
    
    SubjectOneViewController *v1 = [[SubjectOneViewController alloc] init];
    v1.delegate = self;
    [self addChildViewController:v1];
    
    SubjectTwoViewController *v2 = [[SubjectTwoViewController alloc] init];
    v2.delegete = self;
    [self addChildViewController:v2];
    
    SubjectThreeViewController *v3 = [[SubjectThreeViewController alloc] init];
    v3.delegate = self;
    [self addChildViewController:v3];
    
    SubjectForthViewController *v4 = [[SubjectForthViewController alloc] init];
    v4.delegate = self;
    [self addChildViewController:v4];
    
    [_VCData addObject:v1];
    [_VCData addObject:v2];
    [_VCData addObject:v3];
    [_VCData addObject:v4];
    [self.subView addSubview:v1.view];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightBtnClick:(UIButton *)btn{
    SubjectTwoPopWebViewController *v = [[SubjectTwoPopWebViewController alloc] init];
    v.url = @"https://eco-api.meiqia.com/dist/standalone.html?eid=10708";
    v.titleStr = @"在线咨询";
    [self.navigationController pushViewController:v animated:YES];
}

#pragma mark - myScrollViewDelegate

- (void)myScrollViewBtnClickWithIndex:(NSString *)index{
    UIViewController *v = _VCData[[index intValue]-1];
    for (UIView *view in self.subView.subviews) {
        [view removeFromSuperview];
    }
    v.view.frame = self.subView.frame;
    [self.subView addSubview:v.view];
}

#pragma mark - CVTapDelegate

//科目一
- (void)subjectOneViewControllerTapWithIndex:(NSString *)index{
    int n = [index intValue];
    SubjectOneBasicViewController *v;
    if (n == 0) {
        v = [[SubjectMyMistakesViewController alloc] init];
        ((SubjectMyMistakesViewController *)v).type = PractiseViewControllerTypeOneMistake;
    }else if (n == 1){
        v = [[SubjectPractiseViewController alloc] init];
        ((SubjectPractiseViewController *)v).practiseType = PractiseViewControllerTypeOneCollection;
    }else if (n == 2){
        v = [[SubjectOneCheatsViewController alloc] init];
        ((SubjectOneCheatsViewController *)v).titleStr = @"科目一必过秘籍";
        ((SubjectOneCheatsViewController *)v).type = @"K1";
    }else if (n == 3){
        v = [[SubjectOneTrafficSignViewController alloc] init];
    }else if (n == 4){
        v = (SubjectOneBasicViewController *)[[SubjectRegulationViewController alloc] init];
        ((SubjectRegulationViewController *)v).type = SubjextRegularTypeOne;
    }else if (n == 1001){
        v = [[SubjectPractiseViewController alloc] init];
        ((SubjectPractiseViewController *)v).type = @"order";
        ((SubjectPractiseViewController *)v).practiseType = PractiseViewControllerTypeOne;
    }else if (n == 1002){
        v = [[SubjectOneExamViewController alloc] init];
        ((SubjectOneExamViewController *)v).examType = ExamViewControllerTypeOne;
    }else if (n == 1003){
        v = [[SubjectPractiseViewController alloc] init];
        ((SubjectPractiseViewController *)v).type = @"noOrder";
        ((SubjectPractiseViewController *)v).practiseType = PractiseViewControllerTypeOne;
    }else if (n == 1004){
        v = [[SubjectOneSpecialProjectViewController alloc] init];
        ((SubjectOneSpecialProjectViewController *)v).type = @"1";
    }else if (n == 1005){
        v = [[SubjectRecordViewController alloc] init];
        ((SubjectRecordViewController *)v).course = @"1";
    }else if (n == 1006){
        v = [[SubjectOneSubscribeViewController alloc] init];
    }else{
        NSLog(@"不存在部分 ");
    }
    [self.navigationController pushViewController:v animated:YES];
    NSLog(@"点击按钮的编号%@",index);
}

// 科目二
- (void)subjectTwoViewControllerDelegateTapWithIndex:(NSString *)index{

    if ([index isEqualToString:@"1003"]) {
        //科目考规
        SubjectRegulationViewController *v = [[SubjectRegulationViewController alloc] init];
        v.type = SubjextRegularTypeTwo;
        [self.navigationController pushViewController:v animated:YES];
    }else if ([index isEqualToString:@"1001"]){
        //必过秘籍
        SubjectOneCheatsViewController *v = [[SubjectOneCheatsViewController alloc] init];
        ((SubjectOneCheatsViewController *)v).titleStr = @"科目二必过秘籍";
        ((SubjectOneCheatsViewController *)v).type = @"K2";
        [self.navigationController pushViewController:v animated:YES];
    }
    else if ([index isEqualToString:@"1002"]){
        SubjectSingleAnalyzeViewController *v = [[SubjectSingleAnalyzeViewController alloc ]init];
        v.type = SubjectSingleAnalyzeViewTypeTwo;
        v.titleLabel.text = @"单项解析";
        [self.navigationController pushViewController:v animated:YES];
       
    }
    else if ([index isEqualToString:@"1004"]){
        //我的收藏
      SubjectPractiseViewController *v = [[SubjectPractiseViewController alloc] init];
        v.practiseType = PractiseViewControllerTypeTwoCollection;
        [self.navigationController pushViewController:v animated:YES];
    }else{
        //collection的点击cell
        SubjectTwoPopWebViewController *v = [[SubjectTwoPopWebViewController alloc] init];
        v.titleStr = _projectTwoName[[index intValue]];
        v.url = _projectTwoImgUrl[[index intValue]];
        [self.navigationController pushViewController:v animated:YES];
        
        NSLog(@"点击按钮的编号%@",index);
    }
}

// 科目三
- (void)SubjectThreeViewControllerDelegateTapWithIndex:(NSString *)index{
    if ([index isEqualToString:@"1003"]) {
        SubjectRegulationViewController *v = [[SubjectRegulationViewController alloc] init];
        v.type = SubjextRegularTypeThree;
        [self.navigationController pushViewController:v animated:YES];
    }else if ([index isEqualToString:@"1001"]){
        //必过秘籍
        SubjectOneCheatsViewController *v = [[SubjectOneCheatsViewController alloc] init];
        ((SubjectOneCheatsViewController *)v).titleStr = @"科目三必过秘籍";
        ((SubjectOneCheatsViewController *)v).type = @"K3";
        [self.navigationController pushViewController:v animated:YES];
    }
    else if ([index isEqualToString:@"1002"]){
        SubjectSingleAnalyzeViewController *v = [[SubjectSingleAnalyzeViewController alloc ]init];
        v.type = SubjectSingleAnalyzeViewTypeThree;
        v.titleLabel.text = @"单项解析";
        [self.navigationController pushViewController:v animated:YES];
      
    }
    else if ([index isEqualToString:@"1004"]){
        //我的收藏
        SubjectPractiseViewController *v = [[SubjectPractiseViewController alloc] init];
        v.practiseType = PractiseViewControllerTypeThreeCollection;
        [self.navigationController pushViewController:v animated:YES];
    }else{
        SubjectTwoPopWebViewController *v = [[SubjectTwoPopWebViewController alloc] init];
        v.titleStr = _projectThreeName[[index intValue]];
        v.url = _projectThreeImgUrl[[index intValue]];
        [self.navigationController pushViewController:v animated:YES];
        
        NSLog(@"点击按钮的编号%@",index);
    }
    
}


//科目四
- (void)subjectForthViewControllerTapWithIndex:(NSString *)index{
    int n = [index intValue];
    SubjectOneBasicViewController *v;
    if (n == 0) {
        v = [[SubjectMyMistakesViewController alloc] init];
        ((SubjectMyMistakesViewController *)v).type = PractiseViewControllerTypeForthMistake;
    }else if (n == 1){
        v = [[SubjectPractiseViewController alloc] init];
        ((SubjectPractiseViewController *)v).practiseType = PractiseViewControllerTypeForthCollection;
    }else if (n == 2){
        v = [[SubjectOneCheatsViewController alloc] init];
        ((SubjectOneCheatsViewController *)v).type = @"K1";
        ((SubjectOneCheatsViewController *)v).titleStr = @"科目四必过秘籍";
    }else if (n == 3){
        v = [[SubjectOneTrafficSignViewController alloc] init];
    }else if (n == 4){
        v = (SubjectOneBasicViewController *)[[SubjectRegulationViewController alloc] init];
        ((SubjectRegulationViewController *)v).type = SubjextRegularTypeForth;
    }else if (n == 1001){
        v = [[SubjectPractiseViewController alloc] init];
        ((SubjectPractiseViewController *)v).type = @"order";
        ((SubjectPractiseViewController *)v).practiseType = PractiseViewControllerTypeForth;
    }else if (n == 1002){
        v = [[SubjectOneExamViewController alloc] init];
        ((SubjectOneExamViewController *)v).examType = ExamViewControllerTypeTwo;
    }else if (n == 1003){
        v = [[SubjectPractiseViewController alloc] init];
        ((SubjectPractiseViewController *)v).type = @"noOrder";
        ((SubjectPractiseViewController *)v).practiseType = PractiseViewControllerTypeForth;
    }else if (n == 1004){
        v = [[SubjectOneSpecialProjectViewController alloc] init];
        ((SubjectOneSpecialProjectViewController *)v).type = @"4";
    }else if (n == 1005){
        v = [[SubjectRecordViewController alloc] init];
        ((SubjectRecordViewController *)v).course = @"4";
    }else if (n == 1006){
        v = [[SubjectOneSubscribeViewController alloc] init];
        ((SubjectOneSubscribeViewController *)v).type = SubjectOneSubscribeTypeForth;
    }else{
        NSLog(@"不存在部分 ");
    }
    [self.navigationController pushViewController:v animated:YES];
    NSLog(@"点击按钮的编号%@",index);
   
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Appear"];
    if (self.navigationController.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    if ([UIApplication sharedApplication].statusBarStyle == UIStatusBarStyleLightContent) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Disappear"];
    if (!self.navigationController.navigationBarHidden) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

@end
