//
//  TopSubView.h
//  好梦学车
//
//  Created by haomeng on 2017/5/4.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopSubViewDelegate <NSObject>

- (void)scrollViewStopWithIndex:(NSIndexPath *)index;

@end

@interface TopSubView : UIView

@property (nonatomic, weak) id<TopSubViewDelegate>delegate;

@property (nonatomic, strong) NSArray *dataArr;

@end
