//
//  SubjectRegulationViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/5/24.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectRegulationViewController.h"

@interface SubjectRegulationViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIImageView *subeImageView;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) NSString *titleName;

@end

@implementation SubjectRegulationViewController

- (void)setType:(SubjextRegularType)type{
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
//   [self.navigationController setNavigationBarHidden:YES];
    if (_type == SubjextRegularTypeOne) {
        _image = [UIImage imageNamed:@"firstObject.jpg"];
        _titleName = @"科目一考规";
    }else if (_type == SubjextRegularTypeTwo){
        _image = [UIImage imageNamed:@"SecondObject.jpg"];
        _titleName = @"科目二考规";
    }else if (_type == SubjextRegularTypeThree){
        _image = [UIImage imageNamed:@"threeObject.jpg"];
        
        _titleName = @"科目三考规";
    }else if (_type == SubjextRegularTypeForth){
        _image = [UIImage imageNamed:@"ForthObject.jpg"];
        
        _titleName = @"科目四考规";
    }else{
        _image = [UIImage imageNamed:@"ForthObject.jpg"];
    }
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, CURRENT_BOUNDS.height)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator= NO;
    self.scrollView.showsVerticalScrollIndicator= NO;
    _scrollView.contentSize = CGSizeMake(CURRENT_BOUNDS.width, _image.size.height*CURRENT_BOUNDS.width/_image.size.width);
    [self.view addSubview:_scrollView];
    

    _subeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -18, CURRENT_BOUNDS.width, _image.size.height*CURRENT_BOUNDS.width/_image.size.width)];
    _subeImageView.image = _image;
    [_scrollView addSubview:_subeImageView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, 64)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    UIButton *leftBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 20, 40, 44);
    [leftBtn setImage:[UIImage imageNamed:@"btn_back_gray"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnActive:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:leftBtn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    titleLabel.center = CGPointMake(CURRENT_BOUNDS.width/2, 42);
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.text = _titleName;
    titleLabel.textColor = TEXT_COLOR;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:titleLabel];
    // Do any additional setup after loading the view from its nib.
}

- (void)leftBtnActive:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
