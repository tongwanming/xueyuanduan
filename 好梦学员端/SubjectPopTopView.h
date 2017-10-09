//
//  SubjectPopTopView.h
//  好梦学车
//
//  Created by haomeng on 2017/5/20.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SubjectPopTopViewBtnDelegate <NSObject>

- (void)subjectPopTopViewBtnClickWithBtn:(UIButton *)btn;

@end

@interface SubjectPopTopView : UICollectionReusableView

@property (nonatomic, weak) id<SubjectPopTopViewBtnDelegate>delegate;

@property (nonatomic, assign)NSInteger secntion;

@property (nonatomic, strong) NSString *titleNameStr;

@end
