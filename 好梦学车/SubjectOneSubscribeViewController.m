
//
//  SubjectOneSubscribeViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/5/12.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectOneSubscribeViewController.h"

@interface SubjectOneSubscribeViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *subeImageView;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) NSString *titleName;

@end

@implementation SubjectOneSubscribeViewController

- (void)setType:(SubjectOneSubscribeType)type{
    _type = type;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_type == SubjectOneSubscribeTypeOne) {
        _image = [UIImage imageNamed:@"ordering.jpg"];
        _titleName = @"科目一预约考试";
    }else if (_type == SubjectOneSubscribeTypeTwo){
        _image = [UIImage imageNamed:@"ordering.jpg"];
        _titleName = @"科目二预约考试";
    }else if (_type == SubjectOneSubscribeTypeThree){
        _image = [UIImage imageNamed:@"ordering.jpg"];
        
        _titleName = @"科目三预约考试";
    }else if (_type == SubjectOneSubscribeTypeForth){
        _image = [UIImage imageNamed:@"ordering.jpg"];
        
        _titleName = @"科目四预约考试";
    }else{
        _image = [UIImage imageNamed:@"ordering.jpg"];
    }
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, CURRENT_BOUNDS.width, CURRENT_BOUNDS.height-64)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator= NO;
    self.scrollView.showsVerticalScrollIndicator= NO;
    _scrollView.contentSize = CGSizeMake(CURRENT_BOUNDS.width, _image.size.height*CURRENT_BOUNDS.width/_image.size.width+60);
    [self.view addSubview:_scrollView];
    
    
    _subeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, _image.size.height*CURRENT_BOUNDS.width/_image.size.width)];
    _subeImageView.image = _image;
    [_scrollView addSubview:_subeImageView];
    
    UIButton *bottonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bottonBtn.frame = CGRectMake(0, CGRectGetMaxY(_subeImageView.frame), CURRENT_BOUNDS.width, 60);
    [bottonBtn setTitle:@"预约考试" forState:UIControlStateNormal];
    bottonBtn.titleLabel.textColor = [UIColor whiteColor];
    bottonBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    bottonBtn.backgroundColor = BLUE_BACKGROUND_COLOR;
    [bottonBtn addTarget:self action:@selector(bottonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:bottonBtn];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    UIButton *leftBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 20, 40, 44);
    [leftBtn setImage:[UIImage imageNamed:@"btn_back_gray"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnActive:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:leftBtn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    titleLabel.center = CGPointMake(CURRENT_BOUNDS.width/2, 42);
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.text = _titleName;
    titleLabel.textColor = TEXT_COLOR;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:titleLabel];
    // Do any additional setup after loading the view from its nib.
}

- (void)bottonBtnClick:(UIButton *)btn{
//    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    NSString *str = @"https://cq.122.gov.cn";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:^(BOOL success) {
        
    }];
    
 
    NSLog(@"跳转界面");
}

- (void)leftBtnActive:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
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
