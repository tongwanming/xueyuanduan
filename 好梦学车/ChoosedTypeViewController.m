//
//  ChoosedTypeViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/4/27.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "ChoosedTypeViewController.h"

@interface ChoosedTypeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ChoosedTypeViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    if (_personSettingView) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    if (_personSettingView) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"报名类型";
    
    self.navigationItem.hidesBackButton = YES;
    
    UIButton *letBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [letBtn setImage:[UIImage imageNamed:@"btn_back_gray"] forState:UIControlStateNormal];
    letBtn.contentMode = UIViewContentModeScaleAspectFit;
    //    letBtn.backgroundColor = [UIColor redColor];
    [letBtn addTarget:self action:@selector(leftBtnActive:) forControlEvents:UIControlEventTouchUpInside];
    letBtn.frame = CGRectMake(0, 0, 40, 40);
    [letBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:letBtn];
    
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    // Do any additional setup after loading the view from its nib.
}

- (void)leftBtnActive:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)returnSelectTypeWithBlock:(selectTypeBlock)block{
    self.selectType = block;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *index = @"index";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:index];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:index];
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    if (self.choosedType.length >1) {
        if ([self.choosedType isEqualToString:_data[indexPath.row]]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }else{
        if (indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
    }
   
    cell.textLabel.text = _data[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    cell.textLabel.textColor = TEXT_COLOR;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (self.selectType != nil) {
        self.selectType(cell.textLabel.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
