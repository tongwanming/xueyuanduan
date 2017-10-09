//
//  IPopUpWithPromptView.m
//  Lightning DS
//
//  Created by tongwanming on 15/8/21.
//  Copyright (c) 2015年 com.auralic. All rights reserved.
//

#import "IPopUpWithPromptView.h"
#import "IPopViewModel.h"
#import "IPopView.h"
#import "OffLineServerStation.h"

@interface IPopUpWithPromptPushViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *logoImage;

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UILabel *detailTitleNameLabel;

@end

@implementation IPopUpWithPromptPushViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andWidth:(CGFloat)width{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(16,20, 38, 38)];
        _logoImage.contentMode = UIViewContentModeScaleAspectFit;
        _logoImage.backgroundColor = [UIColor clearColor];
        
        _titleNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(72, 20, width-60, 15)];
        _titleNameLabel.textColor = TEXT_COLOR;
        _titleNameLabel.font = [UIFont systemFontOfSize:15];
        _titleNameLabel.textAlignment = NSTextAlignmentLeft;
        
        _detailTitleNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(72, 45, width-60, 13)];
        _detailTitleNameLabel.textColor = UNMAIN_TEXT_COLOR;
        _detailTitleNameLabel.font = [UIFont systemFontOfSize:13];
        _detailTitleNameLabel.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:_logoImage];
        [self addSubview:_titleNameLabel];
        [self addSubview:_detailTitleNameLabel];
        
    }
    return self;
}

- (void)hight{
    _titleNameLabel.alpha = 0.4;
}

- (void)normal{
    _titleNameLabel.alpha = 1;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:YES];
    if (highlighted) {
        [self hight];
    }else{
        [self normal];
    }
}

@end

@interface IPopUpWithPromptViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleNameLabel;

@property (nonatomic, strong) UILabel *detailTitleNameLabel;

@property (nonatomic, strong) UIImageView *checkedImage;


@end

@implementation IPopUpWithPromptViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andWidth:(CGFloat)width{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        _titleNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 20, width-60, 15)];
        _titleNameLabel.textColor = TEXT_COLOR;
        _titleNameLabel.font = [UIFont systemFontOfSize:15];
        _titleNameLabel.textAlignment = NSTextAlignmentLeft;
        
        _detailTitleNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 45, width-60, 13)];
        _detailTitleNameLabel.textColor = UNMAIN_TEXT_COLOR;
        _detailTitleNameLabel.font = [UIFont systemFontOfSize:13];
        _detailTitleNameLabel.textAlignment = NSTextAlignmentLeft;
        
        _checkedImage = [[UIImageView alloc] initWithFrame:CGRectMake(width-25-16, 27, 20, 20)];
        _checkedImage.contentMode = UIViewContentModeScaleAspectFit;
        _checkedImage.backgroundColor = [UIColor clearColor];
        [self addSubview:_checkedImage];
        [self addSubview:_titleNameLabel];
        [self addSubview:_detailTitleNameLabel];
    }
    return self;
}
- (void)hight{
    _titleNameLabel.alpha = 0.4;
}

- (void)normal{
    _titleNameLabel.alpha = 1;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:YES];
    if (highlighted) {
        [self hight];
    }else{
        [self normal];
    }
}

@end

@implementation IPopUpWithPromptView{
   NSInteger _indexPatnRow;
}

