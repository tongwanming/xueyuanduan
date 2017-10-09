//
//  FirstOfflineTableViewCell.h
//  好梦学车
//
//  Created by haomeng on 2017/5/2.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "FirstBasicTableViewCell.h"
#import "OffLineServerStation.h"

@interface FirstOfflineTableViewCell : FirstBasicTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *FirstTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *SecondTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *Third;

@property (nonatomic, strong) OffLineServerStation *model;

@end
