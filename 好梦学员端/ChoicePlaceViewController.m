//
//  ChoicePlaceViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/7/3.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "ChoicePlaceViewController.h"

@interface ChoicePlaceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, strong) NSString *choosedLocation;

@end

@implementation ChoicePlaceViewController
{
    NSIndexPath *_choosedIndexPath;
}

- (NSArray *)data{
    if (!_data) {
        _data = @[@"渝中区",@"沙坪坝区",@"江北区",@"南岸区",@"大渡口区",@"九龙坡区",@"渝北区",@"巴南区",@"北部新区"];
    }
    return _data;
}
- (IBAction)btnClick:(id)sender {
    [self backVC];
}

- (void)backVC{
    if (_chosedPlaceBlock) {
        _chosedPlaceBlock(_choosedLocation);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Disappear"];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Appear"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    _choosedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"personNews"]];

    _choosedLocation = [dic objectForKey:@"address"];
    
    if (_choosedLocation == nil || _choosedLocation.length <1) {
        _choosedLocation = self.data[0];
    }
    // Do any additional setup after loading the view from its nib.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *index = @"index";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:index];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:index];
    }
    cell.textLabel.textColor = TEXT_COLOR;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.text = self.data[indexPath.row];
    if ([cell.textLabel.text isEqualToString:_choosedLocation]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath != _choosedIndexPath) {
        _choosedLocation = self.data[indexPath.row];
        [_tableView reloadData];
        [self backVC];
    }
}

- (void)returnPlaceBlock:(choicePlaceBlock)block{
    _chosedPlaceBlock = block;
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
