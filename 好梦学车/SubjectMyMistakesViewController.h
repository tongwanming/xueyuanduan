//
//  SubjectMyMistakesViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/5/25.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectOneBasicViewController.h"
#import "SubjectPractiseViewController.h"

@interface SubjectMyMistakesViewController : SubjectOneBasicViewController
@property (weak, nonatomic) IBOutlet UIButton *bottonBtn;

@property (nonatomic, assign) PractiseViewControllerType type;

@end
