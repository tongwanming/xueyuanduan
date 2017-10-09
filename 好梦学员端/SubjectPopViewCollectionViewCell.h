//
//  SubjectPopViewCollectionViewCell.h
//  好梦学车
//
//  Created by haomeng on 2017/5/20.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubjectPopViewCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backGroundView;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@property (nonatomic, strong) NSString *state;

@end
