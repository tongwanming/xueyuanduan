//
//  SubjectPractisePopView.m
//  好梦学车
//
//  Created by haomeng on 2017/5/20.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectPractisePopView.h"


#define popViewHeight CURRENT_BOUNDS.height - 120

@interface SubjectPractisePopView ()<SubjectPractiseTabPanelPopViewDelegate>

@end

@implementation SubjectPractisePopView{
    SubjectPractiseTabPanelPopView *_popView;
    CGRect _oldRect;
}

- (instancetype)initWithPopUpBackGroundViewWithRect:(CGRect)rect andAddView:(UIViewController *)currentAddViewController andData:(SubjectPractiseTabPanelPopViewModel *)model completion:(void (^)(SubjectPractiseTabPanelPopView *))completion andIndex:(void (^)(NSInteger))integer{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = [UIScreen mainScreen].bounds;
        _oldRect = rect;
        [currentAddViewController.view.window addSubview:self];
        
        _popView = [[SubjectPractiseTabPanelPopView alloc] initWithFrame:CGRectMake(0, CURRENT_BOUNDS.height, CURRENT_BOUNDS.width, popViewHeight)];
        _popView.model = model;
        _popView.delegate = self;
        
        [self addSubview:_popView];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popViewClose) name:@"cloeseCurrentPopView" object:nil];
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

+ (void)creatPopUpBackGroundViewWithRect:(CGRect)rect andAddView:(UIViewController *)currentAddViewController andData:(SubjectPractiseTabPanelPopViewModel *)model completion:(void (^)(SubjectPractiseTabPanelPopView *))completion andIndex:(void (^)(NSInteger))integer{
    SubjectPractisePopView *v = [[self alloc] initWithPopUpBackGroundViewWithRect:rect andAddView:currentAddViewController andData:model completion:^(SubjectPractiseTabPanelPopView *popView_) {
        if (completion) {
            completion(popView_);
        }
    } andIndex:^(NSInteger integer_) {
        if (integer) {
            integer(integer_);
        }
    }];
    
    NSLog(@"%@",v);
}

- (void)hiddenPopView{
    [self popViewHidden];
}

- (void)popViewClose{
    [self popViewHidden];
}

- (void)popViewHidden{
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _popView.frame = CGRectMake(0, self.frame.size.height, _popView.frame.size.width, _popView.frame.size.height);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
    }];
}

+ (void)popClose{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cloeseCurrentPopView" object:nil];
}

#pragma mark - delegae

- (void)SubjectPractiseTabPanelPopViewDelegateWithCollection:(NSIndexPath *)index{
    if ([self.deleagte respondsToSelector:@selector(SubjectPractisePopViewWithIndex:)]) {
        [self.deleagte performSelector:@selector(SubjectPractisePopViewWithIndex:) withObject:index];
    }
}

- (void)topViewBtnClcikWithBtn:(UIButton *)btn{
    if ([self.deleagte respondsToSelector:@selector(SubjectPractisePopViewBtn:)]) {
        [self.deleagte performSelector:@selector(SubjectPractisePopViewBtn:) withObject:btn];
    }

}

@end
