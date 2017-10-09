//
//  ChoosedTypeViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/4/27.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "BasicViewController.h"

typedef void(^selectTypeBlock)(NSString *name);

@interface ChoosedTypeViewController : BasicViewController

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, copy) selectTypeBlock selectType;

@property (nonatomic, strong) NSString *choosedType;

@property (nonatomic, assign) BOOL personSettingView;

- (void)returnSelectTypeWithBlock:(selectTypeBlock)block;

@end
