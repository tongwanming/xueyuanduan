//
//  ChoosedPlaceViewController.h
//  好梦学车
//
//  Created by haomeng on 2017/4/27.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "BasicViewController.h"
#import "ChoosedClassModel.h"
#import "FirstLocationModel.h"

typedef void(^choosedPlaceBlock)(FirstLocationModel *place);

@interface ChoosedPlaceViewController : BasicViewController

@property (nonatomic, strong) choosedPlaceBlock choosedExerciseBlock;

@property (nonatomic, assign) BOOL isByPersonVC;

@property (nonatomic, strong) ChoosedClassModel *choosedModel;

@property (nonatomic, strong) NSArray *allExerciseLocationData;

- (void)returnHasChooedExercisePlaceBlock:(choosedPlaceBlock)block;
@end
