//
//  SubjectAllChaptersViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/6/7.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectAllChaptersViewController.h"
#import "URLConnectionModel.h"
#import "URLConnectionHelper.h"
#import "CustomAlertView.h"

@interface SubjectAllChaptersViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation SubjectAllChaptersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    _tableView.hidden = YES;
    [self loadData];
    // Do any additional setup after loading the view from its nib.
}

- (void)showData{
    _tableView.hidden = NO;
}

- (void)loadData{
    [CustomAlertView showAlertViewWithVC:self];
    URLConnectionModel *model = [[URLConnectionModel alloc] init];
    if (_practiseType == PractiseViewControllerTypeOne) {
        
        
        model.serviceName = @"hm.question.bank.mock_exam";
        model.course = @"1";
        model.chapter = @"";
        model.isRand = @"";
    }else{
    
    }
    [[URLConnectionHelper shareDefaulte] getPostDataWithUrl:@"" andConnectModel:model andSuccessBlock:^(NSData *data) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomAlertView hideAlertView];
            [self showData];
        });
        
    } andFailedBlock:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [CustomAlertView hideAlertView];
            [self showData];
        });
    }];
}

- (IBAction)btnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _allChapter.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *index = @"index";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:index];
    }
    cell.textLabel.textColor = TEXT_COLOR;
    cell.textLabel.text = _allChapter[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
