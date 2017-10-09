//
//  ChoosedCocchViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/4/27.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "ChoosedCocchViewController.h"

#import "ChoosedCocchModel.h"
#import "TopSubView.h"
#import "StartGradeView.h"
#import "MyScrollView.h"
#import "EvaluateTableViewCell.h"
#import "EvaluateModel.h"
#import "ApplyOrderViewController.h"
#import "FirstCatStyleModel.h"
#import "CustomAlertView.h"
#import "ChoosedClassModel.h"
#import "DefaultManager.h"
#import "PersonIndentViewController.h"
#import "OrderValidityManager.h"
#import "PersonIndentViewControllerOther.h"
#import "IPricePopView.h"
#import "OrderValidityManager.h"

@interface ChoosedCocchViewController ()<UITableViewDelegate,UITableViewDataSource,MyScrollViewDelegate,TopSubViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) FirstCatStyleModel *model;

@end

@implementation ChoosedCocchViewController{
    MyScrollView *myScrollView;
    NSMutableArray *_coachData;
    StartGradeView *_startView;
    NSMutableArray *_bottomEvaluateData;
    NSMutableDictionary *_cellData;
}

- (UIImage *) imageWithFrame:(CGRect)frame alphe:(CGFloat)alphe {
    frame = CGRectMake(0, 0, frame.size.width, 1);
    UIColor *redColor = BLUE_BACKGROUND_COLOR;
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [redColor CGColor]);
    CGContextFillRect(context, frame);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    UIImage *image = [self imageWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44) alphe:0];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:image];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Disappear"];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Appear"];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _cellData = [[NSMutableDictionary alloc] init];
    
    _coachData = [[NSMutableArray alloc] init];
    _bottomEvaluateData = [[NSMutableArray alloc] init];
    
    
    self.title = @"选择教练";
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:18]};
    
//    self.navigationItem.hidesBackButton = YES;
//    self.view.backgroundColor = BLUE_BACKGROUND_COLOR;
    UIButton *letBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [letBtn setImage:[UIImage imageNamed:@"btn_back_white"] forState:UIControlStateNormal];
    letBtn.contentMode = UIViewContentModeScaleAspectFit;
    //    letBtn.backgroundColor = [UIColor redColor];
    [letBtn addTarget:self action:@selector(leftBtnActive:) forControlEvents:UIControlEventTouchUpInside];
    letBtn.frame = CGRectMake(0, 0, 40, 40);
    [letBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:letBtn];
    
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    
    UIButton *righBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [righBtn setTitle:@"以后再说" forState:UIControlStateNormal];
    righBtn.contentMode = UIViewContentModeScaleAspectFit;
    //    letBtn.backgroundColor = [UIColor redColor];
    [righBtn addTarget:self action:@selector(rightBtnActive:) forControlEvents:UIControlEventTouchUpInside];
    righBtn.frame = CGRectMake(0, 0, 80, 40);
    righBtn.hidden = YES;
//    [righBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    
    righBtn.titleLabel.font = [UIFont systemFontOfSize:18];
//    righBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:righBtn];
    
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.hidden = YES;
    [self getDataActive];
}

- (void)getDataWithIndex:(NSInteger)index{
    if (_bottomEvaluateData.count > 0) {
        [_bottomEvaluateData removeAllObjects];
    }
    for (NSDictionary *dic in ((ChoosedCocchModel *)(_coachData[index])).comentList) {
        
        EvaluateModel *model = [[EvaluateModel alloc] init];
        
        model.userName = [dic objectForKeyWithNoNsnull:@"user"];
        model.content = [dic objectForKeyWithNoNsnull:@"content"];
        model.type = [dic objectForKeyWithNoNsnull:@"type"];
        model.time = [dic objectForKeyWithNoNsnull:@"time"];
        model.star = [dic objectForKeyWithNoNsnull:@"star"];
        model.iconUrl = [dic objectForKeyWithNoNsnull:@"iconUrl"];
        
        [_bottomEvaluateData addObject:model];
    }
    [_tableView reloadData];
}
- (void)returnSelectCocchWithBlock:(selectCocchBlock)block{
    self.selectBlock = block;
}

