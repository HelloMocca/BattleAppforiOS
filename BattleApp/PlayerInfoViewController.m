//
//  PlayerInfoViewController.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 15..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "PlayerInfoViewController.h"

@implementation PlayerInfoViewController

{
    Player *player;
    UIView *playerLabelView;
    CGSize screenSize;
}

#pragma mark -Initialize methods
- (instancetype)initWithPlayer:(Player *)aPlayer {
    self = [super init];
    player = aPlayer;
    [self setTitle:@"Player Information"];
    return self;
}

#pragma mark -UIViewController implements
- (void)viewDidLoad {
    [super viewDidLoad];
    screenSize = [[UIScreen mainScreen] bounds].size;
    [[self view] setBackgroundColor:[UIColor colorWithRed:14/255.0f green:14/255.0f blue:14/255.0f alpha:1]];
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -Setup Views
- (void)setupViews {
    [self setupPlayerImageView];
    [self setupPlayerLabelView];
    [self setupPlayerAnalysisView];
    [self setupPlayerPastEventView];
}

- (void)setupPlayerImageView {
    UIImageView *playerImageView = [[UIImageView alloc] initWithImage:[player thumbnail]];
    [playerImageView setFrame:CGRectMake(10, 80, 100, 110)];
    [[self view] addSubview:playerImageView];
}

- (void)setupPlayerLabelView {
    playerLabelView = [[UIView alloc] initWithFrame:CGRectMake(130, 100, screenSize.width-130, 80)];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, playerLabelView.bounds.size.width, 50)];
    [nameLabel setText:player.playId];
    [nameLabel setTextColor:[UIColor colorWithRed:0.141f green:0.608f blue:0.863f alpha:1.00f]];
    [nameLabel setFont:[UIFont boldSystemFontOfSize:25.0f]];
    UILabel *teamLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, playerLabelView.bounds.size.width, 50)];
    [teamLabel setText:player.team];
    [teamLabel setTextColor:[UIColor colorWithRed:0.125f green:0.514f blue:0.659f alpha:1.00f]];
    [teamLabel setFont:[UIFont systemFontOfSize:15.0f]];
    UILabel *raceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, playerLabelView.bounds.size.width, 50)];
    [raceLabel setText:player.race];
    [raceLabel setTextColor:[UIColor colorWithRed:0.125f green:0.514f blue:0.659f alpha:1.00f]];
    [raceLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [playerLabelView addSubview:nameLabel];
    [playerLabelView addSubview:teamLabel];
    [playerLabelView addSubview:raceLabel];
    [[self view] addSubview:playerLabelView];
}

- (void)setupPlayerAnalysisView {
    UIView *playerAnalysisView = [[UIView alloc] initWithFrame:CGRectMake(0, 215, screenSize.width, 150)];
    [playerAnalysisView setBackgroundColor:[UIColor colorWithRed:0.110f green:0.110f blue:0.125f alpha:1.00f]];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, playerAnalysisView.bounds.size.width-10, 15)];
    [title setText:@"Player Records"];
    [title setTextColor:[UIColor colorWithRed:0.427f green:0.427f blue:0.427f alpha:1.00f]];
    [title setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [playerAnalysisView addSubview:title];
    [[self view] addSubview:playerAnalysisView];
}

- (void)setupPlayerPastEventView {
    UIView *playerPastEventView = [[UIView alloc] initWithFrame:CGRectMake(0, 380, screenSize.width, 500)];
    [playerPastEventView setBackgroundColor:[UIColor colorWithRed:0.110f green:0.110f blue:0.125f alpha:1.00f]];
    UILabel *title  = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, playerPastEventView.bounds.size.width-10, 15)];
    [title setText:@"Past Matches"];
    [title setTextColor:[UIColor colorWithRed:0.427f green:0.427f blue:0.427f alpha:1.00f]];
    [title setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [playerPastEventView addSubview:title];
    [[self view] addSubview:playerPastEventView];
}

@end
