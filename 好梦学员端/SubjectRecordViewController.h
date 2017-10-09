//
//  SubjectRecordViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/5/14.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubjectRecordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *subView;
@property (weak, nonatomic) IBOutlet UIButton *title1;
@property (weak, nonatomic) IBOutlet UIButton *title2;

@property (nonatomic, strong) NSString *course;

@end
