//
//  SubjectPractisePageTableViewCell.m
//  好梦学车
//
//  Created by haomeng on 2017/5/15.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectPractisePageTableViewCell.h"

@implementation SubjectPractisePageTableViewCell{
    int _titleHeight;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
        _logoImageView.frame = CGRectMake(16, (self.frame.size.height - 20)/2, 20, 20);
        _logoImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_logoImageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = TEXT_COLOR;
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 0;
//        _titleLabel.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_titleLabel];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _logoImageView.center = CGPointMake(26, self.frame.size.height/2);
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_logoImageView.frame)+16, (self.frame.size.height - _titleHeight)/2, CURRENT_BOUNDS.width-52, _titleHeight+20);
    _titleLabel.center = CGPointMake(CURRENT_BOUNDS.width/2+18, self.frame.size.height/2);
}

- (void)setTitileStr:(NSString *)titileStr{
    _titileStr = titileStr;
   _titleHeight = [self getTitleHeightWithString:titileStr];
    _titleLabel.text = titileStr;
    [self setNeedsDisplay];
}

- (CGFloat)getTitleHeightWithString:(NSString *)title{
    CGRect rect = [title boundingRectWithSize:CGSizeMake(CURRENT_BOUNDS.width-52, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
    return rect.size.height;
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
