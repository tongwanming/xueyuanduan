//
//  pageViewController.m
//  uipageView
//
//  Created by haomeng on 2017/5/12.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "pageViewController.h"

@interface pageViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property(retain,nonatomic)NSArray * pageContent;
@property(retain,nonatomic)NSMutableArray * arr;

@end

@implementation pageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    self.arr = [NSMutableArray arrayWithCapacity:0];
    [self createContentPages];
    
    
    self.dataSource =self;
    self.delegate =self;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)createContentPages{
    for (int i =0; i < 10; i ++) {
        UIViewController * viewCtl = [[UIViewController alloc]init];
        viewCtl.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
        [self.arr addObject:viewCtl];
    }
    
    [self setViewControllers:@[self.arr[0]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    self.pageContent = [[NSArray alloc]initWithArray:self.arr];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    int index = (int)[self.arr indexOfObject:viewController];
    if (index >= 0 && index <self.arr.count -1) {
        return [self.arr objectAtIndex:index + 1];
    }
    return nil;
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    int index = (int)[self.arr indexOfObject:viewController];
    if (index > 0 && index <self.arr.count -1) {
        return [self.arr objectAtIndex:index - 1];
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
