//
//  PersonNewViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/6/13.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "PersonNewViewController.h"
#import "SettingViewController.h"
#import "PersonSettingViewController.h"
#import "ChoosedCocchViewController.h"
#import "PersonNewsViewController.h"
#import "PersonIndentViewControllerOther.h"
#import "PersonIndentViewController.h"
#import "IdentifyingViewController.h"
#import "ChoosedPlaceViewController.h"
#import "ChoosecClassViewController.h"
#import "DefaultManager.h"
#import "OrderValidityManager.h"
#import "PersonCenterViewController.h"
#import "SubjectTwoPopWebViewController.h"
#import "LearningViewController.h"
#import "SamailerImgBtn.h"
#import "installment_ViewController.h"
#import "UIImageView+WebCache.h"

@interface settingCustomBtna : UIButton

@end

@implementation settingCustomBtna

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectMake(20, 11, 22, 22);
    
}

@end

@interface PersonNewTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *secondTitleLabel;

@property (nonatomic, strong) NSString *imageStr;

@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) NSString *secondTitle;

@end

@implementation PersonNewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.frame = CGRectMake(16, 0, 26, 26);
        _logoImageView.center = CGPointMake(16+13, 30);
        _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
//        _logoImageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_logoImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_logoImageView.frame)+7, 22, 150, 16)];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = TEXT_COLOR;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
        
        _secondTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width-35-150, 22.5, 150, 15)];
        _secondTitleLabel.font = [UIFont systemFontOfSize:15];
        _secondTitleLabel.textColor = UNMAIN_TEXT_COLOR;
        _secondTitleLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_secondTitleLabel];
    }
    
    return self;
}

- (void)setImageStr:(NSString *)imageStr{
    _logoImageView.image = [UIImage imageNamed:imageStr];
}

- (void)setTitle:(NSString *)title{
    _titleLabel.text = title;
}

- (void)setSecondTitle:(NSString *)secondTitle{
    if ([secondTitle isEqualToString:@"未选择"] || secondTitle == nil) {
        _secondTitleLabel.textColor = FF8400;
        _secondTitleLabel.text = @"未选择";
    }else{
        _secondTitleLabel.textColor = UNMAIN_TEXT_COLOR;
        _secondTitleLabel.text = secondTitle;
    }
    
}


@end

@interface PersonNewViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *imageData;

@property (nonatomic, strong) NSMutableArray *titleData;

@property (nonatomic, strong) UIButton *imageBtn;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *locationLabel;

@property (nonatomic, strong) NSArray *locationData;

@property (nonatomic, strong) NSArray *carStyleData;

@end

