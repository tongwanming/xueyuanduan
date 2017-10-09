//
//  SubjectRecordTableViewCell.m
//  好梦学车
//
//  Created by haomeng on 2017/5/14.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectRecordTableViewCell.h"

@implementation SubjectRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setGardStr:(NSString *)gardStr{
    _gardStr = gardStr;
    _timeLabel.text = _gardStr;
    if ([_gardStr intValue] >= 90) {
        _gardeLabel.text = @"合格";
    }else{
        _gardeLabel.text = @"马路杀手";
    }
}

- (void)setTimeStr:(NSString *)timeStr{
    _timeStr = timeStr;
    _useTimeLabel.text = timeStr;
}

- (void)setEvaluate:(NSString *)evaluate{
    _evaluate = evaluate;
    _gardeLabel.text = _evaluate;
}

- (void)setExerciseTime:(NSString *)exerciseTime{
    _exerciseTime = exerciseTime;
    _dateLabel.text = _exerciseTime;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
