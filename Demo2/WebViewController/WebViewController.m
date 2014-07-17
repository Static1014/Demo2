//
//  WebViewController.m
//  Demo2
//
//  Created by XiongJian on 14-7-16.
//  Copyright (c) 2014年 Static. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () {
    BOOL menuIsShow;

    UIActivityIndicatorView *indicator;
}

@end

@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setNavigationBar];

    [self initWebView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_webView release];
    [_menuView release];
    [indicator release];
    [super dealloc];
}

#pragma mark - initWebView
- (void)initWebView {
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://www.baidu.com"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    _webView.delegate = self;
    [_webView loadRequest:request];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    if (indicator == nil) {
        indicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        [indicator setColor:[UIColor blueColor]];
        [indicator setCenter:_webView.center];
    }
    [_webView addSubview:indicator];
    [indicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [indicator stopAnimating];
    NSLog(@"load ++++++++++");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [indicator stopAnimating];
    NSLog(@"load -----------");
}

#pragma mark - NavigationBar and Menu
- (void)setNavigationBar {
    menuIsShow = NO;

    UIBarButtonItem *leftMenuBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(initWebView)];
    self.navigationItem.leftBarButtonItem = leftMenuBtn;

    UIBarButtonItem *rightMenuBtn = [[UIBarButtonItem alloc]initWithTitle:@"Menu" style:UIBarButtonItemStylePlain target:self action:@selector(showRightMenu)];
    self.navigationItem.rightBarButtonItem = rightMenuBtn;

    self.navigationItem.title = @"Web View";

    UIView *menuBg = [self.view viewWithTag:123];
    [menuBg setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:2 alpha:0.5]];
}

- (void)showRightMenu {
    if (!menuIsShow) {
        menuIsShow = YES;

        [UIView animateWithDuration:0.6 animations:^{
            CGRect frame = _menuView.frame;
            frame.origin.x = 0;
            _menuView.frame = frame;
        }];
    } else {
        menuIsShow = NO;
        
        [UIView animateWithDuration:0.6 animations:^{
            CGRect frame = _menuView.frame;
            frame.origin.x = 320;
            _menuView.frame = frame;
        }];
    }
}

- (IBAction)clickOne:(id)sender {
    if (menuIsShow) {
        [self showRightMenu];
    }
    NSLog(@"click 1111111");
}

- (IBAction)clickTwo:(id)sender {
    if (menuIsShow) {
        [self showRightMenu];
    }
    NSLog(@"click 2222222");
}

- (IBAction)clickThree:(id)sender {
    if (menuIsShow) {
        [self showRightMenu];
    }
    NSLog(@"click 3333333");
}

- (IBAction)clickFour:(id)sender {
    if (menuIsShow) {
        [self showRightMenu];
    }
    NSLog(@"click 4444444");
}

- (IBAction)clickMenuView:(id)sender {
    if (menuIsShow) {
        [self showRightMenu];
    }
}
@end