@implementation PersonNewViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    if ([UIApplication sharedApplication].statusBarStyle == UIStatusBarStyleLightContent) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Appear"];
  
    [_tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    _locationData = [DefaultManager shareDefaultManager].locationData;
    _carStyleData = [DefaultManager shareDefaultManager].carStyleData;
    // Do any additional setup after loading the view from its nib.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CURRENT_BOUNDS.width*250/375;
    }else
        return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view;
    if (section == 0) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
        
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, CURRENT_BOUNDS.width*250/375)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, CURRENT_BOUNDS.width*250/375-10)];
        imageView.image = [UIImage imageNamed:@"background01"];
        imageView.contentMode = UIViewContentModeScaleToFill;
        [view addSubview:imageView];
        
        UIImageView *logoImageView = [[UIImageView alloc] init];
        logoImageView.frame = CGRectMake(0, 0, 80, 80);
        logoImageView.layer.masksToBounds = YES;
        logoImageView.layer.cornerRadius = 80/2;
        logoImageView.center = CGPointMake(CURRENT_BOUNDS.width/2, 97*TYPERATIONTWO);
        logoImageView.contentMode = UIViewContentModeScaleAspectFill;
        [view addSubview:logoImageView];
        
        _imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageBtn.tag = 1002;
        _imageBtn.frame = CGRectMake(0, 0, 80, 80);
        NSData *image = [dic objectForKey:@"userLogoImage"];
        _imageBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
        if (image && [image isKindOfClass:[NSData class]]) {
//            [_imageBtn setBackgroundImage:[UIImage imageWithData:image] forState:UIControlStateNormal];
            [_imageBtn setImage:[UIImage imageWithData:image] forState:UIControlStateNormal];
            logoImageView.image = [UIImage imageWithData:image];
            
        }else{
//             [_imageBtn setImage:[UIImage imageNamed:@"bg_personal_defaultavatar"] forState:UIControlStateNormal];
            [logoImageView sd_setImageWithURL:[NSURL URLWithString:(NSString *)image] placeholderImage:[UIImage imageNamed:@"bg_personal_defaultavatar"]];
        }
        _imageBtn.center = CGPointMake(CURRENT_BOUNDS.width/2, 97*TYPERATIONTWO);
        [_imageBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        _imageBtn.contentMode = UIViewContentModeScaleAspectFit;
        _imageBtn.layer.masksToBounds = YES;
        _imageBtn.layer.cornerRadius = 80/2;
        [view addSubview:_imageBtn];
        
        _nameLabel = [[UILabel alloc ] initWithFrame:CGRectMake(0, CGRectGetMaxY(_imageBtn.frame)+20*TYPERATIONTWO, CURRENT_BOUNDS.width, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:20];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor whiteColor];
        if ([dic objectForKey:@"userName"] != nil && ((NSString *)[dic objectForKey:@"userName"]).length > 0) {
            _nameLabel.text = [dic objectForKey:@"userName"];
        }else{
            _nameLabel.text = @"未登录";
        }
        
        [view addSubview:_nameLabel];
        
        UIButton *nameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if ([_nameLabel.text isEqualToString:@"未登录"]) {
            nameBtn.userInteractionEnabled = YES;
        }else{
            nameBtn.userInteractionEnabled = NO;
        }
        nameBtn.frame = _nameLabel.frame;
        nameBtn.backgroundColor = [UIColor clearColor];
        nameBtn.tag = 1007;
        [nameBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:nameBtn];
        
        _locationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_nameLabel.frame)+18*TYPERATION, CURRENT_BOUNDS.width, 13)];
        _locationLabel.font = [UIFont systemFontOfSize:13];
        _locationLabel.textAlignment = NSTextAlignmentCenter;
        _locationLabel.textColor = [UIColor whiteColor];
        if ([_nameLabel.text isEqualToString:@"未登录"]) {
            _locationLabel.text = @"未选择";
        }else{
            NSString *str = [dic objectForKey:@"address"];
            if (str.length > 0) {
                _locationLabel.text = str;
            }else{
                _locationLabel.text = @"未选择";
            }
            
        }
        
        _locationLabel.alpha = 0.6;
        [view addSubview:_locationLabel];
        
        SamailerImgBtn *settingBtn = [SamailerImgBtn buttonWithType:UIButtonTypeCustom];
        settingBtn.tag = 1001;
        settingBtn.frame = CGRectMake(CURRENT_BOUNDS.width-16-44, 20, 44, 44);
        [settingBtn setImage:[UIImage imageNamed:@"nav_btn_service"] forState:UIControlStateNormal];
        settingBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [settingBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        //    settingBtn.backgroundColor = [UIColor orangeColor];
        [view addSubview:settingBtn];
    }else{
    
    }
        return view;
}

