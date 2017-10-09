//
//  SubjectExamResultModel.h
//  好梦学车
//
//  Created by haomeng on 2017/6/6.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubjectOneExamViewController.h"

@interface SubjectExamResultModel : NSObject

@property (nonatomic, strong) NSMutableArray *trueData;

@property (nonatomic, strong) NSMutableArray *errorData;

@property (nonatomic, assign) int timeStr;

@property (nonatomic, strong) NSString *dateStr;

@property (nonatomic, strong) NSString *finishTimeStr;

@property (nonatomic, assign) ExamViewControllerType examType;



@end
