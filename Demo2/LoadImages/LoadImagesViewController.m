//
//  LoadImagesViewController.m
//  Demo2
//
//  Created by XiongJian on 14-7-24.
//  Copyright (c) 2014年 Static. All rights reserved.
//

#import "LoadImagesViewController.h"

@interface LoadImagesViewController () {
    NSArray *imgArr;
}

@end

@implementation LoadImagesViewController

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
    [_scrollView release];
    [super dealloc];
}
- (IBAction)clickLoad:(id)sender {
    imgArr = [[NSArray alloc]init];
    imgArr = [NSArray arrayWithObjects:@"http://s9.51cto.com/wyfs01/M01/10/65/wKioOVHm6WHyfZpwAAUW85FL2rw592.jpg", @"http://s1.51cto.com/wyfs01/M01/10/63/wKioJlHm6BDTgZDTAAa5o4UiX6k728.jpg", @"http://s1.51cto.com/wyfs01/M00/10/64/wKioOVHm6RLA7lNgAAYTkpqIhHI4432.png", nil];

    _scrollView.userInteractionEnabled = YES;
    [self loadImages:imgArr];
}

- (void)loadImages:(NSArray*)imgNames {
    for (int i = 0; i < [imgArr count]; i++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, i*160, i%2==0?200:240, 160)];
        imgView.tag = i;
        imgView.backgroundColor = [UIColor grayColor];
        CGPoint center = CGPointMake(imgView.frame.size.width/2, imgView.frame.size.height/2);
        [_scrollView addSubview:imgView];
        imgView.userInteractionEnabled = YES;
        [imgView release];

        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [imgView addSubview:indicator];
        [indicator release];
        
        [indicator setCenter:center];
        [indicator startAnimating];

        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[imgNames objectAtIndex:i]]];
            UIImage *img = [UIImage imageWithData:data];

            dispatch_async(dispatch_get_main_queue(), ^{
                if (img != nil) {
                        [indicator stopAnimating];

                        [imgView setImage:img];
                } else {
                    [indicator stopAnimating];

                    UIButton *errorLable = [[UIButton alloc]init];
                    errorLable.frame = CGRectMake(0, 0, 160, 36);
                    [errorLable setTitle:@"Failed" forState:UIControlStateNormal];
                    [errorLable addTarget:self action:@selector(reloadOneImage:) forControlEvents:UIControlEventTouchUpInside];
                    errorLable.tag = 1000+i;
                    [errorLable setCenter:center];
                    [imgView addSubview:errorLable];
                    [errorLable release];
                }
            });
        });
    }
    _scrollView.contentSize = CGSizeMake(320, 160*3);
}

- (void)reloadOneImage:(UIButton *)view {
    [view removeFromSuperview];
    for (UIView *temp in _scrollView.subviews) {
        if ([temp isKindOfClass:[UIImageView class]]) {
            if (temp.tag == view.tag%1000) {
                UIImageView *imgView = (UIImageView*)temp;

                UIActivityIndicatorView *indicator;
                for (UIView *insideView in imgView.subviews) {
                    if ([insideView isKindOfClass:[UIActivityIndicatorView class]]) {
                        indicator = (UIActivityIndicatorView*)insideView;
                        [indicator startAnimating];

                        dispatch_async(dispatch_get_global_queue(0, 0), ^{
                            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:temp.tag==2?@"http://s1.51cto.com/wyfs01/M00/10/64/wKioOVHm6RLA7lNgAAYTkpqIhHI443.png":[imgArr objectAtIndex:temp.tag]]];
                            UIImage *img = [UIImage imageWithData:data];

                            dispatch_async(dispatch_get_main_queue(), ^{
                                if (img != nil) {
                                    [indicator stopAnimating];

                                    [imgView setImage:img];
                                }
                            });
                        });
                    }
                }

            }
        }
    }
}
@end