- (void)btnClick:(UIButton *)btn{
    if (btn.tag == 1001) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"]) {
            SubjectTwoPopWebViewController *v = [[SubjectTwoPopWebViewController alloc] init];
            v.url = @"https://eco-api.meiqia.com/dist/standalone.html?eid=10708";
            v.titleLabel.text = @"在线咨询";
            [self.navigationController pushViewController:v animated:YES];
        }else{
            IdentifyingViewController *v = [[IdentifyingViewController alloc] init];
            [self.navigationController pushViewController:v animated:YES];
        }
        
    }else if (btn.tag == 1002){
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"]) {
            PersonSettingViewController *v = [[PersonSettingViewController alloc] init];
            [self.navigationController pushViewController:v animated:YES];
        }else{
            IdentifyingViewController *v = [[IdentifyingViewController alloc] init];
            [self.navigationController pushViewController:v animated:YES];
        }
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
    }else if (btn.tag == 1007){
        IdentifyingViewController *v = [[IdentifyingViewController alloc] init];
        [self.navigationController pushViewController:v animated:YES];
    }
    NSLog(@"----%ld",(long)btn.tag);
}


- (NSMutableArray *)titleData{
    NSArray *arr1 = @[@"我的班型",@"训练场地",@"我的教练"];
    
    NSArray *arr2 = @[@"学车流程",@"订单管理",@"设置中心"];
    if (!_titleData) {
        _titleData = [[NSMutableArray alloc] init];
        [_titleData addObject:arr1];
        [_titleData addObject:arr2];
    }
    return _titleData;
}

- (NSMutableArray *)imageData{
    NSArray *image1 = @[@"clas",@"place",@"coach"];
    
    NSArray *image2 = @[@"btn_people_process",@"order",@"btn_people_sittinga"];
    if (!_imageData) {
        _imageData = [[NSMutableArray alloc] init];
        [_imageData addObject:image1];
        [_imageData addObject:image2];
    }
    return _imageData;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else
        return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *index = @"indesx";
    PersonNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:index];
    if (!cell) {
        cell = [[PersonNewTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:index];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section == 0) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
        if (indexPath.row == 0) {
            cell.secondTitle = [dic objectForKey:@"myClass"];
        }else if (indexPath.row ==1){
            cell.secondTitle = [dic objectForKey:@"myPlace"];
        }else{
            cell.secondTitle = [dic objectForKey:@"myConsult"];
        }
        
    }else{
        cell.secondTitle = @"";
    }
    
    cell.imageStr = self.imageData[indexPath.section][indexPath.row];
    cell.title = self.titleData[indexPath.section][indexPath.row];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"]) {
                //                PersonNewsViewController *v = [[PersonNewsViewController alloc] init];
                //                [self.navigationController pushViewController:v animated:YES];
                
                LearningViewController *v = [[LearningViewController alloc] init];
                [self.navigationController pushViewController:v animated:YES];
            }else{
                IdentifyingViewController *v = [[IdentifyingViewController alloc] init];
                [self.navigationController pushViewController:v animated:YES];
            }
            
        }else if (indexPath.row == 1){
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"]) {
                NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
                NSString *choosedType = [userDic objectForKey:@"choosedPayType"];
                NSString *payNum = [userDic objectForKey:@"payNum"];
                if ([[[OrderValidityManager defaultManager] getCurrentOrderStyle] isEqualToString:@"订单已完成"]) {
                    //已经完成订单支付
                    
                    if ([choosedType isEqualToString:@"ONLINE"]) {
                        PersonIndentViewControllerOther*v = [[PersonIndentViewControllerOther alloc] init];
                        [self.navigationController pushViewController:v animated:YES];
                    }else{
                        installment_ViewController *v = [[installment_ViewController alloc] init];
                        v.payNum = payNum;
                        [self.navigationController pushViewController:v animated:YES];
                    }
                }else{
                    
                    //订单未完成
                    
                    if ([choosedType isEqualToString:@"INSTALLMENT"]) {
                        installment_ViewController *v = [[installment_ViewController alloc] init];
                        v.payNum = payNum;
                        [self.navigationController pushViewController:v animated:YES];
                        
                    }else{
                        PersonIndentViewController *v = [[PersonIndentViewController alloc] init];
                        [self.navigationController pushViewController:v animated:YES];
                    }
                    
                    
                }
                
                
                
                
            }else{
                IdentifyingViewController *v = [[IdentifyingViewController alloc] init];
                [self.navigationController pushViewController:v animated:YES];
            }
        }
        else{
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"]) {
                
                SettingViewController *v = [[SettingViewController alloc] init];
                [self.navigationController pushViewController:v animated:YES];
            }else{
                IdentifyingViewController *v = [[IdentifyingViewController alloc] init];
                [self.navigationController pushViewController:v animated:YES];
            }
        }
            
        }else{
        if (indexPath.row == 0) {
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"]) {
                ChoosecClassViewController *v = [[ChoosecClassViewController alloc] init];
                [v returnActiveWithBlock:^(ChoosedClassModel *model) {
                    NSLog(@"%@",model.C1Str);
                    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
                    [dic setObject:model.titleStr forKey:@"myClass"];
                    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"personNews"];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [_tableView reloadData];
                    });
                }];
