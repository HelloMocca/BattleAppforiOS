//
//  SearchViewController.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 12..
//  Copyright (c) 2015년 mocca. All rights reserved.
//  references @
//  apple developer sample code : CustomAppearance/CustomAppearanceViewController.m
//

#import "SearchViewController.h"

@implementation SearchViewController

{
    CGSize screenSize;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setTitle:@"Player Search"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
