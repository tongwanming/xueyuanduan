//
//  SubjectPractisePageFlashTableViewCell.m
//  好梦学车
//
//  Created by haomeng on 2017/5/15.
//  Copyright © 2017年 haomeng. All rights reserved.
//

#import "SubjectPractisePageFlashTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface SubjectPractisePageFlashTableViewCell ()<UIWebViewDelegate>

@end

@implementation SubjectPractisePageFlashTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setUrl:(NSString *)url{
    _url = url;
    
//    _webView = [[UIWebView alloc] init];
//    _webView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//    [self.contentView addSubview:_webView];
//    
//    _webView.delegate = self;
//    [self loadWebPageWithString:_url];
//    NSLog(@"_url:%@",_url);
    _imView = [[UIImageView alloc] init];
    _imView.frame = CGRectMake(16, 0, CURRENT_BOUNDS.width-32, 153);
    [_imView sd_setImageWithURL:[NSURL URLWithString:_url] placeholderImage:[UIImage imageNamed:@"pic05"]];
    _imView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_imView];
}

#pragma mark--webViewDelegate
- (void)loadWebPageWithString:(NSString*)urlString
{
    if (![urlString hasPrefix:@"http://"]) {
        urlString = [NSString stringWithFormat:@"http://%@",urlString];
    }
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
    _webView.scalesPageToFit = YES;

    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //    [[CLoadingView instance] stopAnimation];
    NSLog(@"%@",error);
   
  
}

- (void)dealloc{
     [_webView stopLoading];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
