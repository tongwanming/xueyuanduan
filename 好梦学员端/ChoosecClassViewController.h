//
//  ChoosecClassViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/6/28.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "BasicViewController.h"
#import "ChoosedClassModel.h"

typedef void(^ChoosecClassReturnBlock)(ChoosedClassModel *model);

@interface ChoosecClassViewController : BasicViewController

@property (nonatomic,strong) ChoosecClassReturnBlock choosedBlock;
@property (weak, nonatomic) IBOutlet UIButton *choosedBtn;

- (void)returnActiveWithBlock:(ChoosecClassReturnBlock)block;

@end
