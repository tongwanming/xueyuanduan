//
//  PersonCenterViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/8/1.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "PersonCenterViewController.h"
#import "SubjectTwoPopWebViewController.h"
#import "PersonNewsViewController.h"
#import "eventNotictionViewController.h"
#import "TeachNewsViewController.h"
#import "ExameNewsViewController.h"
#import "CustomAlertView.h"

@interface PersonCenterTableViewCell : UITableViewCell

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, strong) NSString *desTitleStr;
@property (nonatomic, strong) NSString *timeStr;
@property (nonatomic, strong) NSString *newsCount;


@end

@implementation PersonCenterTableViewCell{
    UIImageView *_imageView;
    UILabel *_newCount;
    UILabel *_titleLabel;
    UILabel *_dedLabel;
    UILabel *tiumeLabel;
}

- (void)setImageUrl:(NSString *)imageUrl{
    [_imageView setImage:[UIImage imageNamed:imageUrl]];
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    _titleLabel.text = titleStr;
}

- (void)setDesTitleStr:(NSString *)desTitleStr{
    _desTitleStr = desTitleStr;
    _dedLabel.text = desTitleStr;
}

- (void)setTimeStr:(NSString *)timeStr{
    _timeStr = timeStr;
    tiumeLabel.text = timeStr;
}

- (void)setNewsCount:(NSString *)newsCount{
    _newsCount = newsCount;
    _newCount.text = newsCount;
    if ([newsCount isEqualToString:@"0"]) {
        _newCount.hidden = YES;
        _dedLabel.text = @"暂无未读消息！";
    }else{
        _newCount.hidden = NO;
        _dedLabel.text = @"你有新的消息未读！";
        
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 17, 84/2, 84/2)];
        _imageView.center = CGPointMake(16+84/4, self.frame.size.height/2+17);
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.cornerRadius = 84/4;
        _imageView.image = [UIImage imageNamed:@"icon"];
        [self addSubview:_imageView];
        
        _newCount = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 17, 17)];
        _newCount.backgroundColor = [UIColor orangeColor];
        _newCount.layer.masksToBounds = YES;
        _newCount.layer.cornerRadius = 17/2;
        _newCount.layer.borderColor = [UIColor whiteColor].CGColor;
        _newCount.layer.borderWidth = 1;
        _newCount.layer.shouldRasterize = YES;//画图后的图形会保存到cacsh里面，下次能直接调用，不会每次创建导致卡顿
        _newCount.font = [UIFont systemFontOfSize:12];
        _newCount.textAlignment = NSTextAlignmentCenter;
        _newCount.textColor = [UIColor whiteColor];
        _newCount.text = @"5";
        _newCount.center = CGPointMake(84/2+16-4, self.frame.size.height/2+17-84/4+5);
        [self addSubview:_newCount];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame)+16, 18, CURRENT_BOUNDS.width-100, 16)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor = TEXT_COLOR;
        _titleLabel.text = @"系统消息";
        [self addSubview:_titleLabel];
        
        _dedLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageView.frame)+16, CGRectGetMaxY(_titleLabel.frame)+9, CURRENT_BOUNDS.width-100, 14)];
        _dedLabel.textColor = ADB1B9;
        _dedLabel.font = [UIFont systemFontOfSize:14];
        _dedLabel.text = @"最新版本v2.24好梦学车客户端已经在各大应用市场上线！";
        [self addSubview:_dedLabel];
        
        tiumeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width-150, 19.5, 150-16, 13)];
        tiumeLabel.textAlignment = NSTextAlignmentRight;
        tiumeLabel.font = [UIFont systemFontOfSize:13];
        tiumeLabel.textColor = ADB1B9;
        tiumeLabel.text = @"4-21";
        tiumeLabel.hidden = YES;
        [self addSubview:tiumeLabel];
        
        
    }
    
    return self;
}

@end

