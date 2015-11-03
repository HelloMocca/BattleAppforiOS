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
    
    UIView *leagueLabelView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, screenSize.width, 150)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, screenSize.width-20, 25)];
    [titleLabel setText:[league title]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [titleLabel setTextColor:[UIColor baWhiteColor]];
    [leagueLabelView addSubview:titleLabel];
    
    UILabel *openDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 25+5, screenSize.width-20, 25)];
    [openDateLabel setText:[league openDate]];
    [openDateLabel setFont:[UIFont systemFontOfSize:15]];
    [openDateLabel setTextColor:[UIColor baWhiteColor]];
    [leagueLabelView addSubview:openDateLabel];
    
    [[self view] addSubview:leagueLabelView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
