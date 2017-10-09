//
//  SubjectOneCheatsViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/5/12.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectOneCheatsViewController.h"
#import "SubjectCheatsModel.h"
#import "UIImageView+WebCache.h"
#import "SubjectTwoPopWebViewController.h"
#import "CustomAlertView.h"
#import "URLConnectionModel.h"
#import "URLConnectionHelper.h"
#import "CheatsModel.h"

@interface SubjectCheatsTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *describeLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *haoMengLabel;

@property (nonatomic, strong) UIImageView *picImageView;

@property (nonatomic, strong) CheatsModel *model;

@end

@implementation SubjectCheatsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 20, CURRENT_BOUNDS.width-32-121, 16)];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = TEXT_COLOR;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
        
        _describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 20+15+16, CURRENT_BOUNDS.width-32-121, 13*2+8)];
        _describeLabel.font = [UIFont systemFontOfSize:13];
        _describeLabel.textColor = ADB1B9;
        _describeLabel.textAlignment = NSTextAlignmentLeft;
        _describeLabel.numberOfLines = 2;
        [self.contentView addSubview:_describeLabel];
        
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 295/2-13-20, CURRENT_BOUNDS.width-32-111, 13)];
        _timeLabel.font = [UIFont systemFontOfSize:16];
        _timeLabel.textColor = ADB1B9;
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_timeLabel];
        
        _haoMengLabel = [[UILabel alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width-80, 295/2-12-20, 80-16, 13)];
        _haoMengLabel.font = [UIFont systemFontOfSize:13];
        _haoMengLabel.textColor = BLUE_BACKGROUND_COLOR;
        _haoMengLabel.textAlignment = NSTextAlignmentRight;
        _haoMengLabel.text = @"好梦学车";
        [self.contentView addSubview:_haoMengLabel];
        
        _picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width-111-16, 20, 111, 166/2)];
        _picImageView.contentMode = UIViewContentModeScaleAspectFit;
        _picImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_picImageView];
        
        
    }
    return self;
}

- (void)setModel:(CheatsModel *)model{
    _model = model;
    
    _titleLabel.text = model.articleTitle;
    _describeLabel.text = model.articleAbstract;
    _timeLabel.text = model.createTime;
    [_picImageView sd_setImageWithURL:[NSURL URLWithString:model.articleType] placeholderImage:[UIImage imageNamed:@"bg_personal_defaultavatar"]];
}

@end

@interface SubjectOneCheatsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic, strong) NSMutableArray *data;

@property (nonatomic, strong) NSString *testStr;

@end

@implementation SubjectOneCheatsViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Disappear"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _titileNameLabel.text = _titleStr;
    _data = [[NSMutableArray alloc] init];
    [self getData];
    // Do any additional setup after loading the view from its nib.
}

- (void)getData{
    
    
    _tableView.hidden = YES;
    [CustomAlertView showAlertViewWithVC:self];
    NSDictionary *dic = @{@"bussTypeList":_type};
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
    
    //    NSURL *url = [NSURL URLWithString:urlstr];
    NSURL *url = [NSURL URLWithString:@"http://101.37.29.125:7071/api/common/content/query"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    [request setHTTPBody:jsonData];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
           [CustomAlertView hideAlertView];
        });
        if (error == nil) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            BOOL successd = [jsonDict objectForKey:@"success"];
            if (successd) {
                NSArray *arrData = [jsonDict objectForKey:@"data"];
                for (NSDictionary *dic in arrData) {
                    CheatsModel *model = [[CheatsModel alloc] init];
                    
                    model.currentId = [dic objectForKeyWithNoNsnull:@"id"];
                    model.articleAbstract = [dic objectForKeyWithNoNsnull:@"articleAbstract"];
                    model.bussType = [dic objectForKeyWithNoNsnull:@"bussType"];
                    model.headline = [dic objectForKeyWithNoNsnull:@"headline"];
                    model.articleCorver = [dic objectForKeyWithNoNsnull:@"articleCorver"];
                    model.createTime = [dic objectForKeyWithNoNsnull:@"createTime"];
                    model.articleUrl = [dic objectForKeyWithNoNsnull:@"articleUrl"];
                    model.validFlag = [dic objectForKeyWithNoNsnull:@"validFlag"];
                    model.articleType = [dic objectForKeyWithNoNsnull:@"articleType"];
                    model.articleContent = [dic objectForKeyWithNoNsnull:@"articleContent"];
                    model.numReads = [dic objectForKeyWithNoNsnull:@"numReads"];
                    model.articleTitle = [dic objectForKeyWithNoNsnull:@"articleTitle"];
                    model.articleStatus = [dic objectForKeyWithNoNsnull:@"articleStatus"];
                    
                    [_data addObject:model];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [_tableView reloadData];
                    _tableView.hidden = NO;
                });
                
            }else{
            
            }
            
           
        }else{
            UIAlertController *v = [UIAlertController alertControllerWithTitle:@"验证失败" message:@"服务器异常！！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *active = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [v addAction:active];
            [self presentViewController:v animated:YES completion:^{
                
            }];
        }
    }];
    [dataTask resume];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 295/2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *index = @"index";
    SubjectCheatsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:index];
    if (!cell) {
        cell = [[SubjectCheatsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:index];
    }
    cell.model = self.data[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SubjectTwoPopWebViewController *v = [[SubjectTwoPopWebViewController alloc] init];
    v.url = ((CheatsModel *)_data[indexPath.row]).articleUrl;
    v.titleStr = ((CheatsModel *)_data[indexPath.row]).articleTitle;
    [self.navigationController pushViewController:v animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
