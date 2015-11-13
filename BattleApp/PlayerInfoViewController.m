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
    UIScrollView *mainScrollView;
}

#pragma mark -Initialize methods
- (instancetype)initWithPlayer:(Player *)aPlayer {
    self = [super init];
    if (self) {
        player = aPlayer;
        [self setTitle:@"Player Profile"];
    }
    return self;
}

#pragma mark -UIViewController Override methods
- (void)viewDidLoad {
    [super viewDidLoad];
    screenSize = [[UIScreen mainScreen] bounds].size;
    [[self view] setBackgroundColor:[UIColor colorWithRed:14/255.0f green:14/255.0f blue:14/255.0f alpha:1]];
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
    [mainScrollView setFrame:CGRectMake(0, -40, screenSize.width, screenSize.height)];
    [mainScrollView setContentSize:CGSizeMake(screenSize.width, 520)];
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
    UIImageView *playerImageView = [[UIImageView alloc] initWithImage:[player thumbnail]];
    [playerImageView setFrame:CGRectMake(15, 80, 95, 110)];
    [mainScrollView addSubview:playerImageView];
}

- (void)setupPlayerLabelViews {
    playerLabelView = [[UIView alloc] initWithFrame:CGRectMake(130, 100, screenSize.width-130, 80)];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, playerLabelView.bounds.size.width, 50)];
    [nameLabel setText:player.playId];
    [nameLabel setTextColor:[UIColor dodgerBlueColor]];
    [nameLabel setFont:[UIFont boldSystemFontOfSize:25.0f]];
    [playerLabelView addSubview:nameLabel];
    
    UILabel *teamLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, playerLabelView.bounds.size.width, 50)];
    [teamLabel setText:player.team];
    [teamLabel setTextColor:[UIColor peterBlueColor]];
    [teamLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [playerLabelView addSubview:teamLabel];
    
    UILabel *raceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, playerLabelView.bounds.size.width, 50)];
    [raceLabel setText:player.race];
    [raceLabel setTextColor:[UIColor peterBlueColor]];
    [raceLabel setFont:[UIFont systemFontOfSize:15.0f]];
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
    totalRecordView = [[UIView alloc] initWithFrame:CGRectMake(0, 215, screenSize.width, 120)];
    [totalRecordView setBackgroundColor:[UIColor colorWithRed:0.110f green:0.110f blue:0.125f alpha:1.00f]];
    [self setupTotalRecordViewTitle];
    [self setupTotalScoreLabelViews];
    [mainScrollView addSubview:totalRecordView];
}

- (void)setupTotalRecordViewTitle {
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, totalRecordView.bounds.size.width-10, 15)];
    [title setText:@"Player Records"];
    [title setTextColor:[UIColor baDarkGrayColor]];
    [title setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [totalRecordView addSubview:title];
}

- (void)setupTotalScoreLabelViews {
    float marginLeft = (screenSize.width - 270) / 2.0f;
    float marginTop = 40;
    float labelContainerMargin = 15;
    float labelContainerWidth = 80;
    float labelContainerHeight = 65;
    
    CGRect winScoreLabelFrame = CGRectMake(marginLeft, marginTop, labelContainerWidth, labelContainerHeight);
    [self setupTotalScoreLabelWithFrame:winScoreLabelFrame scoreValue:player.record.total.win title:@"Wins"];
    
    CGRect loseScoreLabelFrame = CGRectMake(marginLeft+labelContainerMargin+labelContainerWidth, marginTop, labelContainerWidth, labelContainerHeight);
    [self setupTotalScoreLabelWithFrame:loseScoreLabelFrame scoreValue:player.record.total.lose title:@"Loses"];
    
    [self setupTotalScoreDonutView];
}

