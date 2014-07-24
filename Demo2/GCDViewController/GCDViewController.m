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
    [_scrollView release];
    [super dealloc];
}

#pragma mark - test
- (void)dispathGroup {
    //  后台执行：
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // something
    });
    // 主线程执行：
    dispatch_async(dispatch_get_main_queue(), ^{
        // something
    });
    // 一次性执行：
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // code to be executed once
    });
    // 延迟2秒执行：
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        // code to be executed on the main queue after delay
    });

    // 自定义
    dispatch_queue_t urls_queue = dispatch_queue_create("blog.devtang.com", NULL);
    dispatch_async(urls_queue, ^{
        // your code
    });
    dispatch_release(urls_queue);
    
    // 汇总执行
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
        // 并行执行的线程一
    });
    dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
        // 并行执行的线程二
    });
    dispatch_group_notify(group, dispatch_get_global_queue(0,0), ^{
        // 汇总结果 
    });

    // 默认情况下，在程序块中访问的外部变量是复制过去的，即写操作不对原变量生效。但是你可以加上 __block来让其写操作生效
    __block int a = 0;
    void  (^foo)(void) = ^{
        a = 1;
    };
    foo();
    // 这里，a的值被修改为1
}

#pragma mark - content
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
            [url release];
        }
    });
}

- (IBAction)clickBtn1:(id)sender {
    [self initContent];
}

- (IBAction)clickBtn2:(id)sender {
    _contentView.text = @"Loading image!";

    for (UIView *temp in _scrollView.subviews) {
        [temp removeFromSuperview];
    }
    _scrollView.scrollEnabled = YES;
    [self loadImageFromUrl:@"http://s1.51cto.com/wyfs01/M01/10/63/wKioJlHm6BDTgZDTAAa5o4UiX6k728.jpg"];
}

- (void)loadImageFromUrl:(NSString*)url {
    UILabel *loadingLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
    loadingLable.text = @"Loading...";
    loadingLable.textAlignment = NSTextAlignmentCenter;
    loadingLable.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    loadingLable.textColor = [UIColor whiteColor];
    [_scrollView addSubview:loadingLable];
    [loadingLable release];

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        UIImage *img = [UIImage imageWithData:data];
        if (img != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                for (UIView *temp in _scrollView.subviews) {
                    [temp removeFromSuperview];
                }

                UIImageView *imgView = [[UIImageView alloc]initWithImage:img];
                [imgView setFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
                [_scrollView addSubview:imgView];
                NSLog(@"load 1111111111");
                _scrollView.contentSize = img.size;
                [imgView release];
            });
        }
    });

}
@end
