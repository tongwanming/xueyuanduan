//
//  ChangedNameViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/6/1.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "BasicViewController.h"

typedef void(^ChangeNameBlock)(NSString *str);

@interface ChangedNameViewController : BasicViewController

@property (weak, nonatomic) IBOutlet UITextField *text;

@property (nonatomic, strong) NSString *nameStr;

@property (nonatomic, copy) ChangeNameBlock changeNameBalock;

- (void)returnChangedName:(ChangeNameBlock)block;

@end
