//
//  GuideViewController.h
//
//  图片引导页
//
//
//
//  Created by Shane on 16/1/1.
//  Copyright © 2016年 Shane. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GuideViewControllerDelegate <NSObject>

- (void)didSelectSkipButton;

@end

@interface GuideViewController : UIViewController

@property (strong, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) id<GuideViewControllerDelegate> guideDelegate;

@end
