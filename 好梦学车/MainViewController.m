//
//  MainViewController.m
//  haomengxueche
//
//  Created by haomeng on 2017/4/18.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "MainViewController.h"
#import "FirstViewController.h"
#import "LearningViewController.h"
#import "ExerciseViewController.h"
#import "PersonNewViewController.h"
#import "TSZTabBar.h"
#import "AppDelegate.h"
#import "UIDesign.h"

#import "SVGKit.h"
#import "SVGKImage.h"
#import "SVGKParser.h"
#import "PersonCenterViewController.h"
#import "CustonNavViewController.h"

// RGB颜色
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define CURRENT_BOUNDSA [UIScreen mainScreen].bounds.size

@interface MainViewController ()<UINavigationControllerDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self addChildVc:[[FirstViewController alloc] init] title:@"首页" image:[self svgImageNamed:@"homepage"] selectedImage:[self svgImageNamed:@"homepage_click"] andHasNav:YES withFrame:CGRectMake(0, 0, CURRENT_BOUNDS.width/4, 44)];
     [self addChildVc:[[ExerciseViewController alloc] init] title:@"题库" image:[self svgImageNamed:@"topic"] selectedImage:[self svgImageNamed:@"topic_click"] andHasNav:YES withFrame:CGRectMake(CURRENT_BOUNDS.width/4, 0, CURRENT_BOUNDS.width/4, 44)];
    [self addChildVc:[[PersonCenterViewController alloc] init] title:@"消息" image:[self svgImageNamed:@"message"] selectedImage:[self svgImageNamed:@"message_click"] andHasNav:YES withFrame:CGRectMake(CURRENT_BOUNDS.width/2, 0, CURRENT_BOUNDS.width/4, 44)];
   
    
    [self addChildVc:[[PersonNewViewController alloc] init] title:@"我的" image:[self svgImageNamed:@"people"] selectedImage:[self svgImageNamed:@"people_click"] andHasNav:YES withFrame:CGRectMake(CURRENT_BOUNDS.width/3*2, 0, CURRENT_BOUNDS.width/4, 44)];
   
    
    TSZTabBar *tabBar = [[TSZTabBar alloc] init];
//    tabBar.backgroundColor = [UIColor redColor];
    [self setValue:tabBar forKey:@"tabBar"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(intoReceivedVCPush:) name:@"SubViewController" object:nil];
    // Do any additional setup after loading the view from its nib.
}

- (UIImage *)svgImageNamed:(NSString *)imageName {
    
    if (imageName && imageName.length) {
        NSString *path = [[NSBundle mainBundle] pathForResource:imageName
                                                         ofType:@"svg"];
        if (path && path.length) {
            SVGKImage *svgImg = [SVGKImage imageNamed:imageName];
            svgImg.size = CGSizeMake(25, 25);
            return svgImg.UIImage;
        }
        return nil;
    }
    return nil;
}



- (void)intoReceivedVCPush:(NSNotification *)notification{
    
    UINavigationController *selectNav = self.selectedViewController;
    UIViewController *showVC = selectNav.viewControllers.lastObject;
    
    if (![showVC isKindOfClass:[PersonCenterViewController class]] && ![showVC isKindOfClass:[FirstViewController class]] && ![showVC isKindOfClass:[ExerciseViewController class]] && ![showVC isKindOfClass:[PersonNewViewController class]]) {
        NSString *VCStr = notification.object;
        if ([VCStr isEqualToString:@"Appear"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.tabBar.hidden = NO;
            });
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                self.tabBar.hidden = YES;
            });
        }
    }else{
        if (self.tabBar.hidden) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.tabBar.hidden = NO;
            });
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage andHasNav:(BOOL)nav withFrame:(CGRect)frame
{
    // 设置子控制器的文字(可以设置tabBar和navigationBar的文字)
    childVc.title = title;
    
    // 设置子控制器的tabBarItem图片
    childVc.tabBarItem.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    // 禁用图片渲染
    childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    childVc.tabBarItem.imageInsets = UIEdgeInsetsMake(3, 1.5, 0, 1.5);
    
//    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithAlignmentRectInsets:UIEdgeInsetsMake(10, 0, 0, 0)];
    
    // 设置文字的样式
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:0.80f green:0.81f blue:0.84f alpha:1.00f]} forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:0.02f green:0.63f blue:1.00f alpha:1.00f]} forState:UIControlStateSelected];
    //        childVc.view.backgroundColor = RandomColor; // 这句代码会自动加载主页，消息，发现，我四个控制器的view，但是view要在我们用的时候去提前加载
    
//    childVc.tabBarItem.accessibilityFrame = frame;
    
    // 为子控制器包装导航控制器
    CustonNavViewController *navigationVc;
    if (nav) {
        navigationVc = [[CustonNavViewController alloc] initWithRootViewController:childVc];
        navigationVc.delegate = self;
        // 添加子控制器
        [self addChildViewController:navigationVc];
    }else{
        // 添加子控制器
        [self addChildViewController:childVc];
    }
}

/**
 *  改变图片的大小
 *
 *  @param img     需要改变的图片
 *  @param newsize 新图片的大小
 *
 *  @return 返回修改后的新图片
 */
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)newsize{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(newsize);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

@end
