//
//  LearningProgressTwoViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/7/10.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "LearningProgressTwoViewController.h"
#import "myLearningTapView.h"
#import "UILabel+changeLineSpace.h"

@interface projectTwoTableViewCell: UITableViewCell

@property (nonatomic, strong) NSString *title1Str;

@property (nonatomic, strong) NSString *title2Str;

@property (nonatomic, strong) NSString *title3Str;

@property (nonatomic, strong) NSString *title4Str;

@property (nonatomic, assign) NSInteger title1Font;

@property (nonatomic, assign) BOOL initRefresh;

@end

@implementation projectTwoTableViewCell{
    UILabel *_label1;
    UILabel *_label2;
    UILabel *_label3;
    UILabel *_label4;
     UIView *backGroundView;
}

- (CGFloat) heightForString:(NSString *)string andFontOfSize:(CGFloat)fontSize andWidth:(CGFloat)width{
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:options attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
    
    CGFloat realHeight = ceilf(rect.size.height);
    return realHeight;
}

- (void)setInitRefresh:(BOOL)initRefresh{
    if (initRefresh) {
        _label1.text = @"";
        _label2.text = @"";
        _label3.text = @"";
        _label4.text = @"";
    }else{
        
    }
}

- (void)setTitle1Str:(NSString *)title1Str{
    _label1.text = title1Str;
    _label1.hidden = NO;
    backGroundView.frame = CGRectMake(20, 5, CURRENT_BOUNDS.width-40, 140-29*3);
    CGFloat _height = [self heightForString:title1Str andFontOfSize:14*TYPERATION andWidth:backGroundView.frame.size.width-40];
    if (_height > 17) {
        _label1.frame = CGRectMake(20, (backGroundView.frame.size.height-14)/2, backGroundView.frame.size.width-40, _height);
    }else{
        _label1.frame = CGRectMake(20, (backGroundView.frame.size.height-14)/2, backGroundView.frame.size.width-40, 14);
    }
}

- (void)setTitle2Str:(NSString *)title2Str{
    CGFloat _height1 = [self heightForString:_label1.text andFontOfSize:14*TYPERATION andWidth:backGroundView.frame.size.width-40];
    if (_height1 > 17) {
        _label1.frame = CGRectMake(20, 15, backGroundView.frame.size.width-40, _height1);
    }else{
        _label1.frame = CGRectMake(20, 15, backGroundView.frame.size.width-40, 14);
    }
    
    _label2.text = title2Str;
    _label2.hidden = NO;
    CGFloat _height = [self heightForString:title2Str andFontOfSize:14*TYPERATION andWidth:backGroundView.frame.size.width-40];
    _label2.frame = CGRectMake(20, CGRectGetMaxY(_label1.frame)+15, backGroundView.frame.size.width-40, _height);
    backGroundView.frame = CGRectMake(20, 5, CURRENT_BOUNDS.width-40, 155-29*2);
}

- (void)setTitle3Str:(NSString *)title3Str{
    _label3.text = title3Str;
    _label3.hidden = NO;
    _label3.frame = CGRectMake(20, CGRectGetMaxY(_label2.frame)+15, backGroundView.frame.size.width-40, 14);
    backGroundView.frame = CGRectMake(20, 5, CURRENT_BOUNDS.width-40, 155-29);
}

- (void)setTitle4Str:(NSString *)title4Str{
    _label4.text = title4Str;
    _label4.hidden = NO;
    _label4.frame = CGRectMake(20, CGRectGetMaxY(_label3.frame)+15, backGroundView.frame.size.width-40, 14);
    backGroundView.frame = CGRectMake(20, 5, CURRENT_BOUNDS.width-40, 140);
}

- (void)setTitle1Font:(NSInteger)title1Font{
    //    _label1.frame = CGRectMake(20, 14, 200, title1Font);
    _label1.font = [UIFont systemFontOfSize:title1Font*TYPERATION];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        backGroundView = [[UIView alloc] initWithFrame:CGRectMake(20, 5, CURRENT_BOUNDS.width-40, self.frame.size.height-25)];
        backGroundView.layer.masksToBounds = YES;
        backGroundView.layer.cornerRadius = 4;
        backGroundView.backgroundColor = F7F7F7;
        [self addSubview:backGroundView];
        
        _label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, CURRENT_BOUNDS.width-60, 14)];
        _label1.text = @"报名流程：";
        _label1.textColor = UNMAIN_TEXT_COLOR;
        _label1.font = [UIFont systemFontOfSize:14*TYPERATION];
        _label1.numberOfLines = 0;
        _label1.hidden = YES;
        
        [backGroundView addSubview:_label1];
        
        _label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_label1.frame)+15, backGroundView.frame.size.width-40, 14)];
        _label2.text = @"1、提交资料：身份、6张一寸白底证件照";
        _label2.textColor = UNMAIN_TEXT_COLOR;
        _label2.font = [UIFont systemFontOfSize:14*TYPERATION];
        _label2.hidden = YES;
        _label2.numberOfLines = 0;
        [backGroundView addSubview:_label2];
        
        _label3 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_label2.frame)+15, backGroundView.frame.size.width-40, 14)];
        _label3.text = @"2、外地户口需要提供暂住证；增加者需要提供原驾驶证";
        _label3.textColor = UNMAIN_TEXT_COLOR;
        _label3.font = [UIFont systemFontOfSize:14*TYPERATION];
        _label3.hidden = YES;
        _label3.numberOfLines = 0;
        [backGroundView addSubview:_label3];
        
        _label4 = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(_label3.frame)+15, backGroundView.frame.size.width-40, 14)];
        _label4.text = @"3、考试承诺抱过。";
        _label4.textColor = UNMAIN_TEXT_COLOR;
        _label4.font = [UIFont systemFontOfSize:14*TYPERATION];
        _label4.hidden = YES;
        _label4.numberOfLines = 0;
        [backGroundView addSubview:_label4];
    }
    
    return self;
}

