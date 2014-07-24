//
//  GCDViewController.h
//  Demo2
//
//  Created by XiongJian on 14-7-18.
//  Copyright (c) 2014年 Static. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCDViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIWebView *contentWeb;
@property (retain, nonatomic) IBOutlet UITextView *contentView;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)clickBtn1:(id)sender;
- (IBAction)clickBtn2:(id)sender;
@end
