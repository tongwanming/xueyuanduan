//
//  PersonViewController.m
//  haomengxueche
//
//  Created by haomeng on 2017/4/18.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "PersonViewController.h"
#import "personShowBtn.h"
#import "personShowControl.h"
#import "SettingViewController.h"
#import "PersonSettingViewController.h"
#import "ChoosedCocchViewController.h"
#import "ChoosedPlaceViewController.h"
#import "PersonIndentViewController.h"
#import "PersonIndentViewControllerOther.h"
#import "PersonIndentModel.h"
#import "PersonNewsViewController.h"

@interface settingCustomBtn : UIButton

@end

@implementation settingCustomBtn

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(20, 11, 22, 22);

}

@end

@interface btnMdole : NSObject

@property (nonatomic, strong) NSString *imageName;

@property (nonatomic, strong) NSString *titleName;

@property (nonatomic, strong) NSString *titleName2;

@end

@implementation btnMdole



@end

@interface PersonViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableArray *btnData;

@property (nonatomic, strong) NSMutableArray *controlsData;

@end

@implementation PersonViewController{
    UIButton *_imageBtn;
    UILabel *_nameLabel;
    UILabel *_locationLabel;
    
    
}

- (NSMutableArray *)btnData{
    if (!_btnData) {
        _btnData = [[NSMutableArray alloc] init];
        NSArray *imageData = @[@"btn_car",@"brn_-coach",@"btn_possition"];
        NSArray *titleData = @[@"4人1车",@"教练未选择",@"场地未选择"];
        
        for (int i = 0; i < 3; i++) {
            btnMdole *model = [[btnMdole alloc] init];
            model.imageName = imageData[i];
            model.titleName = titleData[i];
            [_btnData addObject:model];
        }
        
    }
    return _btnData;
}

- (NSMutableArray *)controlsData{
    if (!_controlsData) {
        _controlsData = [[NSMutableArray alloc] init];
        NSArray *imageData = @[@"icon_message",@"icon_order",@"icon_-evaluate",@"icon_plan"];
        NSArray *titleData = @[@"消息中心",@"订单",@"评价管理",@"学习计划"];
        NSArray *titleData2 = @[@"一条未读系统消息",@"查看我的订单",@"我对教练的评价",@"定制我的专属计划"];
        
        for (int i = 0; i < 4; i++) {
            btnMdole *modle = [[btnMdole alloc] init];
            modle.imageName = imageData[i];
            modle.titleName = titleData[i];
            modle.titleName2 = titleData2[i];
            [_controlsData addObject:modle];

        }
    }
    
    return _controlsData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, CURRENT_BOUNDS.height-64-54)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator= NO;
    self.scrollView.showsVerticalScrollIndicator= NO;
    _scrollView.contentSize = CGSizeMake(CURRENT_BOUNDS.width, 558.5);
