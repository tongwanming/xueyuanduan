//
//  AppDelegate.h
//  好梦学车
//
//  Created by haomeng on 2017/4/24.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) NSArray *locationData;

@property (nonatomic, assign) BOOL isAAl;

@property (nonatomic, assign) BOOL showHoverbutton;

- (void)showHoverButtonHidden:(BOOL)hidden;

- (void)setLocationDataWithData:(NSArray *)data;
@end

