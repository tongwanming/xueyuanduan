//
//  TeachNewsViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/8/23.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "TeachNewsViewController.h"
#import "SubjectTwoPopWebViewController.h"
#import "UILabel+changeLineSpace.h"
#import "EventCoachView.h"
#import "CustomAlertView.h"
#import "EvaluateViewController.h"
#import "SettingPersonNewsModel.h"

@interface TeachNewsTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) NSString *eventStation;

@property (nonatomic, strong) UILabel *logoLabel;

@property (nonatomic, strong) SettingPersonNewsModel *model;

@end

@implementation TeachNewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = F4F6F9;
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width/2-85/2, 30, 85, 26)];
        _timeLabel.layer.masksToBounds = YES;
        _timeLabel.layer.cornerRadius = 12;
        _timeLabel.backgroundColor = CCCFD6;
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.text = @"08-22 11:30";
        [self.contentView addSubview:_timeLabel];
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(10, 71, CURRENT_BOUNDS.width-20, 140)];
        backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:backView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 20, CURRENT_BOUNDS.width-20-32, 66)];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.numberOfLines = 2;
        _titleLabel.text = @"张教练在为你完成科目二学车签到，请对教练进行评价！";
        [_titleLabel changeLineSpaceForLabel:_titleLabel WithSpace:6];
        
        [backView addSubview:_titleLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(_titleLabel.frame)+20, CURRENT_BOUNDS.width-20-32, 0.5)];
        lineView.backgroundColor = EEEEEE;
        [backView addSubview:lineView];
        
        _logoLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(lineView.frame)+20, 200, 15)];
        _logoLabel.font = [UIFont systemFontOfSize:15];
        _logoLabel.textColor = TEXT_COLOR;
        _logoLabel.text = @"点击评价教练";
        [backView addSubview:_logoLabel];
        
        UIImageView *imageLogo = [[UIImageView alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width-50, CGRectGetMaxY(lineView.frame)+20, 20, 15)];
        imageLogo.contentMode = UIViewContentModeScaleAspectFit;
        imageLogo.image = [UIImage imageNamed:@"btn_go"];
        [backView addSubview:imageLogo];
    }
    
    return self;
}

- (void)setModel:(SettingPersonNewsModel *)model{
    _model = model;
    _timeLabel.text = [self reloadTimeStrWithStr:_model.timeStr];
    _titleLabel.text = _model.describeStr;
    if ([_model.newsState isEqualToString:@"0"]) {
        _logoLabel.text = @"点击评价教练";
    }else if ([_model.newsState isEqualToString:@"1"]){
        _logoLabel.text = @"教练已评价";
    }else{
        
        _logoLabel.text = @"点击评价教练";
    }
    
}

- (NSString *)reloadTimeStrWithStr:(NSString *)oldStr{
    NSString *str;
    NSMutableString *mutStr = [NSMutableString stringWithString:oldStr];
    
    
    
    str = [mutStr substringWithRange:NSMakeRange(5, 11)];
    
    return str;
}

@end

@interface TeachNewsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@property (nonatomic, strong) UILabel *nameLabel;

//test
@property (nonatomic, strong) NSMutableDictionary *titleDetail;



@end

@implementation TeachNewsViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Disappear"];
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self getData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Appear"];
}

- (IBAction)btnClick:(id)sender {
    UIButton *btn = sender;
    if (btn.tag == 1001) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        SubjectTwoPopWebViewController *v = [[SubjectTwoPopWebViewController alloc] init];
        v.url = @"https://eco-api.meiqia.com/dist/standalone.html?eid=10708";
        v.titleStr = @"在线咨询";
        [self.navigationController pushViewController:v animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.98f alpha:1.00f];
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, 100)];
    _nameLabel.font = [UIFont systemFontOfSize:16];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.textColor = ADB1B9;
    _nameLabel.text = @"没有新的消息!";
    _nameLabel.hidden = YES;
    _nameLabel.center = CGPointMake(CURRENT_BOUNDS.width/2, CURRENT_BOUNDS.height/2);
    [self.view addSubview:_nameLabel];
    
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [_tableView setTableHeaderView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    _titleDetail = [[NSMutableDictionary alloc] init];
    for (NSInteger i = 0; i < 5; i++) {
        
        [_titleDetail setObject:@"点击评价教练" forKey:[NSString stringWithFormat:@"%ld",(long)i]];
    }
    
    _data = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view from its nib.
}

