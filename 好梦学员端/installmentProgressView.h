//
//  installmentProgressView.h
//  好梦学车
//
//  Created by haomeng on 2017/8/29.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface installmentProgressView : UIView


- (instancetype)initWithPrice1:(int)price1 andPrice2:(int)price2 andPrice3:(int)price3 andHandPrice:(int)handPrice andProgress:(int)progress andFrame:(CGRect)frame;

@end
