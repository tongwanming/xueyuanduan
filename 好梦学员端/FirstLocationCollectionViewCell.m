//
//  FirstLocationCollectionViewCell.m
//  好梦学车
//
//  Created by haomeng on 2017/5/3.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "FirstLocationCollectionViewCell.h"
#import "CatStyleApplyNowBtn.h"
//#import "Masonry.h"

@interface FirstLocationCollectionViewCell ()

@property (nonatomic, strong) UIImageView *backGrondImageView;

@property (nonatomic, strong) UILabel *distanceLabel;

@property (nonatomic, strong) UILabel *locationNameLabel;

@property (nonatomic, strong) CatStyleApplyNowBtn *goNowBtn;

@end

@implementation FirstLocationCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)setChoosed:(BOOL)choosed{
    _choosed = choosed;
    _backGrondImageView.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
    _distanceLabel.textColor = UNMAIN_TEXT_COLOR;
    _locationNameLabel.textColor = TEXT_COLOR;
    [_goNowBtn setTitleColor:UNMAIN_TEXT_COLOR forState:UIControlStateNormal];
    [_goNowBtn setImage:[UIImage imageNamed:@"go_gray"] forState:UIControlStateNormal];
//    if (_choosed) {
//       _backGrondImageView.backgroundColor = [UIColor colorWithRed:0.88f green:0.95f blue:0.99f alpha:1.00f];
//        _distanceLabel.textColor = SELECT_TEXT_COLOR;
//        _locationNameLabel.textColor = SELECT_TEXT_COLOR;
//        [_goNowBtn setTitleColor:SELECT_TEXT_COLOR forState:UIControlStateNormal];
//        [_goNowBtn setImage:[UIImage imageNamed:@"go_blue"] forState:UIControlStateNormal];
//        
//    }else{
//        _backGrondImageView.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
//        _distanceLabel.textColor = UNMAIN_TEXT_COLOR;
//        _locationNameLabel.textColor = TEXT_COLOR;
//        [_goNowBtn setTitleColor:UNMAIN_TEXT_COLOR forState:UIControlStateNormal];
//         [_goNowBtn setImage:[UIImage imageNamed:@"go_gray"] forState:UIControlStateNormal];
//    }
}

- (void)setModel:(FirstLocationModel *)model{
    _model = model;
//    _backGrondImageView.image = [UIImage imageNamed:_model.backGroundImageName];
    _distanceLabel.text = _model.distance;
    _locationNameLabel.text = _model.name;
}

- (void)initialize{
    self.layer.doubleSided = NO;
    
    _backGrondImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 110)];
//    _backGrondImageView.image = [UIImage imageNamed:_model.backGroundImageName];
    _backGrondImageView.backgroundColor = [UIColor colorWithRed:0.96f green:0.96f blue:0.96f alpha:1.00f];
    _backGrondImageView.layer.cornerRadius = 8;
    _backGrondImageView.layer.masksToBounds = YES;
    [self addSubview:_backGrondImageView];
//    [_backGrondImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.top);
//        make.left.equalTo(self.left);
//        make.right.equalTo(self.right);
//        make.height.equalTo(110);
//    }];
    
    _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 16, self.frame.size.width-16, 11)];
    _distanceLabel.font = [UIFont systemFontOfSize:11];
    _distanceLabel.textColor = UNMAIN_TEXT_COLOR;
    _distanceLabel.text = _model.distance;
    [self addSubview:_distanceLabel];
//    [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.top).offset(16);
//        make.left.equalTo(self.left).offset(16);
//        make.height.equalTo(11);
//        make.right.equalTo(self.right);
//    }];
    
    _locationNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_distanceLabel.frame)+10, _distanceLabel.frame.size.width, 15)];
    _locationNameLabel.font = [UIFont boldSystemFontOfSize:13];
    _locationNameLabel.textColor = TEXT_COLOR;
    _locationNameLabel.text = _model.LocationName;
//    _locationNameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_locationNameLabel];
//    [_locationNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_distanceLabel.left);
//        make.top.equalTo(_distanceLabel.bottom).offset(10);
//        make.right.equalTo(_distanceLabel.right);
//        make.height.equalTo(15);
//    }];
    
    _goNowBtn = [CatStyleApplyNowBtn buttonWithType:UIButtonTypeCustom];
    _goNowBtn.frame = CGRectMake(16, CGRectGetMaxY(_locationNameLabel.frame)+24, _distanceLabel.frame.size.width, 11);
    [_goNowBtn setImage:[UIImage imageNamed:@"btn_go"] forState:UIControlStateNormal];
    [_goNowBtn setTitle:@"去这里" forState:UIControlStateNormal];
    [_goNowBtn setTitleColor:UNMAIN_TEXT_COLOR forState:UIControlStateNormal];
    [_goNowBtn.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [self addSubview:_goNowBtn];
//    [_goNowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_distanceLabel.left);
//        make.top.equalTo(_locationNameLabel.bottom).offset(24);
//        make.right.equalTo(_distanceLabel.right);
//        make.height.equalTo(11);
//    }];
}

@end