- (void)drawRect:(CGRect)rect{
    _topBackGroundView.layer.masksToBounds = YES;
    _topBackGroundView.layer.cornerRadius = 6;
//    _cancelBtn.layer.cornerRadius = 6;
    _cancelBtnView.layer.masksToBounds = YES;
    _cancelBtnView.layer.cornerRadius = 6;
    _TopLineView.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.1];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTapped)];
    [_topView addGestureRecognizer:tap];
    _indexPatnRow = 0;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableFooterView = nil;
    _tableView.tableHeaderView = nil;
    _tableView.userInteractionEnabled = YES;
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    _titleLabel.textColor = TEXT_COLOR;
   
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [_cancelBtn setTitleColor:LIGHTED_TEXT_COLOR forState:UIControlStateNormal];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleNameDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"indexCell"];

    
    if (self.style == IPopUpWithPromptViewStyleNormal) {
        if (!cell) {
            cell = [[IPopUpWithPromptViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"indexCell" andWidth:_tableView.frame.size.width];
        }
    }else{
        if (!cell) {
            cell = [[IPopUpWithPromptPushViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"indexCell" andWidth:_tableView.frame.size.width];
        }
    }
    
    // 正式
//    IPopViewModel *model = _titleNameDataArray[indexPath.row];
//    cell.titleNameLabel.text = model.FirstTitle;
//    cell.detailTitleNameLabel.text = model.SecondTitle;
    
   
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.style == IPopUpWithPromptViewStyleNormal) {
        if (indexPath.row == _indexPatnRow) {
            ((IPopUpWithPromptViewCell *)cell).checkedImage.image = [UIImage imageNamed:@"btn_box_click"];
        }else{
            ((IPopUpWithPromptViewCell *)cell).checkedImage.image = [UIImage imageNamed:@"btn_box_normal"];
        }
        
        //test
        ((IPopUpWithPromptViewCell *)cell).titleNameLabel.text = ((OffLineServerStation *)_titleNameDataArray[indexPath.row]).name;
        ((IPopUpWithPromptViewCell *)cell).detailTitleNameLabel.text = ((OffLineServerStation *)_titleNameDataArray[indexPath.row]).address;
    }else if (self.style == IPopUpWithPromptViewStylePush){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        //test
        
        if (indexPath.row == 0) {
            ((IPopUpWithPromptPushViewCell *)cell).logoImage.image = [UIImage imageNamed:@"icon_weichat"];
        }else{
            ((IPopUpWithPromptPushViewCell *)cell).logoImage.image = [UIImage imageNamed:@"icon_zhifubao"];
        }
        ((IPopUpWithPromptPushViewCell *)cell).detailTitleNameLabel.text = _titleNameDataArray[indexPath.row];
        ((IPopUpWithPromptPushViewCell *)cell).titleNameLabel.text = _titleNameDataArray[indexPath.row];
        
        
    }else{
    
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return IndexPathOfRowWithHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.style == IPopUpWithPromptViewStyleNormal) {
        _indexPatnRow = indexPath.row;
        [_tableView reloadData];
        if ([self.delegate respondsToSelector:@selector(didSelectCurrentViewItemAtIndex:andStyle:)]) {
            [self.delegate didSelectCurrentViewItemAtIndex:indexPath.row andStyle:self];
            
        }
        [IPopView popClose];
        if ([self.delegate respondsToSelector:@selector(popViewCancelBtnClick)]) {
            [self.delegate popViewCancelBtnClick];
        }
    }else if (self.style == IPopUpWithPromptViewStylePush){
        if ([self.delegate respondsToSelector:@selector(didSelectCurrentViewItemAtIndex:andStyle:)]) {
            [self.delegate didSelectCurrentViewItemAtIndex:indexPath.row andStyle:self];
        }
    }else{
    
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

//cancel 按钮点击
- (IBAction)cancelBtnActive:(id)sender {
    if (self.style == IPopUpWithPromptViewStyleNormal) {
        if ([self.delegate respondsToSelector:@selector(didSelectCurrentViewItemAtIndex:andStyle:)]) {
            [self.delegate didSelectCurrentViewItemAtIndex:_indexPatnRow andStyle:self];
            
        }
    }
    [IPopView popClose];
    if ([self.delegate respondsToSelector:@selector(popViewCancelBtnClick)]) {
        [self.delegate popViewCancelBtnClick];
    }
    
    
}

- (void)tapTapped{
    return;
}


@end
