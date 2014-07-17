//
//  WebViewController.h
//  Demo2
//
//  Created by XiongJian on 14-7-16.
//  Copyright (c) 2014年 Static. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>

@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (retain, nonatomic) IBOutlet UIView *menuView;
- (IBAction)clickOne:(id)sender;
- (IBAction)clickTwo:(id)sender;
- (IBAction)clickThree:(id)sender;
- (IBAction)clickFour:(id)sender;
- (IBAction)clickMenuView:(id)sender;
@end
