//
//  BAViewController.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 12..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "BAViewController.h"

@implementation BAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self applyTransparentBackgroundToTheNavigationBar:0.5f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)applyTransparentBackgroundToTheNavigationBar:(CGFloat)opacity
{
    UIImage *transparentBackground;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), NO, self.navigationController.navigationBar.layer.contentsScale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 14/255.0f, 14/255.0f, 14/255.0f, opacity);
    UIRectFill(CGRectMake(0, 0, 1, 1));
    transparentBackground = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    id navigationBarAppearance = self.navigationController.navigationBar;
    [navigationBarAppearance setBackgroundImage:transparentBackground forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

@end
