//
//  SubjectRegularReusableView.m
//  好梦学车
//
//  Created by haomeng on 2017/5/25.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectRegularReusableView.h"

@implementation SubjectRegularReusableView{
    UILabel *_titleLabel;
}

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 20, CURRENT_BOUNDS.width-32, 16)];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = TEXT_COLOR;
       
        [self addSubview:_titleLabel];
    }
     _titleLabel.text = _titleStr;
    
}

@end
