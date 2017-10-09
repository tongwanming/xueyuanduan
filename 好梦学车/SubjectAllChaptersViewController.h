//
//  SubjectAllChaptersViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/6/7.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "BasicViewController.h"
#import "SubjectPractiseViewController.h"

@interface SubjectAllChaptersViewController : BasicViewController

@property (nonatomic, strong) NSArray *allChapter;

@property (nonatomic, assign) PractiseViewControllerType practiseType;

@end