- (void)leftBtnActive:(id)leftBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBtnActive:(id)leftBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)chooseTeacherActive:(id)sender {
    if (_isByPersonVC) {
        if ([[[OrderValidityManager defaultManager] getCurrentOrderStyle] isEqualToString:@"订单已完成"]) {
            //已经完成订单支付
            PersonIndentViewControllerOther*v = [[PersonIndentViewControllerOther alloc] init];
            [self.navigationController pushViewController:v animated:YES];
        }else{
            BOOL isCreateOrder = [[OrderValidityManager defaultManager] orderValidity];
            if (isCreateOrder) {
                PersonIndentViewController *v = [[PersonIndentViewController alloc] init];
                [self.navigationController pushViewController:v animated:YES];
            }else{
                ApplyOrderViewController *v = [[ApplyOrderViewController alloc] init];
                FirstCatStyleModel *model = [[FirstCatStyleModel alloc] init];
                ChoosedClassModel *choosedModel = [DefaultManager shareDefaultManager].carStyleData[1];
                model.type = choosedModel.titleStr;
                model.price = choosedModel.C1Str;
                model.price2 = choosedModel.C2Str;
                model.backGroundImageName = choosedModel.imageStr;
                v.model = model;
                [self.navigationController pushViewController:v animated:YES];
            }
        }
        
    }else{
        if (self.selectBlock != nil) {
            self.selectBlock(_startView.model.name);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UIView *)createHenderView{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 392+10+50+50+10)];
//    headView.backgroundColor = [UIColor redColor];
    
    TopSubView *topSubView = [[TopSubView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 236)];
    topSubView.backgroundColor = BLUE_BACKGROUND_COLOR;
    topSubView.delegate = self;
    topSubView.dataArr = _coachData;
    [headView addSubview:topSubView];
    
    _startView = [[StartGradeView alloc] init];
    _startView.frame = CGRectMake(0, CGRectGetMaxY(topSubView.frame)+25, [UIScreen mainScreen].bounds.size.width, 140);
    _startView.model = _coachData[0];
    _startView.backgroundColor = [UIColor whiteColor];
    [headView addSubview:_startView];
    
    //这里是之前可以滚动的条码，现在不要了
//    NSMutableArray *array=[NSMutableArray array];//显示的标签页
//    myScrollView = [[MyScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_startView.frame), [UIScreen mainScreen].bounds.size.width, 50) titleArray:@[@"全部评价",@"好评",@"中评",@"差评",@"态度好(6)",@"有耐心",@"第7页",@"第8页",@"第9页",@"第10页",@"第11页",@"第12页"] viewArray:array];
//    myScrollView.delegate = self;
//    [headView addSubview:myScrollView];
    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(_startView.frame), [UIScreen mainScreen].bounds.size.width-32, 50)];
    [headView addSubview:subView];
    subView.backgroundColor = [UIColor whiteColor];
    
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 50)];
    subTitleLabel.text = @"教练选择须知";
    subTitleLabel.font = [UIFont systemFontOfSize:16];
    subTitleLabel.textColor = TEXT_COLOR;
    [subView addSubview:subTitleLabel];
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width-32-10, 20, 10, 10)];
    logoImageView.image = [UIImage imageNamed:@"ic_arrow"];
    logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [subView addSubview:logoImageView];
    
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureActive:)];
    [subView addGestureRecognizer:tapG];
    
    UIView *subViewLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(subView.frame), CURRENT_BOUNDS.width, 10)];
    subViewLine.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.98f alpha:1.00f];
    [headView addSubview:subViewLine];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(_startView.frame)+60, [UIScreen mainScreen].bounds.size.width-32, 50)];
    titleLabel.text = @"全部评论";
    titleLabel.textColor = BLUE_BACKGROUND_COLOR;
    titleLabel.font = [UIFont systemFontOfSize:15];
    [headView addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(titleLabel.frame), CURRENT_BOUNDS.width-16, 0.5)];
    lineView.backgroundColor = EEEEEE;
    [headView addSubview:lineView];
    
    return headView;
}

