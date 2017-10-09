//
//  TopChoosedClassView.h
//  好梦学车
//
//  Created by haomeng on 2017/6/28.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopChoosedClassViewDelegate <NSObject>

- (void)scrollViewStopWithIndex:(NSIndexPath *)index;

- (void)scrollViewStopWithIndexTwo:(NSIndexPath *)index;

@end

@interface TopChoosedClassView : UIView


@property (nonatomic, weak) id<TopChoosedClassViewDelegate>delegate;

@property (nonatomic, strong) NSArray *dataArr;

@end