//                [v returnSelectCocchWithBlock:^(NSString *name) {
                
//                }];
                [self.navigationController pushViewController:v animated:YES];
            }else{
                IdentifyingViewController *v = [[IdentifyingViewController alloc] init];
                [self.navigationController pushViewController:v animated:YES];
            }
        }else if (indexPath.row == 1){
            
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"]) {
                if (_locationData.count < 1) {
                    [self showMistake];
                }else{
                    ChoosedPlaceViewController *v = [[ChoosedPlaceViewController alloc] init];
                    v.isByPersonVC = YES;
                    v.allExerciseLocationData = _locationData;
                    [v returnHasChooedExercisePlaceBlock:^(FirstLocationModel *place) {
                        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
                        [dic setObject:place.name forKey:@"myPlace"];
                        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"personNews"];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [_tableView reloadData];
                        });
                        [[OrderValidityManager defaultManager] saveCurrentPlaceID:place.currentId];
                    }];
                    
                    [self.navigationController pushViewController:v animated:YES];
                }
                
            }else{
                IdentifyingViewController *v = [[IdentifyingViewController alloc] init];
                [self.navigationController pushViewController:v animated:YES];
            }
            
        }else{
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"]) {
                
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
                NSString *place = [dic objectForKey:@"myPlace"];
                if (place && place.length > 0) {
                    ChoosedCocchViewController *v = [[ChoosedCocchViewController alloc] init];
                    v.isByPersonVC = YES;
                    [v returnSelectCocchWithBlock:^(NSString *name) {
                        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
                        [dic setObject:name forKey:@"myConsult"];
                        [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"personNews"];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [_tableView reloadData];
                        });
                    }];
                    [self.navigationController pushViewController:v animated:YES];
                }else{
                    if (_locationData.count < 1) {
                        [self showMistake];
                    }else{
                        ChoosedPlaceViewController *v = [[ChoosedPlaceViewController alloc] init];
                        v.isByPersonVC = YES;
                        v.allExerciseLocationData = _locationData;
                        [v returnHasChooedExercisePlaceBlock:^(FirstLocationModel *place) {
                            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
                            [dic setObject:place.name forKey:@"myPlace"];
                            [[NSUserDefaults standardUserDefaults] setObject:dic forKey:@"personNews"];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [_tableView reloadData];
                            });
                            [[OrderValidityManager defaultManager] saveCurrentPlaceID:place.currentId];
                        }];
                        
                        [self.navigationController pushViewController:v animated:YES];
                    }
                }
                
            }else{
                IdentifyingViewController *v = [[IdentifyingViewController alloc] init];
                [self.navigationController pushViewController:v animated:YES];
            }
        }
    }
}

- (void)showMistake{
    UIAlertController *v = [UIAlertController alertControllerWithTitle:@"提示" message:@"服务器异常！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [v addAction:active];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:v animated:YES completion:^{
            
        }];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
