//
//  ManuallyLocateViewController.h
//  好梦学员端
//
//  Created by haomeng on 2017/9/29.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "BasicViewController.h"
#import <BaiduMapAPI_Location/BMKLocationService.h>

typedef void(^FinishBlock)(NSString *address,CLLocationCoordinate2D pt,NSArray *data);

@interface ManuallyLocateViewController : BasicViewController

-(void)returnChoosedLoactionWithBlock:(FinishBlock)block;

@end
