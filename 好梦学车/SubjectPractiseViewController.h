//
//  SubjectPractiseViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/5/12.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectOneBasicViewController.h"

typedef NS_ENUM(NSInteger,PractiseViewControllerType) {
    PractiseViewControllerTypeOne,
    PractiseViewControllerTypeForth,
    PractiseViewControllerTypeOneMistake,
    PractiseViewControllerTypeOneSpecial,
    PractiseViewControllerTypeOneCollection,
    PractiseViewControllerTypeTwoCollection,
    PractiseViewControllerTypeThreeCollection,
    PractiseViewControllerTypeForthMistake,
    PractiseViewControllerTypeForthSpecial,
    PractiseViewControllerTypeForthCollection,
    
};


@interface SubjectPractiseViewController : SubjectOneBasicViewController
@property (weak, nonatomic) IBOutlet UIView *subView;
@property (weak, nonatomic) IBOutlet UIView *subMidView;

@property (nonatomic, strong) NSString *type;
@property (weak, nonatomic) IBOutlet UIButton *orderBtn;
@property (weak, nonatomic) IBOutlet UIButton *noOorderBtn;
@property (weak, nonatomic) IBOutlet UILabel *allMistakeLabel;
@property (weak, nonatomic) IBOutlet UIButton *removeBtn;

@property (nonatomic, strong) NSString *titleStr;

@property (nonatomic, assign) PractiseViewControllerType practiseType;

@property (nonatomic, strong) NSString *mistakeType;//错题处理的种类

@property (nonatomic, strong) NSArray *mistakeData;//错误的数据

@end