- (void)getData{
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
    NSString *userId = [userDic objectForKey:@"userId"];
    NSDictionary *dic;
    if (userId && userId.length >0) {
        dic =@{@"msgType":@"TEACH",@"platform":@"",@"pushClient":@"STUDENT",@"pushStatus":@"",@"tags":userId};//0->未开始学习，1->学习中，2->暂停学习，3->申请考试，4->考试通过，5->补考中, 6->考爆
    }else{
        dic =@{@"msgType":@"TEACH",@"platform":@"",@"pushClient":@"STUDENT",@"pushStatus":@"",@"tags":@""};//0->未开始学习，1->学习中，2->暂停学习，3->申请考试，4->考试通过，5->补考中, 6->考爆
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
    NSURL *url = [NSURL URLWithString:@"http://101.37.29.125:7071/api/common/push/queryPushInfoList"];
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
            if (success.boolValue) {
                NSArray *arr = [jsonDict objectForKey:@"data"];
                if (_data.count > 0) {
                    [_data removeAllObjects];
                }
                for (NSDictionary *dic in arr) {
                    NSMutableString *str = [dic objectForKeyWithNoNsnull:@"remark"];
                   SettingPersonNewsModel *model = [[SettingPersonNewsModel alloc] init];
                    if (str.length > 0) {
                        NSArray *arr = [str componentsSeparatedByString:@","];
                        model.coachId = arr[0];
                        if (arr.count >1) {
                            
                            model.recordId = arr[1];
                        }
                    }
                    
                    
                    model.timeStr = [dic objectForKeyWithNoNsnull:@"pushTime"];
                    model.titleStr = [dic objectForKeyWithNoNsnull:@"title"];
                    model.describeStr = [dic objectForKeyWithNoNsnull:@"msgContent"];
                    model.imageUrl = [dic objectForKeyWithNoNsnull:@"msgPicPath"];
                    model.htmlUrl = [dic objectForKeyWithNoNsnull:@"nextLinkUrl"];
                    
                    model.newsId = [[NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] intValue];
                    model.newsState = [dic objectForKeyWithNoNsnull:@"isRead"];
                    [_data addObject:model];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tableView reloadData];
                });
                
            }else{
                //登录失败
                dispatch_async(dispatch_get_main_queue(), ^{
                    _nameLabel.hidden = NO;
//                    //验证码输入错误
//                    UIAlertController *v = [UIAlertController alertControllerWithTitle:@"错误提示" message:@"获取数据失败，请稍后再试" preferredStyle:UIAlertControllerStyleAlert];
//                    UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//                        
//                    }];
//                    [v addAction:active];
//                    [self presentViewController:v animated:YES completion:^{
//                        
//                    }];
                });
            }
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [CustomAlertView hideAlertView];
                UIAlertController *v = [UIAlertController alertControllerWithTitle:@"错误提示" message:@"获取数据失败，请稍后再试" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [v addAction:active];
                [self presentViewController:v animated:YES completion:^{
                    
                }];
            });
        }
    }];
    [dataTask resume];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 211;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *index = @"index";
    TeachNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:index];
    if (!cell) {
        cell = [[TeachNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:index];
    }
//    cell.logoLabel.text = [_titleDetail objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    cell.model = _data[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _currentIndexPath = indexPath;
    SettingPersonNewsModel *model = _data[indexPath.row];
    if ([model.newsState isEqualToString:@"1"]) {
        EvaluateViewController *v = [[EvaluateViewController alloc] init];
        v.model = model;
        [self.navigationController pushViewController:v animated:YES];
    }else{
        [self loadCoachNewsWithCoachId:model.coachId andRecordId:model.recordId];
        
    }
}

