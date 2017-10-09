//
//  SubjectPractisePageViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/5/15.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectPractisePageViewController.h"
#import "SubjectPractisePageTableViewCell.h"
#import "SubjectPractisePageTitleTableViewCell.h"
#import "SubjectPractisePageFlashTableViewCell.h"
#import "SubjectPractiseSureTableViewCell.h"
#import "SqliteDateManager.h"

#define kRandomColor ([UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0f])

@interface SubjectPractisePageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, assign) BOOL hasImageView;

@property (nonatomic, assign) BOOL hasFlashView;

@property (nonatomic, strong) NSArray *normalImageData;

@property (nonatomic, strong) NSArray *clickImageData;

@property (nonatomic, strong) NSMutableDictionary *cellDic;

@end

@implementation SubjectPractisePageViewController{
    NSMutableArray *_data;
    BOOL _isShow;
    BOOL _isDidSelectActive;
    NSInteger _selectRow;
    NSMutableDictionary *_choosedDic;
    BOOL _isReferAnswer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _isShow = NO;
    _isDidSelectActive = NO;
    _isReferAnswer = NO;
    _choosedDic = [[NSMutableDictionary alloc] init];
    _cellDic = [[NSMutableDictionary alloc] init];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeShowState:) name:@"changeShowState" object:nil];
}

- (void)changeShowState:(NSNotification *)notification{
    _isShow = !_isShow;
   
    [_tableView reloadData];
}

- (void)setModel:(SubjectPractiseModel *)model{
    _model = model;
    _data = [[NSMutableArray alloc] init];
    [_data addObject:model.answer1];
    [_data addObject:model.answer2];
    [_data addObject:model.answer3];
    [_data addObject:model.answer4];
    
    if (model.picUrl && model.picUrl.length > 1) {
        _hasFlashView = YES;
    }
    [_tableView reloadData];
    
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    NSLog(@"_model.type:%@",_model.type);
    
    
    if ([_model.type isEqualToString:@"201"]) {
        return 5;
    }else
        return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger n = 0;
    if (section == 0) {
        n = 1;
    }else if (section == 1){
        n = _hasImageView?1:0;
    }else if (section == 2){
        n = _hasFlashView?1:0;
    }else if (section == 3){
        if ([_model.type isEqualToString:@"202"]) {
            return 2;
        }else{
            return 4;
        }
    }else{
        return 1;
    }
    return n;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 60;
    if (indexPath.section == 0) {
        height = 40 + [self getTitleHeightWithString:_model.question];
    }else if (indexPath.section == 3){
        height = 40 + [self getTitleHeightWithString:_data[indexPath.row]];
    }else if (indexPath.section == 4){
        height = 60;
    }else{
        height = 153;
    }
    return height;
}

