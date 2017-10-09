//
//  PersonNewsViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/6/6.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "PersonNewsViewController.h"
#import "SettingPersonNewsModel.h"
#import "UIImageView+WebCache.h"
#import "SubjectTwoPopWebViewController.h"
#import "CustomAlertView.h"
#import "PushNewsModel.h"
#import "NSDictionary+objectForKeyWitnNoNsnull.h"
#import "UILabel+changeLineSpace.h"

@interface SettingPersonNewsTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *describeLabel;

@property (nonatomic, strong) UIImageView *showImageView;

@property (nonatomic, strong) SettingPersonNewsModel *model;

@property (nonatomic, assign) BOOL isNextVC;

@end

@implementation SettingPersonNewsTableViewCell{
    UIView *backView;
    UIView *lineView;
    UILabel *logoLabel;
    UIImageView *imageLogo;
}

-(void)setIsNextVC:(BOOL)isNextVC{
    if (isNextVC) {
        logoLabel.hidden = NO;
        imageLogo.hidden = NO;
    }else{
        logoLabel.hidden = YES;
        imageLogo.hidden = YES;
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = F4F6F9;
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width/2-85/2, 20, 85, 24)];
        _timeLabel.layer.masksToBounds = YES;
        _timeLabel.layer.cornerRadius = 12;
        _timeLabel.backgroundColor = CCCFD6;
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.text = @"08-22 11:30";
        [self.contentView addSubview:_timeLabel];
        
        backView = [[UIView alloc] initWithFrame:CGRectMake(10, 59, CURRENT_BOUNDS.width-20, 57.5)];
        backView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:backView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 16, CURRENT_BOUNDS.width-20-32, 18)];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = TEXT_COLOR;
        _titleLabel.text = @"欢迎您加入好梦学车";
        [backView addSubview:_titleLabel];
        
        _describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(_titleLabel.frame)+15, CURRENT_BOUNDS.width-20-32, 39+10)];
        _describeLabel.font = [UIFont systemFontOfSize:15];
        _describeLabel.textColor = ADB1B9;
        _describeLabel.numberOfLines = 0;
        _describeLabel.text = @"这是对该条消息的一个具体描述内容";
        [_describeLabel changeLineSpaceForLabel:_describeLabel WithSpace:12];
        [backView addSubview:_describeLabel];
        
//        _showImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(_describeLabel.frame)+16, CURRENT_BOUNDS.width - 20-32, 150)];
//        _showImageView.contentMode = UIViewContentModeScaleToFill;
//        
//        _showImageView.image = [UIImage imageNamed:@"pic04"];
//        [backView addSubview:_showImageView];
        
//        lineView = [[UIView alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(_describeLabel.frame)+16, CURRENT_BOUNDS.width-20-32, 0.5)];
//        lineView.backgroundColor = EEEEEE;
//        [backView addSubview:lineView];
        
        logoLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(_describeLabel.frame)+15, 200, 12)];
        logoLabel.font = [UIFont systemFontOfSize:12];
        logoLabel.textColor = TEXT_COLOR;
        logoLabel.text = @"了解详情";
        [backView addSubview:logoLabel];
        
        imageLogo = [[UIImageView alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width-50, CGRectGetMaxY(_describeLabel.frame)+14, 20, 15)];
        imageLogo.contentMode = UIViewContentModeScaleAspectFit;
        imageLogo.image = [UIImage imageNamed:@"btn_go"];
        [backView addSubview:imageLogo];
        logoLabel.hidden = NO;
        imageLogo.hidden = NO;
        
    }
    return self;
}

- (void)setModel:(SettingPersonNewsModel *)model{
    _model = model;
    _timeLabel.text = [self reloadTimeStrWithStr:_model.timeStr];
    _titleLabel.text = _model.titleStr;
    _describeLabel.text = _model.describeStr;
    CGFloat height = [self heightForString:_model.describeStr andFontOfSize:15 andWidth:CURRENT_BOUNDS.width-20-32];
    backView.frame = CGRectMake(10, 59, CURRENT_BOUNDS.width-20, 57+height+20);
    _describeLabel.frame = CGRectMake(16, CGRectGetMaxY(_titleLabel.frame)+15, CURRENT_BOUNDS.width-20-32, height);
//    lineView.frame = CGRectMake(16, CGRectGetMaxY(_describeLabel.frame)+16, CURRENT_BOUNDS.width-20-32, 0.5);
}