- (void)loadCoachNewsWithCoachId:(NSString *)coachId andRecordId:(NSString *)recordId{
   
    NSDictionary *dic =@{@"coachId":coachId};//根据coachid 查询对应教练
    
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
    NSURL *url = [NSURL URLWithString:@"http://101.37.29.125:7076/coach/get"];
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
            if (success.boolValue) {
                NSDictionary *dic = [jsonDict objectForKey:@"data"];
                NSString *heandPicUrl = [dic objectForKeyWithNoNsnull:@"headPicture"];
                NSString *coachName  = [dic objectForKeyWithNoNsnull:@"realName"];
                
                __weak __typeof(&*self) weakSelf = self;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[EventCoachView shareDefault] showEventCoachViewWithVC:self andWithName:coachName andImage:heandPicUrl andBlock:^(NSString *_des, NSString *_point) {
                        
                        [weakSelf commitEvaluateActiveWithCoachId:recordId andDes:_des andPint:_point];
                    }];
                });
                
                
            }else{
                //登录失败
                dispatch_async(dispatch_get_main_queue(), ^{
                    //验证码输入错误
                    UIAlertController *v = [UIAlertController alertControllerWithTitle:@"错误提示" message:@"获取数据失败，请稍后再试" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [v addAction:active];
                    [self presentViewController:v animated:YES completion:^{
                        
                    }];
                });
            }
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [CustomAlertView hideAlertView];
                UIAlertController *v = [UIAlertController alertControllerWithTitle:@"错误提示" message:@"获取数据失败，请稍后再试" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [v addAction:active];
                [self presentViewController:v animated:YES completion:^{
                    
                }];
            });
        }
    }];
    [dataTask resume];

}

// 提交对该教练的评论
- (void)commitEvaluateActiveWithCoachId:(NSString *)recordId andDes:(NSString *)des andPint:(NSString *)point{
    NSDictionary *dic =@{@"recordId":recordId,@"remark":des,@"stars":@([point intValue])};//根据coachid 查询对应教练
    
    NSData *data1 = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
    
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonStr];
    
    NSRange range = {0,jsonStr.length};
//
//    [mutStr replaceOccurrencesOfString:@" "withString:@""options:NSLiteralSearch range:range];
//    
//    NSRange range2 = {0,mutStr.length};
    
    [mutStr replaceOccurrencesOfString:@"\n"withString:@""options:NSLiteralSearch range:range];
    NSRange range3 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\\"withString:@""options:NSLiteralSearch range:range3];
    NSData *jsonData = [mutStr dataUsingEncoding:NSUTF8StringEncoding];
    
    
    //    NSURL *url = [NSURL URLWithString:urlstr];http://101.37.29.125:7076/coach/query/student
    NSURL *url = [NSURL URLWithString:@"http://101.37.29.125:7076/student/study/remark/add"];
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
            //此处为测试数据
//            SettingPersonNewsModel *model = _data[_currentIndexPath.row];
//             [self refreshNewStateWithMdel:model];
            if (success.boolValue) {
             //此处需要临时修改cell 上面的为已评论
                
                SettingPersonNewsModel *model = _data[_currentIndexPath.row];
                model.newsState = @"1";
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tableView reloadData];
                });
                [self refreshNewStateWithMdel:model];
            }else{
                //登录失败
                dispatch_async(dispatch_get_main_queue(), ^{
                    //验证码输入错误
                    UIAlertController *v = [UIAlertController alertControllerWithTitle:@"错误提示" message:@"获取数据失败，请稍后再试" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        
                    }];
                    [v addAction:active];
                    [self presentViewController:v animated:YES completion:^{
                        
                    }];
                });
            }
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [CustomAlertView hideAlertView];
                UIAlertController *v = [UIAlertController alertControllerWithTitle:@"错误提示" message:@"获取数据失败，请稍后再试" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [v addAction:active];
                [self presentViewController:v animated:YES completion:^{
                    
                }];
            });
        }
    }];
    [dataTask resume];

}

- (void)refreshNewStateWithMdel:(SettingPersonNewsModel *)model{
    NSDictionary *dic =@{@"pushId":@(model.newsId),@"target":@"string"};
    
    NSData *data1 = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
    
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonStr];
    
    NSRange range = {0,jsonStr.length};
    
    [mutStr replaceOccurrencesOfString:@"\n"withString:@""options:NSLiteralSearch range:range];
    NSRange range3 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\\"withString:@""options:NSLiteralSearch range:range3];
    NSData *jsonData = [mutStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:@"http://101.37.29.125:7071/api/common/push/markRead"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    [request setHTTPBody:jsonData];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    }];
    [dataTask resume];
}

- (void)shouLoading{
    [_tableView reloadData];
    [CustomAlertView showAlertViewWithVC:self];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [CustomAlertView hideAlertView];
        EvaluateViewController *v = [[EvaluateViewController alloc] init];
        [self.navigationController pushViewController:v animated:YES];
    });
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
