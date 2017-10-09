//
//  NaturalizationViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/7/10.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "NaturalizationViewController.h"

@interface NaturalizationViewController ()

@end

@implementation NaturalizationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)btnlick:(id)sender {
    UIButton *btn = sender;
    if (btn.tag == 1001) {
        //完成按钮
    }else{
        //选择服务站地址
    
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