- (CGFloat)getTitleHeightWithString:(NSString *)title{
    CGRect rect = [title boundingRectWithSize:CGSizeMake(CURRENT_BOUNDS.width-52, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    return rect.size.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *index = @"";
    UITableViewCell *cell = [_cellDic objectForKey:indexPath];
    if (indexPath.section == 0) {
        if (!cell) {
            cell = [[SubjectPractisePageTitleTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:index];
            [_cellDic setObject:cell forKey:indexPath];
        }
        if ([_model.type isEqualToString:@"200"]) {
            ((SubjectPractisePageTitleTableViewCell *)cell).titleStr1 = @"单选";
        }else if([_model.type isEqualToString:@"201"]){
            ((SubjectPractisePageTitleTableViewCell *)cell).titleStr1 = @"多选";
        }else{
            ((SubjectPractisePageTitleTableViewCell *)cell).titleStr1 = @"判断";
        }
        ((SubjectPractisePageTitleTableViewCell *)cell).titleStr2 = _model.question;
        cell.backgroundColor = [UIColor clearColor];
    }else if (indexPath.section == 1){
    
    }else if (indexPath.section == 2){
        if (!cell) {
            cell = [[SubjectPractisePageFlashTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:index];
            [_cellDic setObject:cell forKey:indexPath];
        }
        ((SubjectPractisePageFlashTableViewCell *)cell).url = _model.picUrl;
        cell.backgroundColor = [UIColor clearColor];
        
    }else if (indexPath.section == 3){
        if (!cell) {
            cell = [[SubjectPractisePageTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:index];
            [_cellDic setObject:cell forKey:indexPath];
        }
        ((SubjectPractisePageTableViewCell *)cell).titileStr = _data[indexPath.row];
        if ([_model.type isEqualToString:@"202"]) {
            if (_isDidSelectActive) {
                if ([[self getAnswerData][indexPath.row] isEqualToString:_model.answer]) {
                    ((SubjectPractisePageTableViewCell *)cell).logoImageView.image = [UIImage imageNamed:@"right"];
                }
                if (_selectRow == indexPath.row && ![[self getAnswerData][_selectRow] isEqualToString:_model.answer]) {
                    ((SubjectPractisePageTableViewCell *)cell).logoImageView.image = [UIImage imageNamed:@"fault"];
                }
            }else{
                ((SubjectPractisePageTableViewCell *)cell).logoImageView.image = nil;
            }
            
        }else if ([_model.type isEqualToString:@"201"]){
            if (_isDidSelectActive) {
                if (_choosedDic.allValues == nil || _choosedDic.allValues.count < 1) {
                     ((SubjectPractisePageTableViewCell *)cell).logoImageView.image = [UIImage imageNamed:self.normalImageData[indexPath.row]];
                }else{
                    if (!_isReferAnswer) {
                        NSString *answer = [_choosedDic objectForKey:@(indexPath.row)];
                        if (answer) {
                            ((SubjectPractisePageTableViewCell *)cell).logoImageView.image = [UIImage imageNamed:self.clickImageData[indexPath.row]];
                        }else{
                             ((SubjectPractisePageTableViewCell *)cell).logoImageView.image = [UIImage imageNamed:self.normalImageData[indexPath.row]];
                        }
                    }else{
                        BOOL _isTrue = NO;
                        for (NSString *a in _choosedDic.allValues) {
                            if ([a isEqualToString:[self getAnswerData][indexPath.row] ]) {
                                _isTrue = YES;
                            }
                        }
                        if (_isTrue) {
                            ((SubjectPractisePageTableViewCell *)cell).logoImageView.image = [UIImage imageNamed:@"right"];
                        }else{
                            ((SubjectPractisePageTableViewCell *)cell).logoImageView.image = [UIImage imageNamed:@"fault"];
                        }
                    }
                    
                }
            }else{
                 ((SubjectPractisePageTableViewCell *)cell).logoImageView.image = [UIImage imageNamed:self.normalImageData[indexPath.row]];
            }
           
        }else{
            if (_isDidSelectActive) {
                if ([[self getAnswerData][indexPath.row] isEqualToString:_model.answer]) {
                    ((SubjectPractisePageTableViewCell *)cell).logoImageView.image = [UIImage imageNamed:@"right"];
                }
                if (_selectRow == indexPath.row && ![[self getAnswerData][_selectRow] isEqualToString:_model.answer]) {
                    ((SubjectPractisePageTableViewCell *)cell).logoImageView.image = [UIImage imageNamed:@"fault"];
                }
            }else{
                ((SubjectPractisePageTableViewCell *)cell).logoImageView.image = [UIImage imageNamed:self.normalImageData[indexPath.row]];
            }
            
        }
        
    }else{
        if (!cell) {
            cell = [[SubjectPractiseSureTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:index];
            [_cellDic setObject:cell forKey:indexPath];
        }
        ((SubjectPractiseSureTableViewCell *)cell).dic = _choosedDic;
        cell.backgroundColor = [UIColor clearColor];
    }

    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (_isShow) {
        if ([self.delegate respondsToSelector:@selector(showBtnState:)]) {
            [self.delegate performSelector:@selector(showBtnState:) withObject:@"YES"];
        }
    }else{
        if ([self.delegate respondsToSelector:@selector(showBtnState:)]) {
            [self.delegate performSelector:@selector(showBtnState:) withObject:@"NO"];
        }
    }
    
    if (section == 3 && ![_model.type isEqualToString:@"201"]) {
        if (_isShow) {
            return 91+21+16+16+[self getDescribeHeightWithString:_model.explain] + 20+ 28 +11 + 100;
        }else
            return CGFLOAT_MIN;
        
    }else if (section == 4 && [_model.type isEqualToString:@"201"]){
        if (_isShow) {
            return 91+21+16+16+[self getDescribeHeightWithString:_model.explain] + 20+ 28 +11 + 100;
        }else
            return CGFLOAT_MIN;
    }else
        return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([_model.type isEqualToString:@"201"]) {
            _isDidSelectActive = YES;
            if (indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2) {
                return;
            }else if (indexPath.section == 3){
                //选择答案
                if ([_choosedDic objectForKey:@(indexPath.row)]) {
                    if (_choosedDic.allValues.count == 1) {
                        [_choosedDic removeAllObjects];
                    }else{
                        [_choosedDic removeObjectForKey:@(indexPath.row)];
                    }
                    
                }else{
                    [_choosedDic setObject:[self getAnswerData][indexPath.row] forKey:@(indexPath.row)];
                }
                
                [_tableView reloadData];
            }else{
                if (_choosedDic.allValues.count < 2) {
                    [_tableView reloadData];
                    return;
                }
                //提交答案
                NSArray *arr = _choosedDic.allValues;
                NSString *str = [arr componentsJoinedByString:@""];
                
                if ([str isEqualToString:_model.answer]) {
                    if ([self.delegate respondsToSelector:@selector(SubjectPractisePagViewSelectWithAnswer:andIndex:)]) {
                        [self.delegate performSelector:@selector(SubjectPractisePagViewSelectWithAnswer:andIndex:) withObject:@"YES" withObject:_index];
                    }
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSMutableString *str = [NSMutableString stringWithString:_model.answer];
                        for (int i = 0; i < str.length-1; i++) {
//                            NSLog(@"%d",i);
                            if (i*2+1 <= str.length) {
                                [str insertString:@"," atIndex:(i*2+1)];
                            }
                            
                        }
                        NSArray *answerData = [str componentsSeparatedByString:@","];
                        [_choosedDic removeAllObjects];
                        
                        for (int i = 0; i < answerData.count; i++) {
                            [_choosedDic setObject:answerData[i] forKey:@(i)];
                        }
                        _isReferAnswer = YES;
                        if (!_isShow) {
                            _isShow = YES;
                            
                        }
                        [_tableView reloadData];
                        if (self.practiseType == PractiseViewControllerTypeForth || self.practiseType == PractiseViewControllerTypeForthMistake || self.practiseType == PractiseViewControllerTypeForthSpecial || self.practiseType == PractiseViewControllerTypeForthCollection) {
                            _model.sqliteType = @"myMistakef";
                        }else{
                            _model.sqliteType = @"myMistake";
                        }
                        
                        [[SqliteDateManager sharedManager] addSubjectPractiseModel:_model];
                        if ([self.delegate respondsToSelector:@selector(SubjectPractisePagViewSelectWithAnswer:andIndex:)]) {
                            [self.delegate performSelector:@selector(SubjectPractisePagViewSelectWithAnswer:andIndex:) withObject:@"NO" withObject:_index];
                        }
                    });
                }
            }
        }else{
            if (_isDidSelectActive || indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2) {
                return;
            }
            
            _selectRow = indexPath.row;
            _isDidSelectActive = YES;
            if (!_isShow) {
                _isShow = YES;
                
            } [_tableView reloadData];
            
            NSString *answer = [self getAnswerData][indexPath.row];
            if ([answer isEqualToString:_model.answer]) {
                if ([self.delegate respondsToSelector:@selector(SubjectPractisePagViewSelectWithAnswer:andIndex:)]) {
                    [self.delegate performSelector:@selector(SubjectPractisePagViewSelectWithAnswer:andIndex:) withObject:@"YES" withObject:_index];
                }
            }else{
                if (self.practiseType == PractiseViewControllerTypeForth || self.practiseType == PractiseViewControllerTypeForthMistake || self.practiseType == PractiseViewControllerTypeForthSpecial || self.practiseType == PractiseViewControllerTypeForthCollection) {
                    _model.sqliteType = @"myMistakef";
                }else{
                    _model.sqliteType = @"myMistake";
                }
                [[SqliteDateManager sharedManager] addSubjectPractiseModel:_model];
                if ([self.delegate respondsToSelector:@selector(SubjectPractisePagViewSelectWithAnswer:andIndex:)]) {
                    [self.delegate performSelector:@selector(SubjectPractisePagViewSelectWithAnswer:andIndex:) withObject:@"NO" withObject:_index];
                }
            }
        } 
    });
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if ([_model.type isEqualToString:@"201"] && section == 4) {
        if (_isShow) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, 91+21+16+16+[self getDescribeHeightWithString:_model.explain] + 20+ 28 +11)];
            view.backgroundColor = [UIColor whiteColor];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 21, CURRENT_BOUNDS.width, 16)];
            titleLabel.font = [UIFont systemFontOfSize:16];
            titleLabel.textColor = TEXT_COLOR;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.text = @"试题解析";
            [view addSubview:titleLabel];
            
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame)+20, 40, 20)];
            label1.font = [UIFont systemFontOfSize:16];
            label1.textColor = TEXT_COLOR;
            label1.textAlignment = NSTextAlignmentCenter;
            label1.text = @"考点";
            //        label1.backgroundColor = [UIColor redColor];
            [view addSubview:label1];
            
            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame)+5, CGRectGetMaxY(titleLabel.frame)+20, 30, 20)];
            label2.font = [UIFont systemFontOfSize:12];
            label2.textColor = BLUE_BACKGROUND_COLOR;
            label2.textAlignment = NSTextAlignmentCenter;
            if ([_model.type isEqualToString:@"200"]) {
                label2.text = @"单选";
            }else if([_model.type isEqualToString:@"201"]){
                label2.text = @"多选";
            }else{
                label2.text = @"判断";
            }
            label2.layer.cornerRadius = 3;
            label2.layer.masksToBounds = YES;
            label2.layer.borderWidth = 1;
            label2.layer.borderColor = BLUE_BACKGROUND_COLOR.CGColor;
            [view addSubview:label2];
            
            UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label2.frame)+10, CGRectGetMaxY(titleLabel.frame)+20, 40, 20)];
            label3.font = [UIFont systemFontOfSize:12];
            label3.textColor = BLUE_BACKGROUND_COLOR;
            label3.textAlignment = NSTextAlignmentCenter;
            label3.text = @"交规";
            label3.layer.cornerRadius = 3;
            label3.layer.masksToBounds = YES;
            label3.layer.borderWidth = 1;
            label3.layer.borderColor = BLUE_BACKGROUND_COLOR.CGColor;
            [view addSubview:label3];
            
            UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label3.frame)+10, CGRectGetMaxY(titleLabel.frame)+20, 50, 20)];
            label4.font = [UIFont systemFontOfSize:12];
            label4.textColor = FF8400;
            label4.textAlignment = NSTextAlignmentCenter;
            if ([_model.difficlty isEqualToString:@"4"] || [_model.difficlty isEqualToString:@"5"]) {
                label4.text = @"易错题";
            }else{
                label4.text = @"容易题";
            }
            
            label4.layer.cornerRadius = 3;
            label4.layer.masksToBounds = YES;
            label4.layer.borderWidth = 1;
            label4.layer.borderColor = FF8400.CGColor;
            [view addSubview:label4];
            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 91, CURRENT_BOUNDS.width, 0.5)];
            lineView.backgroundColor = ADB1B9;
            [view addSubview:lineView];
            
            UILabel *answerLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(lineView.frame)+21, CURRENT_BOUNDS.width-20, 20)];
            answerLabel.font = [UIFont systemFontOfSize:16];
            answerLabel.textColor = TEXT_COLOR;
            answerLabel.textAlignment = NSTextAlignmentLeft;
            answerLabel.text = [NSString stringWithFormat:@"答案：%@",_model.answer];
            [view addSubview:answerLabel];
            
            UILabel *describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(answerLabel.frame)+16, CURRENT_BOUNDS.width-20, 100)];
            describeLabel.font = [UIFont systemFontOfSize:16];
            describeLabel.textColor = TEXT_COLOR;
            describeLabel.textAlignment = NSTextAlignmentLeft;
            describeLabel.text = _model.explain;
            describeLabel.numberOfLines = 0;
            //        describeLabel.backgroundColor = [UIColor redColor];
            describeLabel.frame = CGRectMake(16, CGRectGetMaxY(answerLabel.frame)+16, CURRENT_BOUNDS.width-20, [self getDescribeHeightWithString:_model.explain]);
            //        NSLog(@"描述的高度：%lf",[self getDescribeHeightWithString:_model.explain]);
            [view addSubview:describeLabel];
            
            UILabel *mistakeType = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(describeLabel.frame)+20, 100, 14)];
            mistakeType.font = [UIFont systemFontOfSize:14];
            mistakeType.textColor = ADB1B9;
            mistakeType.text = @"出错率：";
            mistakeType.textAlignment = NSTextAlignmentLeft;
            [view addSubview:mistakeType];
            
            UILabel *mistakeTypeAnswer = [[UILabel alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width-150, CGRectGetMaxY(describeLabel.frame)+20, 130, 14)];
            mistakeTypeAnswer.font = [UIFont systemFontOfSize:14];
            mistakeTypeAnswer.textColor = ADB1B9;
            mistakeTypeAnswer.text = @"考友出错率16%";
            mistakeTypeAnswer.textAlignment = NSTextAlignmentRight;
            [view addSubview:mistakeTypeAnswer];
            
            UILabel *totalEsercise = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(mistakeType.frame)+20, 100, 14)];
            totalEsercise.font = [UIFont systemFontOfSize:14];
            totalEsercise.textColor = ADB1B9;
            totalEsercise.text = @"做题统计：";
            totalEsercise.textAlignment = NSTextAlignmentLeft;
            [view addSubview:totalEsercise];
            
            UILabel *totalEserciseAnswer = [[UILabel alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width-150, CGRectGetMaxY(mistakeType.frame)+20, 130, 14)];
            totalEserciseAnswer.font = [UIFont systemFontOfSize:14];
            totalEserciseAnswer.textColor = ADB1B9;
            totalEserciseAnswer.text = @"共做过2次，做错1次";
            totalEserciseAnswer.textAlignment = NSTextAlignmentRight;
            [view addSubview:totalEserciseAnswer];
            
            return view;
        }else
            return nil;
    }else if (section == 3 && ![_model.type isEqualToString:@"201"]) {
        if (_isShow) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width, 91+21+16+16+[self getDescribeHeightWithString:_model.explain] + 20+ 28 +11)];
            view.backgroundColor = [UIColor whiteColor];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 21, CURRENT_BOUNDS.width, 16)];
            titleLabel.font = [UIFont systemFontOfSize:16];
            titleLabel.textColor = TEXT_COLOR;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.text = @"试题解析";
            [view addSubview:titleLabel];
            
            UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame)+20, 40, 20)];
            label1.font = [UIFont systemFontOfSize:16];
            label1.textColor = TEXT_COLOR;
            label1.textAlignment = NSTextAlignmentCenter;
            label1.text = @"考点";
            //        label1.backgroundColor = [UIColor redColor];
            [view addSubview:label1];
            
            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame)+5, CGRectGetMaxY(titleLabel.frame)+20, 30, 20)];
            label2.font = [UIFont systemFontOfSize:12];
            label2.textColor = BLUE_BACKGROUND_COLOR;
            label2.textAlignment = NSTextAlignmentCenter;
            if ([_model.type isEqualToString:@"200"]) {
                label2.text = @"单选";
            }else if([_model.type isEqualToString:@"201"]){
                label2.text = @"多选";
            }else{
                label2.text = @"判断";
            }
            label2.layer.cornerRadius = 3;
            label2.layer.masksToBounds = YES;
            label2.layer.borderWidth = 1;
            label2.layer.borderColor = BLUE_BACKGROUND_COLOR.CGColor;
            [view addSubview:label2];
            
            UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label2.frame)+10, CGRectGetMaxY(titleLabel.frame)+20, 40, 20)];
            label3.font = [UIFont systemFontOfSize:12];
            label3.textColor = BLUE_BACKGROUND_COLOR;
            label3.textAlignment = NSTextAlignmentCenter;
            label3.text = @"交规";
            label3.layer.cornerRadius = 3;
            label3.layer.masksToBounds = YES;
            label3.layer.borderWidth = 1;
            label3.layer.borderColor = BLUE_BACKGROUND_COLOR.CGColor;
            [view addSubview:label3];
            
            UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label3.frame)+10, CGRectGetMaxY(titleLabel.frame)+20, 50, 20)];
            label4.font = [UIFont systemFontOfSize:12];
            label4.textColor = FF8400;
            label4.textAlignment = NSTextAlignmentCenter;
            if ([_model.difficlty isEqualToString:@"4"] || [_model.difficlty isEqualToString:@"5"]) {
                label4.text = @"易错题";
            }else{
                label4.text = @"容易题";
            }
            label4.layer.cornerRadius = 3;
            label4.layer.masksToBounds = YES;
            label4.layer.borderWidth = 1;
            label4.layer.borderColor = FF8400.CGColor;
            [view addSubview:label4];
            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 91, CURRENT_BOUNDS.width, 0.5)];
            lineView.backgroundColor = ADB1B9;
            [view addSubview:lineView];
            
            UILabel *answerLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(lineView.frame)+21, CURRENT_BOUNDS.width-20, 20)];
            answerLabel.font = [UIFont systemFontOfSize:16];
            answerLabel.textColor = TEXT_COLOR;
            answerLabel.textAlignment = NSTextAlignmentLeft;
            answerLabel.text = [NSString stringWithFormat:@"答案：%@",_model.answer];
            [view addSubview:answerLabel];
            
            UILabel *describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(answerLabel.frame)+16, CURRENT_BOUNDS.width-20, 100)];
            describeLabel.font = [UIFont systemFontOfSize:16];
            describeLabel.textColor = TEXT_COLOR;
            describeLabel.textAlignment = NSTextAlignmentLeft;
            describeLabel.text = _model.explain;
            describeLabel.numberOfLines = 0;
            //        describeLabel.backgroundColor = [UIColor redColor];
            describeLabel.frame = CGRectMake(16, CGRectGetMaxY(answerLabel.frame)+16, CURRENT_BOUNDS.width-20, [self getDescribeHeightWithString:_model.explain]);
            //        NSLog(@"描述的高度：%lf",[self getDescribeHeightWithString:_model.explain]);
            [view addSubview:describeLabel];
            
            UILabel *mistakeType = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(describeLabel.frame)+20, 100, 14)];
            mistakeType.font = [UIFont systemFontOfSize:14];
            mistakeType.textColor = ADB1B9;
            mistakeType.text = @"出错率：";
            mistakeType.textAlignment = NSTextAlignmentLeft;
            [view addSubview:mistakeType];
            
            UILabel *mistakeTypeAnswer = [[UILabel alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width-150, CGRectGetMaxY(describeLabel.frame)+20, 130, 14)];
            mistakeTypeAnswer.font = [UIFont systemFontOfSize:14];
            mistakeTypeAnswer.textColor = ADB1B9;
            mistakeTypeAnswer.text = @"考友出错率16%";
            mistakeTypeAnswer.textAlignment = NSTextAlignmentRight;
            [view addSubview:mistakeTypeAnswer];
            
            UILabel *totalEsercise = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(mistakeType.frame)+20, 100, 14)];
            totalEsercise.font = [UIFont systemFontOfSize:14];
            totalEsercise.textColor = ADB1B9;
            totalEsercise.text = @"做题统计：";
            totalEsercise.textAlignment = NSTextAlignmentLeft;
            [view addSubview:totalEsercise];
            
            UILabel *totalEserciseAnswer = [[UILabel alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width-150, CGRectGetMaxY(mistakeType.frame)+20, 130, 14)];
            totalEserciseAnswer.font = [UIFont systemFontOfSize:14];
            totalEserciseAnswer.textColor = ADB1B9;
            totalEserciseAnswer.text = @"共做过2次，做错1次";
            totalEserciseAnswer.textAlignment = NSTextAlignmentRight;
            [view addSubview:totalEserciseAnswer];
            
            
            
            
            
            return view;
        }else
            return nil;
        
    }else
        return nil;
    
}

- (CGFloat)getDescribeHeightWithString:(NSString *)title{
    CGRect rect = [title boundingRectWithSize:CGSizeMake(CURRENT_BOUNDS.width-52, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil];
    return rect.size.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)normalImageData{
    if (!_normalImageData) {
        _normalImageData = @[@"a_normal",@"b_normal",@"c_normal",@"d_normal"];
    }
    return _normalImageData;
}

- (NSArray *)clickImageData{
    if (!_clickImageData) {
        _clickImageData = @[@"a_click",@"b_click",@"c_click",@"d_click"];
    }
    return _clickImageData;
}

- (NSArray *)getAnswerData{
    NSArray *array;
    if ([_model.type isEqualToString:@"200"]) {
        array = @[@"A",@"B",@"C",@"D"];
    }else if ([_model.type isEqualToString:@"201"]){
        array = @[@"A",@"B",@"C",@"D"];
    }else{
        array = @[@"A",@"B"];
    }
    return array;
}


@end
