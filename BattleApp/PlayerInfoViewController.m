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
    [totalScoreDonut setDoughnutWidth:2];
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
    [self setupDoughnutChartWithFrame:terranDonutFrame donutRatio:player.record.vsTerran.rate title:[NSString stringWithFormat:@"%.f %%", player.record.vsTerran.percentage]];
    
    CGRect zergDonutFrame = CGRectMake((15*2)+(screenSize.width/3)-15, 40, (screenSize.width/3)-30, (screenSize.width/3)-30);
    [self setupDoughnutChartWithFrame:zergDonutFrame donutRatio:player.record.vsZerg.rate title:[NSString stringWithFormat:@"%.f %%", player.record.vsZerg.percentage]];
    
    CGRect protossDonutFrame = CGRectMake((15*3)+(((screenSize.width/3)-15) * 2), 40, (screenSize.width/3)-30, (screenSize.width/3)-30);
    [self setupDoughnutChartWithFrame:protossDonutFrame donutRatio:player.record.vsProtoss.rate title:[NSString stringWithFormat:@"%.f %%", player.record.vsProtoss.percentage]];
}

- (void)setupDoughnutChartWithFrame:(CGRect)frame donutRatio:(float)ratio title:(NSString *)title  {
    RCDoughnut *donut = [[RCDoughnut alloc] init];
    [donut setFrame:frame];
    [donut setRatio:ratio];
    [donut setTitle:title];
    [donut setTitleFont:[UIFont systemFontOfSize:20]];
    [donut setDoughnutWidth:2];
    [oppositeRaceRecordView addSubview:donut];
}

- (void)setupShowPlayerGamesBtn {
    UIButton *showPlayerGamesBtn = [[UIButton alloc] init];
    [showPlayerGamesBtn setFrame:CGRectMake(5, oppositeRaceRecordView.frame.origin.y+oppositeRaceRecordView.frame.size.height+10, screenSize.width-10, 35)];
    [showPlayerGamesBtn setBackgroundColor:[UIColor facebookBlueColor]];
    [showPlayerGamesBtn setBackgroundColor:[UIColor colorWithRed:0.353f green:0.376f blue:0.784f alpha:1.00f]];
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
