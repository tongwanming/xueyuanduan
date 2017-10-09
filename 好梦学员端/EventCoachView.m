//
//  EventCoachView.m
//  好梦学车
//
//  Created by haomeng on 2017/8/23.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "EventCoachView.h"
#import "subCenterView.h"
#import "StartButton.h"
#import "UIImageView+WebCache.h"

typedef void(^eventViewDismissFinish)(NSString *,NSString *);

@interface EventCoachView ()<UITextViewDelegate>
@property (nonatomic, strong) eventViewDismissFinish currentBlock;

@property (nonatomic, strong) UIViewController *showVc;

@end

@implementation EventCoachView{
    subCenterView *sub;
    UILabel *_countLabel;
    UITextView *_textView;
    NSString *_countStart;
}

+ (EventCoachView *)shareDefault{
    static EventCoachView *sharedDefaulte;
    if (!sharedDefaulte) {
        sharedDefaulte = [[EventCoachView alloc] init];
    }
    return sharedDefaulte;
}

- (void)showEventCoachViewWithVC:(UIViewController *)vc andWithName:(NSString *)coachName andImage:(NSString *)image andBlock:(void(^)(NSString *_des,NSString *_point))block{
    _currentBlock = block;
    _showVc = vc;
    self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, CURRENT_BOUNDS.width, [UIScreen mainScreen].bounds.size.height);
    self.backgroundColor = [UIColor clearColor];
//    self.alpha = 0.4;
    [_showVc.view.window addSubview:self];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.4;
    [self addSubview:view];
    
    [self animationActive];
    
    sub = [[subCenterView alloc] initWithFrame:CGRectMake(20, ([UIScreen mainScreen].bounds.size.height-414)/2, CURRENT_BOUNDS.width-40, 414)];
    sub.backgroundColor = [UIColor whiteColor];
    sub.layer.masksToBounds = YES;
    sub.layer.cornerRadius = 4;
    sub.tag = 1001;
    [self addSubview:sub];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    if (image) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"pic03"]];
    }else{
        imageView.image = [UIImage imageNamed:@"pic03"];
    }
    
    imageView.frame = CGRectMake(0, 0, 60, 60);
    imageView.center = CGPointMake(sub.frame.size.width/2, 60);
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 30;
    [sub addSubview:imageView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+12, sub.frame.size.width, 18)];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = [UIFont boldSystemFontOfSize:18];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.text = coachName;
//    nameLabel.backgroundColor = [UIColor redColor];
    [sub addSubview:nameLabel];
    
    CGFloat width = (sub.frame.size.width-130*TYPERATION-10*4*TYPERATION)/5;
    CGFloat height = width*33/32;
    for (int i = 0; i < 5; i++) {
        StartButton *btn = [StartButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(130*TYPERATION/2+(width+10*TYPERATION)*i, CGRectGetMaxY(nameLabel.frame)+30*TYPERATION, width, height);
        [btn setImage:[UIImage imageNamed:@"star_normal"] forState:UIControlStateNormal];
//        [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        btn.tag = 1+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//        btn.backgroundColor = [UIColor purpleColor];
        [sub addSubview:btn];
    }
    
    _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(sub.frame.size.width-130*TYPERATION/2+10, CGRectGetMaxY(nameLabel.frame)+30, 130*TYPERATION/2, 20)];
    _countLabel.textColor = FF8400;
    _countLabel.text = @"0.0";
    [sub addSubview:_countLabel];
    
    UILabel *tiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nameLabel.frame)+30+height+15, sub.frame.size.width, 14)];
    tiLabel.textAlignment = NSTextAlignmentCenter;
    tiLabel.textColor = ADB1B9;
    tiLabel.text = @"请评分:";
    tiLabel.font = [UIFont systemFontOfSize:14];
    [sub addSubview:tiLabel];
    
    UIView *subCleanView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(tiLabel.frame)+20, sub.frame.size.width-30, 120)];
    subCleanView.backgroundColor = [UIColor colorWithRed:0.94f green:0.95f blue:0.95f alpha:1.00f];
    subCleanView.layer.masksToBounds = YES;
    subCleanView.layer.cornerRadius = 4;
    [sub addSubview:subCleanView];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, sub.frame.size.width-30, 120)];
    _textView.delegate = self;
    _textView.text = @"请输入对该教练评价的话语";
    _textView.backgroundColor = [UIColor clearColor];
    [subCleanView addSubview:_textView];
    
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, CGRectGetMaxY(subCleanView.frame), sub.frame.size.width/2, sub.frame.size.height-subCleanView.frame.origin.y-subCleanView.frame.size.height);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [cancelBtn setTitleColor:ADB1B9 forState:UIControlStateNormal];
    cancelBtn.tag = 1002;
    [cancelBtn addTarget:self action:@selector(bottonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [sub addSubview:cancelBtn];
    
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(sub.frame.size.width/2, CGRectGetMaxY(subCleanView.frame), sub.frame.size.width/2, sub.frame.size.height-subCleanView.frame.origin.y-subCleanView.frame.size.height);
    [sureBtn setTitle:@"提交" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [sureBtn setTitleColor:BLUE_BACKGROUND_COLOR forState:UIControlStateNormal];
    sureBtn.tag = 1003;
    [sureBtn addTarget:self action:@selector(bottonBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [sub addSubview:sureBtn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 25)];
    lineView.backgroundColor = EEEEEE;
    lineView.center = CGPointMake(sub.frame.size.width/2, cancelBtn.center.y);
    [sub addSubview:lineView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissView)];
    [self addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissViewa)];
    [sub addGestureRecognizer:tap1];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardDidShow:(NSNotification *)notification{
    
    //kbSize即為鍵盤尺寸 (有width, height)
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.2 animations:^{
            sub.frame = CGRectMake(20, 77-170, sub.frame.size.width, sub.frame.size.height);
        }];
    });
}

- (void)keyboardDidHide:(NSNotification *)notification{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.2 animations:^{
            sub.frame = CGRectMake(20, 77, sub.frame.size.width, sub.frame.size.height);;
        }];
    });
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if ([textView.text isEqualToString:@"请输入对该教练评价的话语"]) {
        textView.text = @"";
        textView.textColor = TEXT_COLOR;
    }
    return YES;
}

- (void)bottonBtnClick:(UIButton *)btn{
    if (btn.tag == 1002) {
        [self dismissView];
    }else if (btn.tag == 1003){
        
        if (self.currentBlock) {
            self.currentBlock(_textView.text, _countLabel.text);
        }
        [self dismissView];
    }else{
    
    }
}

- (void)dismissViewa{
}

- (void)btnClick:(UIButton *)btn{
    NSInteger n = btn.tag;
    _countLabel.text = [NSString stringWithFormat:@"%ld.0",(long)n];
    for (UIView *button in sub.subviews) {
        if ([button isKindOfClass:[StartButton class]]) {
            if (((StartButton *)button).tag <= n) {
                [(StartButton *)button setImage:[UIImage imageNamed:@"star_big"] forState:UIControlStateNormal];
            }else{
                [(StartButton *)button setImage:[UIImage imageNamed:@"star_normal"] forState:UIControlStateNormal];
            }
        }
        
    }
}

- (void)animationActive{
    
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, 0, CURRENT_BOUNDS.width, [UIScreen mainScreen].bounds.size.height);
    }];
}

- (void)dismissView{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, CURRENT_BOUNDS.width, [UIScreen mainScreen].bounds.size.height);
    } completion:^(BOOL finished) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
        [self removeFromSuperview];
        
    }];
}


@end