@interface PersonCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PersonCenterViewController{
    NSArray *_imageData;
    NSArray *_titleData;
    NSArray *_detailData;
    NSMutableArray *_numData;
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
    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Disappear"];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"]) {
         [self getDataWithUserId:YES];
    }else{
        [self getDataWithUserId:NO];
    }
   
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Appear"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    _imageData = @[@"icon_messcenter_system",@"icon_messcenter_activity",@"icon_messcenter_register",@"icon_messcenter_examination"];
    _titleData = @[@"系统消息",@"活动消息",@"教学消息",@"考试消息"];
    _detailData = @[@"你有新的系统消息",@"你有新的活动消息",@"你有新的教学消息",@"你有新的考试消息"];
    _numData = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"isLogined"]) {
        return 4;
    }else{
        return 2;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 74;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indxe = @"ddd";
    PersonCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indxe];
    if (!cell) {
        cell = [[PersonCenterTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indxe];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageUrl = _imageData[indexPath.row];
    cell.titleStr = _titleData[indexPath.row];
    if (_numData.count > indexPath.row) {
        cell.newsCount = _numData[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        PersonNewsViewController *v = [[PersonNewsViewController alloc] init];
        [self.navigationController pushViewController:v animated:YES];
    }else if (indexPath.row == 1){
        eventNotictionViewController *v = [[eventNotictionViewController alloc] init];
        [self.navigationController pushViewController:v animated:YES];
    }else if (indexPath.row == 2){
        TeachNewsViewController *v = [[TeachNewsViewController alloc] init];
        [self.navigationController pushViewController:v animated:YES];
    }else if (indexPath.row == 3){
        ExameNewsViewController *v = [[ExameNewsViewController alloc] init];
        [self.navigationController pushViewController:v animated:YES];
    }else{
    
    }
    
}

- (void)getDataWithUserId:(BOOL)isLogin{
    
    
    NSDictionary *dic;
    if (isLogin) {
        NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
        NSString *userId = [userDic objectForKey:@"userId"];
        dic =@{@"msgType":@"",@"platform":@"",@"pushClient":@"STUDENT",@"pushStatus":@"",@"tags":userId};//0->未开始学习，1->学习中，2->暂停学习，3->申请考试，4->考试通过，5->补考中, 6->考爆
    }else{
        dic =@{@"msgType":@"",@"platform":@"",@"pushClient":@"STUDENT",@"pushStatus":@"",@"tags":@""};//0->未开始学习，1->学习中，2->暂停学习，3->申请考试，4->考试通过，5->补考中, 6->考爆
    }
    
    
    NSData *data1 = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
    
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonStr];
    
    NSRange range = {0,jsonStr.length};
    
    [mutStr replaceOccurrencesOfString:@" "withString:@""options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    [mutStr replaceOccurrencesOfString:@"\n"withString:@""options:NSLiteralSearch range:range2];
    NSRange range3 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\\"withString:@""options:NSLiteralSearch range:range3];
    NSData *jsonData = [mutStr dataUsingEncoding:NSUTF8StringEncoding];
    
    
    //    NSURL *url = [NSURL URLWithString:urlstr];http://101.37.29.125:7076/coach/query/student
    NSURL *url = [NSURL URLWithString:@"http://101.37.29.125:7072/order-service/api/common/push/queryPushNumInfoByTags"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    [request setHTTPBody:jsonData];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    [CustomAlertView showAlertViewWithVC:self];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            
            NSString *success = [NSString stringWithFormat:@"%@",[jsonDict objectForKey:@"success"]];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [CustomAlertView hideAlertView];
            });
            if (_numData.count > 0) {
                [_numData removeAllObjects];
            }
            
            if (success.boolValue) {
                NSDictionary *dic = [jsonDict objectForKey:@"data"];
                [_numData addObject:[dic objectForKeyWithNoNsnull:@"systemNum"]];
                 [_numData addObject:[dic objectForKeyWithNoNsnull:@"promotionNum"]];
                 [_numData addObject:[dic objectForKeyWithNoNsnull:@"teachNum"]];
                 [_numData addObject:[dic objectForKeyWithNoNsnull:@"examNum"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tableView reloadData];
                });
                
            }else{

            }
        }else{

        }
    }];
    [dataTask resume];
    
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
