//
//  IPopView.m
//  Lightning DS
//
//  Created by tongwanming on 15/8/24.
//  Copyright (c) 2015年 com.auralic. All rights reserved.
//

#import "IPopView.h"

@implementation IPopView
{
    IPopUpWithPromptView *_popView;
    CGRect _oldRect;
}

- (instancetype)initWithPopUpBackGroundViewWithRect:(CGRect)rect andAddView:(UIViewController *)currentAddViewController andTitleNameArray:(NSArray *)NameArray andStyle:(IPopUpWithPromptViewStyle)style completion:(void(^)(IPopUpWithPromptView *popView_))completion{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = [UIScreen mainScreen].bounds;
        _oldRect = rect;
        [currentAddViewController.view.window addSubview:self];
        
        NSString *currentViewStyle = nil;
        if (style == IPopUpWithPromptViewStyleNormal) {
            currentViewStyle = @"IPopUpWithPromptViewNormal";
        }else if (style == IPopUpWithPromptViewStyleHeight){
            currentViewStyle = @"IPopUpWithPromptViewHeight";
        }else if (style == IPopUpWithPromptViewStylePush){
            currentViewStyle = @"IPopUpWithPromptViewNormal";
            
        }else{
            currentViewStyle = @"IPopUpWithPromptViewNormal";

        }
        _popView = [[[NSBundle mainBundle] loadNibNamed:currentViewStyle owner:self options:nil] lastObject];
        _popView.titleNameDataArray = NameArray;
        if (style == IPopUpWithPromptViewStyleNormal) {
            _popView.titleLabel.text = @"请选择服务站";
            _popView.detailTitleLabel.text = [NSString stringWithFormat:@"请在以下%lu个线下服务站中任选一个",(unsigned long)NameArray.count];
        }else{
            _popView.titleLabel.text = @"请选择支付方式";
            _popView.detailTitleLabel.text = @"请在以下第三方支付";
        }
        
        _popView.style = style;
        if (rect.size.height >=TopViewWithHeight + IndexPathOfRowWithHeight*(NameArray.count)+ CancelButtonWithHeight ) {
            _popView.frame = CGRectMake((self.frame.size.width-rect.size.width)/2, self.frame.size.height, rect.size.width, TopViewWithHeight + IndexPathOfRowWithHeight*(NameArray.count) + CancelButtonWithHeight -20);
        }else{
        _popView.frame = CGRectMake((self.frame.size.width-rect.size.width)/2, self.frame.size.height, rect.size.width, rect.size.height - 64);
        }
        
        [self addSubview:_popView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popViewClose) name:@"closePopView" object:nil];
        if (completion) {
            completion(_popView);
        }
    }
    //添加 手势弹回popView
    UIView *touchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, [[UIScreen mainScreen] bounds].size.height - _popView.frame.size.height)];
    touchView.backgroundColor = [UIColor clearColor];
    [self addSubview:touchView];
    
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenPopView)];
    [touchView addGestureRecognizer:tapGest];
    //动画效果
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.backgroundColor = POPVIEW_BACKGROUND_COLOR;
            _popView.frame = CGRectMake((self.frame.size.width-rect.size.width)/2, rect.size.height - _popView.frame.size.height+(self.frame.size.height-rect.size.height)/2, _popView.frame.size.width, _popView.frame.size.height);
        } completion:^(BOOL finished) {
            
        }];
    });
    return self;
}

+ (void)createPopUpBackGroundViewWithRect:(CGRect)rect andAddView:(UIViewController *)currentAddViewController andTitleNameArray:(NSArray *)NameArray andStyle:(IPopUpWithPromptViewStyle)style completion:(void (^)(IPopUpWithPromptView *))completion{
    IPopView *view = [[self alloc] initWithPopUpBackGroundViewWithRect:rect andAddView:currentAddViewController andTitleNameArray:NameArray andStyle:style completion:^(IPopUpWithPromptView *popView_) {
        if (completion) {
            completion(popView_);
        }
    }];
}

- (void)popViewHidden{
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _popView.frame = CGRectMake((self.frame.size.width-_oldRect.size.width)/2, self.frame.size.height, _popView.frame.size.width, _popView.frame.size.height);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
    }];
}

- (void)hiddenPopView{
    [self popViewHidden];
}

- (void)popViewClose{
    [self popViewHidden];
}

+(void)popClose{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closePopView" object:nil];
}

@end
