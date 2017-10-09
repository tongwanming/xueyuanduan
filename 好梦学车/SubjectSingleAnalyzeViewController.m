//
//  SubjectSingleAnalyzeViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/5/26.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectSingleAnalyzeViewController.h"
#import "SubjectTwoPopWebViewController.h"

@interface SubjectSingleAnalyzeViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *logoImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation SubjectSingleAnalyzeViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 20, 20, 20)];
        _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_logoImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_logoImageView.frame)+16, 22, CURRENT_BOUNDS.width-100, 16)];
        _titleLabel.textColor = TEXT_COLOR;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

@end

@interface SubjectSingleAnalyzeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *urlArr;



@end

@implementation SubjectSingleAnalyzeViewController

- (NSArray *)data{
    if (!_data) {
        NSMutableArray *data = [[NSMutableArray alloc] init];
        if (self.type == SubjectSingleAnalyzeViewTypeTwo) {
            NSArray *arr1 = @[@"安全带的正确使用",@"点火开关",@"方向盘正确握法",@"离合器",@"油门踏板操作要领",@"制动踏板的使用",@"座椅位置调整",@"后视镜"];
            NSArray *arr2 = @[@"m01",@"m02",@"m03",@"m04",@"m05",@"m06",@"m07",@"m08"];
            for (int i = 0; i < arr1.count; i++) {
                SubjectSingleAnalyzeViewModel *model = [[SubjectSingleAnalyzeViewModel alloc] init];
                model.imageName = arr2[i];
                model.titleName = arr1[i];
                [data addObject:model];
            }
            _urlArr =  @[@"http://assets.haomeng.com/kmeaqddzqsy.html",
                         @"http://assets.haomeng.com/kmedhkg.html",
                         @"http://assets.haomeng.com/kmefxpdzqwf.html",
                         @"http://assets.haomeng.com/kmelhq.html",
                         @"http://assets.haomeng.com/kmeymtbczyl.html",
                         @"http://assets.haomeng.com/kmezdtbdsy.html",
                         @"http://assets.haomeng.com/kmezywztz.html",
                         @"http://assets.haomeng.com/kmehsj.html"];
        }else{
            NSArray *arr1 = @[@"车距判断",@"挡位操作",@"灯光操作",@"后视镜"];
            NSArray *arr2 = @[@"t01",@"t02",@"t03",@"m08"];
            
            for (int i = 0; i < arr1.count; i++) {
                SubjectSingleAnalyzeViewModel *model = [[SubjectSingleAnalyzeViewModel alloc] init];
                model.imageName = arr2[i];
                model.titleName = arr1[i];
                [data addObject:model];
            }
            _urlArr = @[@"http://assets.haomeng.com/kmscjpd.html",
                        @"http://assets.haomeng.com/kmsdwcz.html",
                        @"http://assets.haomeng.com/kmsdgcz.html",
                        @"http://assets.haomeng.com/kmehsj.html"];
        }
        _data = [NSArray arrayWithArray:data];
    }
    return _data;

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [_tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *index = @"index";
    SubjectSingleAnalyzeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:index];
    if (!cell) {
        cell = [[SubjectSingleAnalyzeViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:index];
    }
    cell.logoImageView.image = [UIImage imageNamed:((SubjectSingleAnalyzeViewModel *)self.data[indexPath.row]).imageName];
    cell.titleLabel.text = ((SubjectSingleAnalyzeViewModel *)self.data[indexPath.row]).titleName;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SubjectTwoPopWebViewController *v = [[SubjectTwoPopWebViewController alloc] init];
    SubjectSingleAnalyzeViewModel *model  = _data[indexPath.row];
    v.titleStr = model.titleName;
    v.url = _urlArr[indexPath.row];
    [self.navigationController pushViewController:v animated:YES];
}
- (IBAction)btnclick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
