//
//  IPopUpWithPromptView.h
//  Lightning DS
//
//  Created by tongwanming on 15/8/21.
//  Copyright (c) 2015年 com.auralic. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TopViewWithHeight 123
#define IndexPathOfRowWithHeight 78
#define CancelButtonWithHeight 80

typedef enum {
    IPopUpWithPromptViewStyleNormal,
    IPopUpWithPromptViewStyleHeight,
    IPopUpWithPromptViewStylePush,
}IPopUpWithPromptViewStyle;

@protocol IPopUpWithPromptViewDelegate;

@interface IPopUpWithPromptView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UIView *_backgroundView;
    UIView *_popView;
}

//公用部分
@property (weak, nonatomic) IBOutlet UIView *topBackGroundView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIView *TopLineView;
@property (weak, nonatomic) IBOutlet UIView *cancelBtnView;
@property (nonatomic, assign) IPopUpWithPromptViewStyle style;

//IPopUpWithPromptViewStyleNormal
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailTitleLabel;

//IPopUpWithPromptViewStyleHeight


@property (nonatomic, strong) NSArray *titleNameDataArray;
@property (nonatomic, weak) id<IPopUpWithPromptViewDelegate>delegate;
@property (nonatomic, strong) NSString *currentName;
@end

@protocol IPopUpWithPromptViewDelegate <NSObject>

@optional

- (void)popViewCancelBtnClick;

- (void)didSelectCurrentViewItemAtIndex:(NSInteger)index andStyle:(IPopUpWithPromptView *)view;

@end
