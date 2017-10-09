//
//  SubjectOneAnalysisTableViewCell.m
//  好梦学车
//
//  Created by haomeng on 2017/5/12.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectOneAnalysisTableViewCell.h"

@implementation SubjectOneAnalysisTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 55/2-15/2, 15, 15)];
    _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_logoImageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_logoImageView.frame)+15, 55/2-15/2, 150, 15)];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = TEXT_COLOR;
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_titleLabel];
    
    _secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(CURRENT_BOUNDS.width - 80, 55/2-15/2, 50, 15)];
    _secondLabel.font = [UIFont systemFontOfSize:15];
    _secondLabel.textAlignment = NSTextAlignmentRight;
    _secondLabel.textColor = ADB1B9;
    [self addSubview:_secondLabel];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
   
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
