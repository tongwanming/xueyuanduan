//
//  myLearningTapView.h
//  好梦学车
//
//  Created by haomeng on 2017/7/31.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^tapLearningSectionView)(NSString *style,NSInteger index);

@interface myLearningTapView : UIView
- (instancetype)initWithFrame:(CGRect)frame andName:(NSString *)name andProgress:(NSString *)progress andIndexPath:(NSInteger)indexPath andBloc:(tapLearningSectionView)topViewBlock;

@property (nonatomic, copy) tapLearningSectionView topBlock;
@end