//    _scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_scrollView];
    
    
    settingCustomBtn *settingBtn = [settingCustomBtn buttonWithType:UIButtonTypeCustom];
    settingBtn.tag = 1001;
    settingBtn.frame = CGRectMake(CURRENT_BOUNDS.width-16-44, 0, 44, 44);
    [settingBtn setImage:[UIImage imageNamed:@"btn_sitting"] forState:UIControlStateNormal];
    settingBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [settingBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    settingBtn.backgroundColor = [UIColor orangeColor];
    [self.scrollView addSubview:settingBtn];
    
    _imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _imageBtn.tag = 1002;
    _imageBtn.frame = CGRectMake(0, 0, 80, 80);
    [_imageBtn setBackgroundImage:[UIImage imageNamed:@"bg_personal_defaultavatar"] forState:UIControlStateNormal];
    _imageBtn.center = CGPointMake(CURRENT_BOUNDS.width/2, 70);
    [_imageBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _imageBtn.layer.masksToBounds = YES;
    _imageBtn.layer.cornerRadius = 40;
    [self.scrollView addSubview:_imageBtn];
    
    _nameLabel = [[UILabel alloc ] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageBtn.frame)+23, CURRENT_BOUNDS.width, 28)];
    _nameLabel.font = [UIFont systemFontOfSize:28];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = TEXT_COLOR;
    _nameLabel.text = @"张晓晗";
    [self.scrollView addSubview:_nameLabel];
    
    _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_nameLabel.frame)+11, CURRENT_BOUNDS.width, 14)];
    _locationLabel.font = [UIFont systemFontOfSize:14];
    _locationLabel.textAlignment = NSTextAlignmentCenter;
    _locationLabel.textColor = ADB1B9;
    _locationLabel.text = @"重庆市渝北";
    [self.scrollView addSubview:_locationLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_locationLabel.frame)+40, CURRENT_BOUNDS.width, 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
    [self.scrollView addSubview:lineView];
    
    for (int i = 0; i < 3; i++) {
        
        personShowBtn *btn = [personShowBtn buttonWithType:UIButtonTypeCustom];
        btn.tag = 1003+i;
        btn.frame = CGRectMake(i*CURRENT_BOUNDS.width/3, CGRectGetMaxY(_locationLabel.frame)+40, CURRENT_BOUNDS.width/3, 112.5);
        [btn setImage:[UIImage imageNamed:((btnMdole *)self.btnData[i]).imageName] forState:UIControlStateNormal];
        [btn setTitle:((btnMdole *)self.btnData[i]).titleName forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.textColor = FF8400;
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.scrollView addSubview:btn];
    }
    
    UIView *bottonView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_locationLabel.frame)+40+112.5, CURRENT_BOUNDS.width, 10)];
    bottonView.backgroundColor = [UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
    [self.scrollView addSubview:bottonView];
    
    for (int i = 0; i<2; i++) {
        
        personShowControl *btn = [[personShowControl alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width/2*(i%2), CGRectGetMaxY(bottonView.frame)+100*(i/2), CURRENT_BOUNDS.width/2, 100) andImageStr:((btnMdole *)self.controlsData[i]).imageName andTitle1:((btnMdole *)self.controlsData[i]).titleName andTitle2:((btnMdole *)self.controlsData[i]).titleName2];
        btn.tag = 1005+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
    }
    
//    UIView *bottonView1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(bottonView.frame)+100, CURRENT_BOUNDS.width, 0.5)];
//    bottonView1.backgroundColor = ADB1B9;
//    [self.scrollView addSubview:bottonView1];
    
//    UIView *bottonView2 = [[UIView alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width/2, CGRectGetMaxY(bottonView.frame)+120, 0.5, 60)];
//    bottonView2.backgroundColor = ADB1B9;
//    [self.scrollView addSubview:bottonView2];
    
    UIView *bottonView3 = [[UIView alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width/2, CGRectGetMaxY(bottonView.frame)+ 20, 0.5, 60)];
    bottonView3.backgroundColor = ADB1B9;
    [self.scrollView addSubview:bottonView3];
    // Do any additional setup after loading the view from its nib.
}

- (void)btnClick:(UIButton *)btn{
    if (btn.tag == 1001) {
        SettingViewController *v = [[SettingViewController alloc] init];
        [self.navigationController pushViewController:v animated:YES];
    }else if (btn.tag == 1002){
        PersonSettingViewController *v = [[PersonSettingViewController alloc] init];
        [self.navigationController pushViewController:v animated:YES];
    }else if (btn.tag == 1004){
        ChoosedCocchViewController *v = [[ChoosedCocchViewController alloc] init];
        [self.navigationController pushViewController:v animated:YES];
    }else if (btn.tag == 1005){
        PersonNewsViewController *v = [[PersonNewsViewController alloc] init];
        [self.navigationController pushViewController:v animated:YES];
    }else if (btn.tag == 1006){
//        PersonIndentViewController *v = [[PersonIndentViewController alloc] init];
//        PersonIndentModel *model = [[PersonIndentModel alloc] init];
//        v.model = model;
//        model.name = @"C1手动挡驾驶培训";
//        model.type = @"一价全包班";
//        model.price = @"3,990";
//        model.urlName = @"order_pic_vip";
//        model.bigTitle = @"等待付款中...";
//        model.desribeStr = @"剩余2小时23分钟订单将会自动关闭，请及时支付";
//        model.data = @[@"张晓晗",@"牛角沱训练场地",@"C1手动挡",@"张教练"];
//        model.indentNum = @"20170605e7wr89wwer9e";
//        model.createTimeStr = @"2017-05-21 12:22:24";
//        [self.navigationController pushViewController:v animated:YES];
        
        
        
        PersonIndentViewControllerOther*v = [[PersonIndentViewControllerOther alloc] init];
        PersonIndentModel *model = [[PersonIndentModel alloc] init];
        v.model = model;
        model.name = @"C1手动挡驾驶培训";
        model.type = @"一价全包班";
        model.price = @"3,990";
        model.urlName = @"order_pic_vip";
        model.bigTitle = @"等待付款中...";
        model.desribeStr = @"剩余2小时23分钟订单将会自动关闭，请及时支付";
        model.data = @[@"张晓晗",@"牛角沱训练场地",@"C1手动挡",@"张教练"];
        model.indentNum = @"20170605e7wr89wwer9e";
        model.createTimeStr = @"2017-05-21 12:22:24";
        [self.navigationController pushViewController:v animated:YES];
    }
    NSLog(@"----%ld",(long)btn.tag);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Appear"];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Disappear"];
}

@end
