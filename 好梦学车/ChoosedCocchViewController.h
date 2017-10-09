//
//  ChoosedCocchViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/4/27.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "BasicViewController.h"

typedef void(^selectCocchBlock)(NSString *name);

@interface ChoosedCocchViewController : BasicViewController

@property (nonatomic, copy) selectCocchBlock selectBlock;

@property (nonatomic, assign) BOOL isByPersonVC;

- (void)returnSelectCocchWithBlock:(selectCocchBlock)block;

@end
