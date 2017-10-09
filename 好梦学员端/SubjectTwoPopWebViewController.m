//
//  SubjectTwoPopWebViewController.m
//  好梦学车
//
//  Created by haomeng on 2017/5/20.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectTwoPopWebViewController.h"
#import "CustomAlertView.h"

@interface SubjectTwoPopWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation SubjectTwoPopWebViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Disappear"];
    
    _titleLabel.text = _titleStr;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (IBAction)btnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //将要进入全屏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startFullScreen) name:UIWindowDidResignKeyNotification object:nil];
    //退出全屏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endFullScreen) name:UIWindowDidBecomeHiddenNotification object:nil];
    
}



-(void)endFullScreen {
    NSLog(@"退出全屏XXXX");
    UIApplication *application=[UIApplication sharedApplication];
    [application setStatusBarOrientation: UIInterfaceOrientationLandscapeRight];
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    application.keyWindow.bounds = CGRectMake(0, 0, frame.size.width, frame.size.height + 20);
    [UIView animateWithDuration:0.25 animations:^{
        application.keyWindow.transform=CGAffineTransformMakeRotation(M_PI * 2);
    }];
}

-(void)startFullScreen {
    NSLog(@"进入全屏");
    UIApplication *application=[UIApplication sharedApplication];
    [application setStatusBarOrientation: UIInterfaceOrientationLandscapeRight];
    application.keyWindow.transform=CGAffineTransformMakeRotation(M_PI/2);
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    application.keyWindow.bounds = CGRectMake(0, 0, frame.size.height + 20, frame.size.width);
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
}

- (void)setUrl:(NSString *)url{
    _url = url;
    
    _webView = [[UIWebView alloc] init];
    _webView.frame = CGRectMake(0, 64, CURRENT_BOUNDS.width, CURRENT_BOUNDS.height-64);
    _webView.delegate = self;
    _webView.mediaPlaybackRequiresUserAction = NO;
//    _webView.hidden = YES;
//    _webView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_webView];
    [self loadWebPageWithString:_url];
    
}

#pragma mark--webViewDelegate
- (void)loadWebPageWithString:(NSString*)urlString
{
    [CustomAlertView showAlertViewWithVC:self];
    
//    if (![urlString hasPrefix:@"http://"]) {
//        urlString = [NSString stringWithFormat:@"http://%@",urlString];
//    }
    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"begin");
    //    [[CLoadingView instance] startAnimation];
    //    [LDSAlertView showAlertViewWithVC:self withType:LDSAlertViewTypeLoadingCancel];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"end");
    //    [[CLoadingView instance] stopAnimation];
    //    [LDSAlertView hideAlertView];
    [CustomAlertView hideAlertView];
    _webView.hidden = NO;
    _webView.scalesPageToFit = YES;
    
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //    [[CLoadingView instance] stopAnimation];
    [CustomAlertView hideAlertView];
    NSLog(@"%@",error);
    
    
}

- (void)dealloc{
    NSLog(@"销毁");
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    [_webView stopLoading];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
//    [_webView reload];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SubViewController" object:@"Appear"];
}

- (NSString *)newStrWithStr:(NSString *)str{
    str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [NSCharacterSet URLQueryAllowedCharacterSet];
    return str;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