- (void)setupTotalScoreLabelWithFrame:(CGRect)frame scoreValue:(int)value title:(NSString *)title {
    UIView *scoreLabelContainer = [[UIView alloc] initWithFrame:frame];
    
    UILabel *scoreValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, scoreLabelContainer.frame.size.width, 35)];
    [scoreValueLabel setText:[NSString stringWithFormat:@"%d", value]];
    [scoreValueLabel setFont:[UIFont systemFontOfSize:40]];
    [scoreValueLabel setTextAlignment:NSTextAlignmentCenter];
    [scoreValueLabel setTextColor:[UIColor cloudColor]];
    [scoreLabelContainer addSubview:scoreValueLabel];
    
    UILabel *scoreTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, scoreLabelContainer.frame.size.height-15, scoreLabelContainer.frame.size.width, 15)];
    [scoreTitleLabel setText:title];
    [scoreTitleLabel setFont:[UIFont systemFontOfSize:15]];
    [scoreTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [scoreTitleLabel setTextColor:[UIColor silverColor]];
    [scoreLabelContainer addSubview:scoreTitleLabel];
    
    [totalRecordView addSubview:scoreLabelContainer];
}

- (void)setupTotalScoreDonutView {
    float marginLeft = (screenSize.width - 270) / 2.0f;
    float marginTop = 40;
    float labelContainerHeight = 65;
    
    RCDoughnut *totalScoreDonut = [[RCDoughnut alloc] init];
    [totalScoreDonut setFrame:CGRectMake(marginLeft+205, marginTop, labelContainerHeight, labelContainerHeight)];
    [totalScoreDonut setRatio:  player.record.total.rate];
    [totalScoreDonut setTitle:[NSString stringWithFormat:@"%.f%%", player.record.total.percentage]];
    [totalScoreDonut setTitleFont:[UIFont systemFontOfSize:25]];
    [totalScoreDonut setNumericLabelVisible:false];
    [totalRecordView addSubview:totalScoreDonut];
}

- (void)setupOppositeRaceRecordView {
    oppositeRaceRecordView = [[UIView alloc] init];
    [oppositeRaceRecordView setFrame:CGRectMake(0, totalRecordView.frame.origin.y+totalRecordView.frame.size.height+10, screenSize.width, 150)];
    [oppositeRaceRecordView setBackgroundColor:[UIColor colorWithRed:0.110f green:0.110f blue:0.125f alpha:1.00f]];
    [self setupOppositeRaceRecordViewTitle];
    [self setupDoughnutCharts];
    [mainScrollView addSubview:oppositeRaceRecordView];
}

- (void)setupOppositeRaceRecordViewTitle {
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, oppositeRaceRecordView.bounds.size.width-10, 15)];
    [title setText:@"Opposite Race Records"];
    [title setTextColor:[UIColor baDarkGrayColor]];
    [title setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [oppositeRaceRecordView addSubview:title];
}

- (void)setupDoughnutCharts {
    CGRect terranDonutFrame = CGRectMake(15, 40, (screenSize.width/3)-30, (screenSize.width/3)-30);
    [self setupDoughnutChartWithFrame:terranDonutFrame donutRatio:player.record.vsTerran.rate title:@"vs. Terran"];
    
    CGRect zergDonutFrame = CGRectMake((15*2)+(screenSize.width/3)-15, 40, (screenSize.width/3)-30, (screenSize.width/3)-30);
    [self setupDoughnutChartWithFrame:zergDonutFrame donutRatio:player.record.vsZerg.rate title:@"vs. Zerg"];
    
    CGRect protossDonutFrame = CGRectMake((15*3)+(((screenSize.width/3)-15) * 2), 40, (screenSize.width/3)-30, (screenSize.width/3)-30);
    [self setupDoughnutChartWithFrame:protossDonutFrame donutRatio:player.record.vsProtoss.rate title:@"vs. Protoss"];
}

- (void)setupDoughnutChartWithFrame:(CGRect)frame donutRatio:(float)ratio title:(NSString *)title  {
    RCDoughnut *donut = [[RCDoughnut alloc] init];
    [donut setFrame:frame];
    [donut setRatio:ratio];
    [donut setTitle:title];
    [oppositeRaceRecordView addSubview:donut];
}

- (void)setupShowPlayerGamesBtn {
    UIButton *showPlayerGamesBtn = [[UIButton alloc] init];
    [showPlayerGamesBtn setFrame:CGRectMake(5, oppositeRaceRecordView.frame.origin.y+oppositeRaceRecordView.frame.size.height+10, screenSize.width-10, 35)];
    [showPlayerGamesBtn setBackgroundColor:[UIColor facebookBlueColor]];
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
