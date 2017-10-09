//
//  SubjectRecordTableViewCell.h
//  好梦学车
//
//  Created by haomeng on 2017/5/14.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubjectRecordTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *useTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *gardeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (nonatomic, strong) NSString *gardStr;

@property (nonatomic, strong) NSString *timeStr;

@property (nonatomic, strong) NSString *evaluate;

@property (nonatomic, strong) NSString *exerciseTime;

@end
