//
//  SubjectPractiseSureTableViewCell.m
//  好梦学车
//
//  Created by haomeng on 2017/5/19.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectPractiseSureTableViewCell.h"

@implementation SubjectPractiseSureTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 7, CURRENT_BOUNDS.width-80, 45)];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"提交";
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.backgroundColor = CCCFD6;
        _titleLabel.layer.cornerRadius = 3;
        _titleLabel.layer.masksToBounds = YES;
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

- (void)setDic:(NSMutableDictionary *)dic{
    _dic = dic;
    if (_dic.allValues.count > 1) {
        _titleLabel.backgroundColor = BLUE_BACKGROUND_COLOR;
    }else{
        _titleLabel.backgroundColor = CCCFD6;
    }
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
