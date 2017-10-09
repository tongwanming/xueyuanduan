//
//  QuitBoxView.m
//  好梦学车
//
//  Created by haomeng on 2017/4/25.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "QuitBoxView.h"

@implementation QuitBoxView
- (IBAction)btnClickActive:(id)sender {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self removeFromSuperview];
//    });
    if ([self.delegate respondsToSelector:@selector(QuitBoxViewBtnClick:)]) {
        [self.delegate performSelector:@selector(QuitBoxViewBtnClick:) withObject:(UIButton *)sender];
    }
}


@end
