//
//  PlayerTableViewController.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 13..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "PlayerViewController.h"

@implementation PlayerViewController

#pragma mark -BAPlayerSearchViewController Override method
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)selectPlayer:(Player *)player {
    PlayerInfoViewController *newViewController = [[PlayerInfoViewController alloc] initWithPlayer:player];
    [[self navigationController] pushViewController:newViewController animated:YES];
}

@end
