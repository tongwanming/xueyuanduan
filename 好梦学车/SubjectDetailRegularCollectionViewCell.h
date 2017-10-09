//
//  SubjectDetailRegularCollectionViewCell.h
//  好梦学车
//
//  Created by haomeng on 2017/5/25.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubjectDetailRegularCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) NSString *imageStr;

@property (nonatomic, strong) NSString *titleStr;

@end
