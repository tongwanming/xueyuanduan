//
//  SubjectOneDetailTrafficSignViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/5/25.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectOneBasicViewController.h"

@interface SubjectOneDetailTrafficSignViewController : SubjectOneBasicViewController
@property (weak, nonatomic) IBOutlet UILabel *titileLabel;

@property (nonatomic, assign) NSNumber *tralicType;

@property (nonatomic, strong) NSString *titleStr;

@property (nonatomic, strong) NSArray *titleData;

@property (nonatomic, strong) NSArray *imageData;

@end
