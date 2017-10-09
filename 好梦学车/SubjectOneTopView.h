//
//  SubjectOneTopView.h
//  好梦学车
//
//  Created by haomeng on 2017/5/11.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SubjectOneTopViewDelegate <NSObject>

- (void)subjectOneTopViewBtnClickWithBtn:(id)sender;

@end

@interface SubjectOneTopView : UICollectionReusableView

@property (nonatomic, strong) UILabel *title1;
@property (nonatomic, strong) UILabel *title2;
@property (nonatomic, strong) UILabel *title3;
@property (nonatomic, strong) UILabel *title4;

@property (nonatomic, strong) NSString *type;

@property (nonatomic, weak) id<SubjectOneTopViewDelegate>delegate;

@end
