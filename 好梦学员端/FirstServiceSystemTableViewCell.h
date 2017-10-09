//
//  FirstServiceSystemTableViewCell.h
//  好梦学车
//
//  Created by haomeng on 2017/5/2.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "FirstBasicTableViewCell.h"

@interface FirstServiceSystemTableViewCell : FirstBasicTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;

@property (nonatomic, strong) NSString *name;

@end
