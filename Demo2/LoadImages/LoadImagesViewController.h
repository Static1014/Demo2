//
//  LoadImagesViewController.h
//  Demo2
//
//  Created by XiongJian on 14-7-24.
//  Copyright (c) 2014年 Static. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadImagesViewController : UIViewController <UIGestureRecognizerDelegate>

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)clickLoad:(id)sender;
@end
