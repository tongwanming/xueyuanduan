//
//  SubjectPractisePageTitleTableViewCell.m
//  好梦学车
//
//  Created by haomeng on 2017/5/15.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectPractisePageTitleTableViewCell.h"

@implementation SubjectPractisePageTitleTableViewCell{
    int _titleHeight;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleLabel1 = [[UILabel alloc] init];
        _titleLabel1.textColor = BLUE_BACKGROUND_COLOR;
        _titleLabel1.font = [UIFont systemFontOfSize:12];
        _titleLabel1.textAlignment = NSTextAlignmentCenter;
        _titleLabel1.numberOfLines = 1;
        _titleLabel1.frame = CGRectMake(16, 19, 40, 21);
        _titleLabel1.layer.cornerRadius = 3;
        _titleLabel1.layer.masksToBounds = YES;
        _titleLabel1.layer.borderWidth = 1;
        _titleLabel1.layer.borderColor = BLUE_BACKGROUND_COLOR.CGColor;
        [self.contentView addSubview:_titleLabel1];
        
        _titleLabel2 = [[UILabel alloc] init];
        _titleLabel2.textColor = TEXT_COLOR;
        _titleLabel2.font = [UIFont systemFontOfSize:17];
        _titleLabel2.textAlignment = NSTextAlignmentLeft;
        _titleLabel2.numberOfLines = 0;
//        _titleLabel2.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_titleLabel2];
        
    }
    return self;
}

- (void)setTitleStr1:(NSString *)titleStr1{
    _titleStr1 = titleStr1;
    _titleLabel1.text = titleStr1;
}

- (void)setTitleStr2:(NSString *)titleStr2{
   _titleHeight = [self getTitleHeightWithString:titleStr2];
//    NSLog(@"_titleHeight:%d",_titleHeight);
    _titleStr2 = titleStr2;
    _titleLabel2.text = titleStr2;
    [self setNeedsDisplay];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _titleLabel2.frame = CGRectMake(CGRectGetMaxX(_titleLabel1.frame)+11, 15,  CURRENT_BOUNDS.width-87, _titleHeight+10);
}

- (CGFloat)getTitleHeightWithString:(NSString *)title{
    CGRect rect = [title boundingRectWithSize:CGSizeMake(CURRENT_BOUNDS.width-87, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
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
