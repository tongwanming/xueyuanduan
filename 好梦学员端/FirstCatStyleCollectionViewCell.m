//
//  FirstCatStyleCollectionViewCell.m
//  好梦学车
//
//  Created by haomeng on 2017/5/3.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "FirstCatStyleCollectionViewCell.h"
#import "CatStyleApplyNowBtn.h"
#import "UIImageView+WebCache.h"
//#import "Masonry.h"

@interface FirstCatStyleCollectionViewCell ()

@property (nonatomic, strong) UIImageView *backGrondImageView;

@property (nonatomic, strong) UILabel *typeLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) CatStyleApplyNowBtn *applyNowBtn;

@end

@implementation FirstCatStyleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)setModel:(ChoosedClassModel *)model{
    _model = model;
    
//    _model = model;
    
    [_backGrondImageView sd_setImageWithURL:[NSURL URLWithString:model.imageStr] placeholderImage:[UIImage imageNamed:@"pic06"]];
  
    
    _typeLabel.text = model.titleStr;
    
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",model.priceStr];
    
//    _decLabel.text = model.descStr;
    
//    _backGrondImageView.image = [UIImage imageNamed:_model.backGroundImageName];
//    _typeLabel.text = _model.type;
//    _priceLabel.text = [NSString stringWithFormat:@"¥%@",_model.price];
}

- (void)setLocationModel:(FirstCatStyleModel *)locationModel{
    _locationModel = locationModel;
    
    _backGrondImageView.image = [UIImage imageNamed:_locationModel.backGroundImageName];
    _typeLabel.text = _locationModel.type;
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",_locationModel.price];

}

- (void)initialize{
    self.layer.doubleSided = NO;
    
    _backGrondImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 110)];
    [_backGrondImageView sd_setImageWithURL:[NSURL URLWithString:_model.imageStr] placeholderImage:[UIImage imageNamed:@"pic06"]];
    _backGrondImageView.layer.cornerRadius = 8;
    _backGrondImageView.layer.masksToBounds = YES;
    [self addSubview:_backGrondImageView];
//    [_backGrondImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.top);
//        make.left.equalTo(self.left);
//        make.right.equalTo(self.right);
//        make.height.equalTo(110);
//    }];

    _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 16, self.frame.size.width-16, 11)];
    _typeLabel.font = [UIFont systemFontOfSize:11];
    _typeLabel.textColor = WHITE_TEXT_COLOR;
    _typeLabel.text = _model.titleStr;
    [self addSubview:_typeLabel];
//    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.top).offset(16);
//        make.left.equalTo(self.left).offset(16);
//        make.height.equalTo(11);
//        make.right.equalTo(self.right);
//    }];
    
    _priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(_typeLabel.frame)+10, _typeLabel.frame.size.width, 22)];
    _priceLabel.font = [UIFont boldSystemFontOfSize:22];
    _priceLabel.textColor = RGBAN(255, 255, 255, 100);
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",_model.priceStr];;
    [self addSubview:_priceLabel];
//    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_typeLabel.left);
//        make.top.equalTo(_typeLabel.bottom).offset(10);
//        make.right.equalTo(_typeLabel.right);
//        make.height.equalTo(22);
//    }];
    
    _applyNowBtn = [CatStyleApplyNowBtn buttonWithType:UIButtonTypeCustom];
    _applyNowBtn.frame = CGRectMake(16, CGRectGetMaxY(_priceLabel.frame)+24, _typeLabel.frame.size.width, 11);
    [_applyNowBtn setImage:[UIImage imageNamed:@"go_white"] forState:UIControlStateNormal];
    [_applyNowBtn setTitle:@"立即报名" forState:UIControlStateNormal];
    [_applyNowBtn setTitleColor:WHITE_TEXT_COLOR forState:UIControlStateNormal];
    [_applyNowBtn.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [self addSubview:_applyNowBtn];
//    [_applyNowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_typeLabel.left);
//        make.top.equalTo(_priceLabel.bottom).offset(24);
//        make.right.equalTo(_typeLabel.right);
//        make.height.equalTo(11);
//    }];
}

@end
