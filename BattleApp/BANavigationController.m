//
//  BANavigationController.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 12..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "BANavigationController.h"

@implementation BANavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController title:(NSString *)aTitle{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self setTitle:aTitle];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