@end

@interface LearningProgressTwoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation LearningProgressTwoViewController{
    NSMutableDictionary *_sectionData;
    NSMutableDictionary *_cellStateData;
    NSArray *_titleData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sectionData = [[NSMutableDictionary alloc] init];
    _cellStateData = [[NSMutableDictionary alloc] init];
    _titleData = @[@"场地训练",@"科目二考试"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _titleData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSString *style = [_cellStateData objectForKey:[NSString stringWithFormat:@"cellData%ld",section]];
    if (style && [style isEqualToString:@"selected"]) {
        return 1;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section== 0) {
        return 200;
    }
    return 62;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 280/2+10-29+15;
    }else if (indexPath.section == 1){
        return 280/2+10-29+15+15;
    }else
        return 300/2+10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    myLearningTapView *view  = [_sectionData objectForKey:[NSString stringWithFormat:@"%ld",section]];
    if (!view) {
        view =  [[myLearningTapView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, 62) andName:_titleData[section] andProgress:@"3" andIndexPath:section andBloc:^(NSString *style, NSInteger index) {
            NSLog(@"%@--- %ld",style,(long)index);
            [_cellStateData setObject:style forKey:[NSString stringWithFormat:@"cellData%ld",index]];
            if ([style isEqualToString:@"normal"]) {
                [_tableView beginUpdates];
                [_tableView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationFade];
                [_tableView endUpdates];
            }else{
                [_tableView beginUpdates];
                [_tableView reloadSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationFade];
                [_tableView endUpdates];
            }
        }];
        [_sectionData setObject:view forKey:[NSString stringWithFormat:@"%ld",section]];
        
    }
    
    
    view.backgroundColor = [UIColor whiteColor];
    
    if (section == 0) {
        
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, 200)];
        backView.backgroundColor = [UIColor whiteColor];
        view.frame = CGRectMake(0, 200-62, CURRENT_BOUNDS.width, 62);
        [backView addSubview:view];
        
        UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30, 23, 22)];
        logoImageView.image = [UIImage imageNamed:@"icon_study_two"];
        [backView addSubview:logoImageView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(logoImageView.frame)+12, 30, CURRENT_BOUNDS.width-100, 22)];
        titleLabel.text = @"科目二介绍";
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        titleLabel.textColor = TEXT_COLOR;
        [backView addSubview:titleLabel];
        
        UILabel *desLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(logoImageView.frame)+25, CURRENT_BOUNDS.width-40, 110)];
        desLabel.textColor = UNMAIN_TEXT_COLOR;
        desLabel.numberOfLines = 0;
        desLabel.font = [UIFont systemFontOfSize:16*TYPERATION];
        desLabel.minimumScaleFactor = 5;
        desLabel.text = @"科目二，又称小路考，考试项目包括倒车入库、侧方位停车、坡道定点、直角转弯、曲线行驶。";
        [desLabel changeLineSpaceForLabel:desLabel WithSpace:6];
        [backView addSubview:desLabel];
        
        return backView;
    }
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *index = @"index";
    projectTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:index];
    if (!cell) {
        cell = [[projectTwoTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:index];
    }
    cell.initRefresh = YES;
    if (indexPath.section == 0) {
        cell.title1Str = @"1.科一考试通过后，联系好梦售后人员安排场训教练";
        cell.title2Str = @"2.收到教练电话，约定练车时间";
        cell.title3Str = @"3.准时参加每次场训学习";
        
        cell.title1Font = 14;
    }else if (indexPath.section == 1){
        cell.title1Str = @"1.电脑登录http://cq.122.gov.cn，预约科二考试";
        cell.title2Str = @"2.预约考试时间前3-5个工作日，手机收到预约成功提示短信";
        cell.title3Str = @"3.带身份证，按时前往考场参加考试";
        cell.title1Font = 14;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
