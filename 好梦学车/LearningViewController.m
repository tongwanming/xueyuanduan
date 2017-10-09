//
//  LearningViewController.m
//  haomengxueche
//
//  Created by haomeng on 2017/4/18.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "LearningViewController.h"

#import "LearningProgressTopView.h"

#import "LearningProgressViewController.h"

#import "LearningProgressOneViewController.h"

#import "LearningProgressTwoViewController.h"

#import "LearningProgressThreeViewController.h"

#import "LearningGraduateViewController.h"

#import "MyLearnScrollView.h"

#import "PersonCenterViewController.h"

#import "SubjectTwoPopWebViewController.h"

@interface LearningViewController ()<LearningProgressTopViewDelegate,LearningProgressViewControllerDelegate,LearningProgressOneViewControllerDelegate,LearningProgressTwoViewControllerDelegate,LearningProgressThreeViewControllerDelegate,LearningGraduateViewControllerDelegate,MyLearnScrollViewDelegate>

@end

@implementation LearningViewController{
    NSMutableArray *_VCData;
    LearningProgressTopView *_topView;
    MyLearnScrollView *myScrollView;
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
    }else{
    
    }
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Disappear"];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Appear"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    

    _VCData = [[NSMutableArray alloc] init];
//
//    _topView = [[LearningProgressTopView alloc] initWithFrame:CGRectMake(0, 75, CURRENT_BOUNDS.width, 34)];
//    [_topView setCurrentChoosed:0];
//    _topView.delegate = self;
//    [self.view addSubview:_topView];
    
    NSMutableArray *array=[NSMutableArray array];//显示的标签页
    myScrollView = [[MyLearnScrollView alloc] initWithFrame:CGRectMake(0, 70, CURRENT_BOUNDS.width, 44) titleArray:@[@"报名",@"科一",@"科二",@"科三",@"领证"] viewArray:array];
    myScrollView.delegate = self;
    myScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:myScrollView];
    
    
    LearningProgressViewController *v1 = [[LearningProgressViewController alloc] init];
    v1.delegate = self;
    [self addChildViewController:v1];
    
    LearningProgressOneViewController *v2 = [[LearningProgressOneViewController alloc] init];
    v2.delegate = self;
    [self addChildViewController:v2];
    
    LearningProgressTwoViewController *v3 = [[LearningProgressTwoViewController alloc] init];
    v3.delegate = self;
    [self addChildViewController:v3];
    
    LearningProgressThreeViewController *v4 = [[LearningProgressThreeViewController alloc] init];
    v4.delegate = self;
    [self addChildViewController:v4];
    
    LearningGraduateViewController *v5 = [[LearningGraduateViewController alloc] init];
    v5.delegate = self;
    [self addChildViewController:v5];
    
    [_VCData addObject:v1];
    [_VCData addObject:v2];
    [_VCData addObject:v3];
    [_VCData addObject:v4];
    [_VCData addObject:v5];
    
    [self.banckGroundBottomView addSubview:v1.view];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - myScrollViewDelegate

- (void)myLearnScrollViewBtnClickWithIndex:(NSString *)index{
    UIViewController *v = _VCData[[index intValue]-1];
    for (UIView *view in self.banckGroundBottomView.subviews) {
        [view removeFromSuperview];
    }
    v.view.frame = CGRectMake(0, 0, CURRENT_BOUNDS.width, self.banckGroundBottomView.frame.size.height);
    [self.banckGroundBottomView addSubview:v.view];
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