- (void)tapGestureActive:(UITapGestureRecognizer *)tap{
    NSLog(@"点击手势");
     [IPricePopView createPopviewWithName:@"选择教练须知" title1:@"1、教练的选择" title2:@"2、教练更换原则" title3:@"3、关于教练评价" descr1:@"小型汽车、小型自动挡汽车、残疾人专用小型自动挡载客汽车、轻便摩托车准驾车型，18-70周岁" descr2:@"低速载货汽车、三轮汽车、普通三轮摩托车、普通二轮摩托车或者轮式自行机械车准驾车型，18-60周岁" descr3:@"城市公交车、大型货车、无轨电车或则有轨电车准驾车型，20-50周岁" andVC:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    if (_bottomEvaluateData.count < 1) {
        return 0;
    }else
        return _bottomEvaluateData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *index = @"index";
    
    EvaluateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:index];
    if (!cell) {
        cell = [EvaluateTableViewCell cellWithTableToDequeueReusable:tableView identifier:index nibName:@"EvaluateTableViewCell"];
        
    }
    cell.model = _bottomEvaluateData[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_bottomEvaluateData.count < 1) {
        return 0;
    }else{
        CGFloat height = [self heightForString:((EvaluateModel *)_bottomEvaluateData[indexPath.row]).content];
        return 100-16 + height;
    }
}


- (CGFloat) heightForString:(NSString *)string{
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 82,MAXFLOAT) options:options attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    
    CGFloat realHeight = ceilf(rect.size.height);
    return realHeight;
}

#pragma mark - myScrollViewDelegate

- (void)myScrollViewBtnClickWithIndex:(NSString *)index{
    NSLog(@"点击的按钮位置：%@",index);
}

#pragma mark - TopSubViewDelegate

- (void)scrollViewStopWithIndex:(NSIndexPath *)index{
    NSLog(@"当前显示的cell:%ld",(long)index.row);
    
    ChoosedCocchModel *model = _coachData[index.row];
    _startView.model = model;
    [self getDataWithIndex:index.row];
    
}

#pragma mark - loadDataActive
- (void)getDataActive{
   NSString *placeID = [[OrderValidityManager defaultManager] getCurrentPlaceID];
    
    NSDictionary *dic = @{@"trainplaceIds":placeID};
    
    NSURL *url = [NSURL URLWithString:@"http://101.37.29.125:7076/coach/query/all/remark"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    
    NSData *data1 = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"];
    [request setHTTPBody:data1];
    [request setValue:token forHTTPHeaderField:@"HMAuthorization"];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    [CustomAlertView showAlertViewWithVC:self];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomAlertView hideAlertView];
            _tableView.hidden = NO;
        });
        if (error == nil) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSArray *arrData = [jsonDict objectForKey:@"data"];
            if (arrData == nil || arrData.count < 1) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showMistake];
                });
                
                return ;
            }
            for (NSDictionary *dic in arrData) {
                ChoosedCocchModel *model = [[ChoosedCocchModel alloc] init];
                model.coachID = [dic objectForKeyWithNoNsnull:@"id"];
                model.name = [dic objectForKeyWithNoNsnull:@"name"];
                model.starValue = [dic objectForKeyWithNoNsnull:@"starValue"];
                model.teachNum = [dic objectForKeyWithNoNsnull:@"teachNum"];
                model.passPercent = [NSString stringWithFormat:@"%@%%",[dic objectForKeyWithNoNsnull:@"passRate"]];
                model.commentNum = [NSString stringWithFormat:@"%lu",(unsigned long)((NSArray *)[dic objectForKeyWithNoNsnull:@"commentList"]).count];
                model.iconUrl = [dic objectForKeyWithNoNsnull:@"icon"];
                model.comentList = [dic objectForKeyWithNoNsnull:@"commentList"];
                model.introducation = [dic objectForKeyWithNoNsnull:@"introduction"];
                [_coachData addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                _tableView.tableHeaderView = [self createHenderView];
                [self getDataWithIndex:0];
            });
            
        }else{
            
            [CustomAlertView hideAlertView];
            
            //验证码输入错误
            UIAlertController *v = [UIAlertController alertControllerWithTitle:@"验证失败" message:@"服务器异常！！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            [v addAction:active];
            [self presentViewController:v animated:YES completion:^{
                
            }];
        }
    }];
    [dataTask resume];
}

- (void)showMistake{
    UIAlertController *v = [UIAlertController alertControllerWithTitle:@"提示" message:@"服务器异常！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [v addAction:active];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:v animated:YES completion:^{
            
        }];
    });
}

@end
