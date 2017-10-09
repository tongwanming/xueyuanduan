//
//  SubjectTwoTopView.h
//  好梦学车
//
//  Created by haomeng on 2017/5/11.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SubjectTwoTopViewDelegate <NSObject>

- (void)subjectTwoTopViewBtnClickWithBtn:(id)sender;

@end

@interface SubjectTwoTopView : UICollectionReusableView

@property (nonatomic, weak) id<SubjectTwoTopViewDelegate>delegate;

@end
