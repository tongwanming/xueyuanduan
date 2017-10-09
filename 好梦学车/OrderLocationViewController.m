//
//  OrderLocationViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/4/26.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "OrderLocationViewController.h"

@interface OrderLocationViewController ()

@end

@implementation OrderLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)btnClick:(id)sender {
    UIButton *btn = sender;
    if (btn.tag == 1001) {
        //复制按钮
        NSLog(@"复制按钮");
    }else if (btn.tag == 1002){
        //查看进度按钮
        NSLog(@"查看进度按钮");
    }else if (btn.tag == 1003){
        //完成按钮
        NSLog(@"完成按钮");
    }else{
    
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
