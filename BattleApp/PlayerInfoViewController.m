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
    UIView   *playerLabelView;
    UIView   *playerAnalysisView;
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
    [playerImageView setFrame:CGRectMake(15, 80, 95, 110)];
    [[self view] addSubview:playerImageView];
}

- (void)setupPlayerLabelView {
    playerLabelView = [[UIView alloc] initWithFrame:CGRectMake(130, 100, screenSize.width-130, 80)];
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, playerLabelView.bounds.size.width, 50)];
    [nameLabel setText:player.playId];
    [nameLabel setTextColor:[UIColor sunflowerColor]];
    [nameLabel setFont:[UIFont boldSystemFontOfSize:25.0f]];
    UILabel *teamLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, playerLabelView.bounds.size.width, 50)];
    [teamLabel setText:player.team];
    [teamLabel setTextColor:[UIColor peterBlueColor]];
    [teamLabel setFont:[UIFont systemFontOfSize:15.0f]];
    UILabel *raceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, playerLabelView.bounds.size.width, 50)];
    [raceLabel setText:player.race];
    [raceLabel setTextColor:[UIColor peterBlueColor]];
    [raceLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [playerLabelView addSubview:nameLabel];
    [playerLabelView addSubview:teamLabel];
    [playerLabelView addSubview:raceLabel];
    [[self view] addSubview:playerLabelView];
}

- (void)setupPlayerAnalysisView {
    playerAnalysisView = [[UIView alloc] initWithFrame:CGRectMake(0, 215, screenSize.width, 200)];
    [playerAnalysisView setBackgroundColor:[UIColor colorWithRed:0.110f green:0.110f blue:0.125f alpha:1.00f]];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, playerAnalysisView.bounds.size.width-10, 15)];
    [title setText:@"Player Records"];
    [title setTextColor:[UIColor colorWithRed:0.427f green:0.427f blue:0.427f alpha:1.00f]];
    [title setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [playerAnalysisView addSubview:title];
    
    [self requestPlayerData];
    [self setupTotalRecordChart];
    [self setupDoughnutChart];
    
    [[self view] addSubview:playerAnalysisView];
}

- (void)setupTotalRecordChart {
    CGFloat chartMargin = 15;
    RCSingleBar *totalScoreBar = [[RCSingleBar alloc] initWithFrame:CGRectMake(chartMargin, 35, screenSize.width-(2*chartMargin), 20)];
    [totalScoreBar setData:(player.totalRecord.win * 1.00f) / (player.totalRecord.win + player.totalRecord.lose * 1.00f)];
    [playerAnalysisView addSubview:totalScoreBar];
}

- (void)setupDoughnutChart {
    RCDoughnut *terranDonut = [[RCDoughnut alloc] init];
    [terranDonut setFrame:CGRectMake(15, 70, (screenSize.width/3)-30, (screenSize.width/3)-30)];
    [terranDonut setRatio:(player.vsTerranRecord.win * 1.00f) / (player.vsTerranRecord.win + player.vsTerranRecord.lose * 1.00f)];
    [terranDonut setTitle:@"vsTerran"];
    [playerAnalysisView addSubview:terranDonut];
    
    RCDoughnut *zergDonut = [[RCDoughnut alloc] init];
    [zergDonut setFrame:CGRectMake((15*2)+(screenSize.width/3)-15, 70, (screenSize.width/3)-30, (screenSize.width/3)-30)];
    [zergDonut setRatio:(player.vsZergRecord.win * 1.00f) / (player.vsZergRecord.win + player.vsZergRecord.lose * 1.00f)];
    [zergDonut setTitle:@"vsZerg"];
    [playerAnalysisView addSubview:zergDonut];
    
    RCDoughnut *protossDonut = [[RCDoughnut alloc] init];
    [protossDonut setFrame:CGRectMake((15*3)+(((screenSize.width/3)-15) * 2), 70, (screenSize.width/3)-30, (screenSize.width/3)-30)];
    [protossDonut setRatio:(player.vsProtossRecord.win * 1.00f) / (player.vsProtossRecord.win + player.vsProtossRecord.lose * 1.00f)];
    [protossDonut setTitle:@"vsProtoss"];
    [playerAnalysisView addSubview:protossDonut];
}

- (void)setupPlayerPastEventView {
    UIView *playerPastEventView = [[UIView alloc] initWithFrame:CGRectMake(0, 430, screenSize.width, 500)];
    [playerPastEventView setBackgroundColor:[UIColor colorWithRed:0.110f green:0.110f blue:0.125f alpha:1.00f]];
    UILabel *title  = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, playerPastEventView.bounds.size.width-10, 15)];
    [title setText:@"Past Matches"];
    [title setTextColor:[UIColor colorWithRed:0.427f green:0.427f blue:0.427f alpha:1.00f]];
    [title setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [playerPastEventView addSubview:title];
    [[self view] addSubview:playerPastEventView];
}

#pragma mark -Data request methods
- (void)requestPlayerData {
    [player requestRecordsData];
}

@end
