//
//  GCDViewController.m
//  Demo2
//
//  Created by XiongJian on 14-7-18.
//  Copyright (c) 2014年 Static. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController () {
    UIView *bg;
    UIActivityIndicatorView *indicator;
}

@end

@implementation GCDViewController

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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [bg release];
    [indicator release];
    [_contentView release];
    [_contentWeb release];
    [super dealloc];
}

- (void)initContent {
    bg = [[UIView alloc]initWithFrame:_contentWeb.frame];
    [bg setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];

    indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [indicator setCenter:_contentWeb.center];
    [bg addSubview:indicator];

    [self.view addSubview:bg];
    [indicator startAnimating];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [[NSURL alloc]initWithString:@"http://www.youdao.com"];
        NSError *error;
        NSString *data = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];

        if (data != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [indicator stopAnimating];
                [bg removeFromSuperview];
                [_contentWeb loadHTMLString:data baseURL:url];
            });
        } else {
            _contentView.text = [NSString stringWithFormat:@"Load failed!\n %@",[error description]];
        }
    });
}

- (IBAction)clickBtn1:(id)sender {
    [self initContent];
}

- (IBAction)clickBtn2:(id)sender {
    _contentView.text = @"click button2!";
}
@end
