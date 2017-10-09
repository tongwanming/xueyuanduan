//
//  OnlineConsultViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/4/25.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "OnlineConsultViewController.h"

@interface OnlineConsultViewController ()

@end

@implementation OnlineConsultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"在线咨询";
    
    self.navigationItem.hidesBackButton = YES;
    UIButton *letBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [letBtn setImage:[UIImage imageNamed:@"btn_back_gray"] forState:UIControlStateNormal];
    letBtn.contentMode = UIViewContentModeScaleAspectFit;
    //    letBtn.backgroundColor = [UIColor redColor];
    [letBtn addTarget:self action:@selector(leftBarButtonActive:) forControlEvents:UIControlEventTouchUpInside];
    letBtn.frame = CGRectMake(0, 0, 40, 40);
    [letBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:letBtn];
    //    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnActive:)];

    self.navigationItem.leftBarButtonItem = leftBtn;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)leftBarButtonActive:(id)leftBtn{
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