- (NSString *)reloadTimeStrWithStr:(NSString *)oldStr{
    if (oldStr && oldStr.length > 10) {
        NSString *str;
        NSMutableString *mutStr = [NSMutableString stringWithString:oldStr];
        
        
        
        str = [mutStr substringWithRange:NSMakeRange(5, 11)];
        
        return str;
    }else{
        return @"";
    }
}

- (CGFloat) heightForString:(NSString *)string andFontOfSize:(CGFloat)fontSize andWidth:(CGFloat)width{
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:options attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    
    CGFloat realHeight = ceilf(rect.size.height);
    return realHeight;
}

@end

@interface PersonNewsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation PersonNewsViewController
{
    
}
- (IBAction)btnClick:(id)sender {
    UIButton *btn = sender;
    if (btn.tag == 1001) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (btn.tag == 1002){
        SubjectTwoPopWebViewController *v = [[SubjectTwoPopWebViewController alloc] init];
        v.url = @"https://eco-api.meiqia.com/dist/standalone.html?eid=10708";
        v.titleStr = @"在线咨询";
        [self.navigationController pushViewController:v animated:YES];
    }
    
}

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

- (void)viewDidLoad {
    [super viewDidLoad];
    _data = [[NSMutableArray alloc] init];
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
    // Do any additional setup after loading the view from its nib.
}

- (void)getData{
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];
    NSString *userId = [userDic objectForKey:@"userId"];
    NSDictionary *dic;
    if (userId && userId.length >0) {
        dic =@{@"msgType":@"SYSTEM",@"platform":@"",@"pushClient":@"STUDENT",@"pushStatus":@"",@"tags":userId};//0->未开始学习，1->学习中，2->暂停学习，3->申请考试，4->考试通过，5->补考中, 6->考爆
    }else{
        dic =@{@"msgType":@"SYSTEM",@"platform":@"",@"pushClient":@"STUDENT",@"pushStatus":@"",@"tags":@""};//0->未开始学习，1->学习中，2->暂停学习，3->申请考试，4->考试通过，5->补考中, 6->考爆
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
                    SettingPersonNewsModel *model = [[SettingPersonNewsModel alloc] init];
                    model.timeStr = [dic objectForKeyWithNoNsnull:@"pushTime"];
                    model.titleStr = [dic objectForKeyWithNoNsnull:@"title"];
                    model.describeStr = [dic objectForKeyWithNoNsnull:@"msgContent"];
                    model.imageUrl = [dic objectForKeyWithNoNsnull:@"msgPicPath"];
                    model.htmlUrl = [dic objectForKeyWithNoNsnull:@"nextLinkUrl"];
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
//                    UIAlertController *v = [UIAlertController alertControllerWithTitle:@"提示" message:@"数据为空！" preferredStyle:UIAlertControllerStyleAlert];
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
   SettingPersonNewsModel *model = _data[indexPath.row];
    CGFloat height = [self heightForString:model.describeStr andFontOfSize:15 andWidth:CURRENT_BOUNDS.width-20-32];
    return height+59+57+32;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *index = @"index";
    SettingPersonNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:index];
    if (!cell) {
        cell = [[SettingPersonNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:index];
    }
//    cell.backgroundColor = [UIColor redColor];
    SettingPersonNewsModel *model = _data[indexPath.row];
   cell.model = _data[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([model.titleStr isEqualToString:@"报名须知"]) {
        cell.isNextVC = YES;
    }else{
        cell.isNextVC = NO;
    }
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingPersonNewsModel *model = _data[indexPath.row];
    if ([model.titleStr isEqualToString:@"报名须知"]) {
        
        SubjectTwoPopWebViewController *v = [[SubjectTwoPopWebViewController alloc] init];
        v.url = model.htmlUrl;
        v.titleStr = @"系统消息";
        [self.navigationController pushViewController:v animated:YES];
    }else
        return;
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat) heightForString:(NSString *)string andFontOfSize:(CGFloat)fontSize andWidth:(CGFloat)width{
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:options attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    
    CGFloat realHeight = ceilf(rect.size.height);
    return realHeight;
}

@end
