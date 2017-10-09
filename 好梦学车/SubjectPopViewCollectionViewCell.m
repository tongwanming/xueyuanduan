//
//  SubjectPopViewCollectionViewCell.m
//  好梦学车
//
//  Created by haomeng on 2017/5/20.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectPopViewCollectionViewCell.h"

@implementation SubjectPopViewCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}

- (void)setState:(NSString *)state{
//    NSLog(@"state:---%@",state);
    _state = state;
    if ([_state isEqualToString:@"YES"]) {
        self.backGroundView.image = [UIImage imageNamed:@"pop_btn_blue"];
        self.numLabel.textColor = BLUE_BACKGROUND_COLOR;
    }else if ([_state isEqualToString:@"NO"]){
        self.backGroundView.image = [UIImage imageNamed:@"pop_btn_orange"];
        self.numLabel.textColor = FF8400;
    }else{
        self.backGroundView.image = [UIImage imageNamed:@"pop_btn_normal"];
        self.numLabel.textColor = TEXT_COLOR;
    }
}

@end
