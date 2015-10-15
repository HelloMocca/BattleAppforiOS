//
//  LeagueInfoViewController.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 15..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "LeagueInfoViewController.h"

@implementation LeagueInfoViewController

{
    League *league;
    CGSize screenSize;
}

- (instancetype)initWithLeague:(League *)aLeague {
    self = [super init];
    if (self) {
        league = aLeague;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    screenSize = [[UIScreen mainScreen] bounds].size;
    [[self view] setBackgroundColor:[UIColor colorWithRed:14/255.0f green:14/255.0f blue:14/255.0f alpha:1]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
