//
//  SubjectOneAnalysisNormalTableViewCell.m
//  好梦学车
//
//  Created by haomeng on 2017/5/12.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectOneAnalysisNormalTableViewCell.h"

@implementation SubjectOneAnalysisNormalTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, (55-16)/2, CURRENT_BOUNDS.width-32, 16)];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.textColor = TEXT_COLOR;
    _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self addSubview:_titleLabel];
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
