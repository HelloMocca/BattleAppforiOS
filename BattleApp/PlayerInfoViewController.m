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
    CGSize   screenSize;
    Player   *player;
    
    UIView                  *playerLabelView;
    PlayerTotalRecordView   *totalRecordView;
    RaceRecordView          *oppositeRaceRecordView;
    UIScrollView            *mainScrollView;
}

#pragma mark -Initialize methods
- (instancetype)initWithPlayer:(Player *)aPlayer {
    self = [super init];
    if (self) {
        player = aPlayer;
        [self setTitle:@"PROFILE"];
    }
    return self;
}

#pragma mark -UIViewController Override methods
- (void)viewDidLoad {
    [super viewDidLoad];
    screenSize = [[UIScreen mainScreen] bounds].size;
    [[self view] setBackgroundColor:[UIColor colorWithRed:14/255.0f green:14/255.0f blue:14/255.0f alpha:1]];
    [[self view] setBackgroundColor:[UIColor wetAsphaltColor]];
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -Setup view methods
- (void)setupViews {
    [self setupScrollView];
    [self setupPlayerProfileView];
    [self setupPlayerRecordView];
}

- (void)setupScrollView {
    mainScrollView = [[UIScrollView alloc] init];
    [mainScrollView setFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    [mainScrollView setContentSize:CGSizeMake(screenSize.width, 550)];
    [mainScrollView setShowsVerticalScrollIndicator:NO];
    [mainScrollView setShowsHorizontalScrollIndicator:NO];
    [mainScrollView setScrollEnabled:YES];
    [[self view] addSubview:mainScrollView];
}

- (void)setupPlayerProfileView {
    [self setupPlayerImageView];
    [self setupPlayerLabelViews];
}

- (void)setupPlayerImageView {
    float imageViewSize = 95;
    UIView *imageContainerView = [[UIView alloc] initWithFrame:CGRectMake((screenSize.width/2) - (imageViewSize / 2), 25, 95, 95)];
    UIImageView *playerImageView = [[UIImageView alloc] initWithImage:[player thumbnail]];
    
    [playerImageView setFrame:CGRectMake(0, -5, 95, 110)];
    [[imageContainerView layer] setCornerRadius:95/2];
    [[imageContainerView layer] setMasksToBounds:YES];
    
    [imageContainerView addSubview:playerImageView];
    [mainScrollView addSubview:imageContainerView];
}

- (void)setupPlayerLabelViews {
    playerLabelView = [[UIView alloc] initWithFrame:CGRectMake(0, 120, screenSize.width, 80)];
    
    UILabel *playIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, playerLabelView.bounds.size.width, 50)];
    [playIdLabel setText:player.playId];
    [playIdLabel setTextColor:[UIColor cloudColor]];
    [playIdLabel setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [playIdLabel setTextAlignment:NSTextAlignmentCenter];
    [playerLabelView addSubview:playIdLabel];
    
    UILabel *teamLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, playerLabelView.bounds.size.width, 50)];
    [teamLabel setText:player.team];
    [teamLabel setTextColor:[UIColor silverColor]];
    [teamLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [teamLabel setTextAlignment:NSTextAlignmentCenter];
    [playerLabelView addSubview:teamLabel];
    
    UILabel *raceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, playerLabelView.bounds.size.width, 50)];
    [raceLabel setText:player.race];
    [raceLabel setTextColor:[UIColor silverColor]];
    [raceLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [raceLabel setTextAlignment:NSTextAlignmentCenter];
    [playerLabelView addSubview:raceLabel];
    
    [mainScrollView addSubview:playerLabelView];
}

- (void)setupPlayerRecordView {
    [self requestPlayerData];
    [self setupTotalRecordView];
    [self setupOppositeRaceRecordView];
    [self setupShowPlayerGamesBtn];
}

- (void)setupTotalRecordView {
    totalRecordView = [[PlayerTotalRecordView alloc] initWithFrame:CGRectMake(0, 215, screenSize.width, 120)];
    [totalRecordView setBackgroundColor:[UIColor colorWithRed:0.110f green:0.110f blue:0.125f alpha:1.00f]];
    [totalRecordView setupViewsWithPlayer:player];
    [mainScrollView addSubview:totalRecordView];
}

- (void)setupOppositeRaceRecordView {
    oppositeRaceRecordView = [[RaceRecordView alloc] initWithFrame:CGRectMake(0, totalRecordView.frame.origin.y+totalRecordView.frame.size.height+10, screenSize.width, 150)];
    [oppositeRaceRecordView setBackgroundColor:[UIColor colorWithRed:0.110f green:0.110f blue:0.125f alpha:1.00f]];
    [oppositeRaceRecordView setupViewsWithPlayer:player];
    [mainScrollView addSubview:oppositeRaceRecordView];
}

- (void)setupShowPlayerGamesBtn {
    if ([player.record.games count] == 0) return;
    
    UIButton *showPlayerGamesBtn = [[UIButton alloc] init];
    [showPlayerGamesBtn setFrame:CGRectMake(5, oppositeRaceRecordView.frame.origin.y+oppositeRaceRecordView.frame.size.height+10, screenSize.width-10, 35)];
    [showPlayerGamesBtn setBackgroundColor:[UIColor colorWithRed:0.353f green:0.376f blue:0.784f alpha:1.00f]];
    [showPlayerGamesBtn setBackgroundColor:[UIColor alizalinColor]];
    [showPlayerGamesBtn setTitle:@"Show Player Games" forState:UIControlStateNormal];
    [showPlayerGamesBtn addTarget:self action:@selector(showPlayerGames:) forControlEvents:UIControlEventTouchUpInside];
    [mainScrollView addSubview:showPlayerGamesBtn];
}

#pragma mark -Data request methods
- (void)requestPlayerData {
    [player requestRecordsData];
}

#pragma mark -Event handle methods
- (IBAction)showPlayerGames:(id)sender {
    BAGameTableViewController *gameTableView = [[BAGameTableViewController alloc] initWithGames:player.record.games];
    [[self navigationController] pushViewController:gameTableView animated:YES];
}

@end
