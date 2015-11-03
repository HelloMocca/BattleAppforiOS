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
    UIView   *totalRecordView;
    UIView   *oppositeRaceRecordView;
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
    [self setupPlayerRecordView];
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

- (void)setupPlayerRecordView {
    [self requestPlayerData];
    [self setupTotalRecordView];
    [self setupOppositeRaceRecordView];
}

- (void)setupTotalRecordView {
    totalRecordView = [[UIView alloc] initWithFrame:CGRectMake(0, 215, screenSize.width, 120)];
    [totalRecordView setBackgroundColor:[UIColor colorWithRed:0.110f green:0.110f blue:0.125f alpha:1.00f]];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, totalRecordView.bounds.size.width-10, 15)];
    [title setText:@"Player Records"];
    [title setTextColor:[UIColor colorWithRed:0.427f green:0.427f blue:0.427f alpha:1.00f]];
    [title setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [totalRecordView addSubview:title];
    [self setupTotalRecordSubViews];
    [[self view] addSubview:totalRecordView];
}

- (void)setupTotalRecordSubViews {
    float marginLeft = (screenSize.width - 270) / 2.0f;
    float marginTop = 40;
    float labelContainerMargin = 15;
    float labelContainerWidth = 80;
    float labelContainerHeight = 65;
    NSArray *recordArray = [NSArray arrayWithObjects:@[ @(player.totalRecord.win),@"Wins"], @[ @(player.totalRecord.lose),@"Loses"],nil];
    for (int i = 0; i < [recordArray count]; i++) {
        UIView *scoreLabelContainer = [[UIView alloc] initWithFrame:CGRectMake(marginLeft+(labelContainerMargin*i)+(i*labelContainerWidth), marginTop, labelContainerWidth, labelContainerHeight)];
        UILabel *scoreValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, scoreLabelContainer.frame.size.width, 35)];
        UILabel *scoreTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, scoreValueLabel.frame.size.height+15, scoreLabelContainer.frame.size.width, 15)];
        [scoreValueLabel setText:[NSString stringWithFormat:@"%@", recordArray[i][0]]];
        [scoreValueLabel setFont:[UIFont systemFontOfSize:40]];
        [scoreValueLabel setTextAlignment:NSTextAlignmentCenter];
        [scoreTitleLabel setText:recordArray[i][1]];
        [scoreTitleLabel setFont:[UIFont systemFontOfSize:15]];
        [scoreTitleLabel setTextAlignment:NSTextAlignmentCenter];
        [scoreValueLabel setTextColor:[UIColor cloudColor]];
        [scoreTitleLabel setTextColor:[UIColor silverColor]];
        
        [scoreLabelContainer addSubview:scoreValueLabel];
        [scoreLabelContainer addSubview:scoreTitleLabel];
        [totalRecordView addSubview:scoreLabelContainer];
    }
    RCDoughnut *totalScoreDonut = [[RCDoughnut alloc] init];
    float playerWinningRate = (player.totalRecord.win * 1.00f) / (player.totalRecord.win + player.totalRecord.lose * 1.00f);
    playerWinningRate = (isnan(playerWinningRate)) ? 0 : playerWinningRate;
    [totalScoreDonut setFrame:CGRectMake(marginLeft+205, marginTop, labelContainerHeight, labelContainerHeight)];
    [totalScoreDonut setRatio: playerWinningRate];
    [totalScoreDonut setTitle:[NSString stringWithFormat:@"%.f%%", playerWinningRate*100]];
    [totalScoreDonut setTitleFont:[UIFont systemFontOfSize:25]];
    [totalScoreDonut setNumericLabelVisible:false];
    [totalRecordView addSubview:totalScoreDonut];
}

- (void)setupOppositeRaceRecordView {
    oppositeRaceRecordView = [[UIView alloc] initWithFrame:CGRectMake(0, totalRecordView.frame.origin.y+totalRecordView.frame.size.height+10, screenSize.width, 150)];
    [oppositeRaceRecordView setBackgroundColor:[UIColor colorWithRed:0.110f green:0.110f blue:0.125f alpha:1.00f]];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, oppositeRaceRecordView.bounds.size.width-10, 15)];
    [title setText:@"Opposite Race Records"];
    [title setTextColor:[UIColor colorWithRed:0.427f green:0.427f blue:0.427f alpha:1.00f]];
    [title setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [oppositeRaceRecordView addSubview:title];
    [self setupDoughnutChart];
    [[self view] addSubview:oppositeRaceRecordView];
}

- (void)setupDoughnutChart {
    RCDoughnut *terranDonut = [[RCDoughnut alloc] init];
    [terranDonut setFrame:CGRectMake(15, 40, (screenSize.width/3)-30, (screenSize.width/3)-30)];
    [terranDonut setRatio:(player.vsTerranRecord.win * 1.00f) / (player.vsTerranRecord.win + player.vsTerranRecord.lose * 1.00f)];
    [terranDonut setTitle:@"vs. Terran"];
    [oppositeRaceRecordView addSubview:terranDonut];
    
    RCDoughnut *zergDonut = [[RCDoughnut alloc] init];
    [zergDonut setFrame:CGRectMake((15*2)+(screenSize.width/3)-15, 40, (screenSize.width/3)-30, (screenSize.width/3)-30)];
    [zergDonut setRatio:(player.vsZergRecord.win * 1.00f) / (player.vsZergRecord.win + player.vsZergRecord.lose * 1.00f)];
    [zergDonut setTitle:@"vs. Zerg"];
    [oppositeRaceRecordView addSubview:zergDonut];
    
    RCDoughnut *protossDonut = [[RCDoughnut alloc] init];
    [protossDonut setFrame:CGRectMake((15*3)+(((screenSize.width/3)-15) * 2), 40, (screenSize.width/3)-30, (screenSize.width/3)-30)];
    [protossDonut setRatio:(player.vsProtossRecord.win * 1.00f) / (player.vsProtossRecord.win + player.vsProtossRecord.lose * 1.00f)];
    [protossDonut setTitle:@"vs. Protoss"];
    [oppositeRaceRecordView addSubview:protossDonut];
}

#pragma mark -Data request methods
- (void)requestPlayerData {
    [player requestRecordsData];
}

@end
