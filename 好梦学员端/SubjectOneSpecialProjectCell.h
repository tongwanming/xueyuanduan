//
//  SubjectOneSpecialProjectCell.h
//  好梦学车
//
//  Created by haomeng on 2017/5/13.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SubjectOneSpecialProjectCellDelegate <NSObject>

- (void)SubjectOneSpecialProjectCellTapWith:(UIButton *)btn andTitle:(NSString *)title;

@end

@interface SubjectOneSpecialProjectCell : UITableViewCell

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) NSString *titleStr;

@property (nonatomic, weak) id<SubjectOneSpecialProjectCellDelegate>delegate;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) NSMutableDictionary *dic;

@end
