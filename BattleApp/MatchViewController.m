//
//  MatchViewController.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 12..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "MatchViewController.h"

@implementation MatchViewController

{
    MatchPlayerStandView         *standView;
}

@synthesize requestedView = requestedView;

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setTitle:@"Match Simulator"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupSubViews {
    [self setupStandView];
    [self setupButtonView];
}

- (void)setupStandView {
    standView = [[MatchPlayerStandView alloc] initWithDelegate:self];
    [[self view] addSubview:standView];
}

- (void)setupButtonView {
    CGFloat predictBtnMargin = 60;
    CGFloat predictBtnWidth = ([UIScreen mainScreen].bounds.size.width) - (2 * predictBtnMargin);
    CGFloat predictBtnHeight = 45;
    UIButton *predictBtn = [[UIButton alloc] init];
    [predictBtn setFrame:CGRectMake(predictBtnMargin, standView.frame.size.height+70+25, predictBtnWidth, predictBtnHeight)]
    ;
    [predictBtn setTitle:@"Match Prediction" forState:UIControlStateNormal];
    [predictBtn setBackgroundColor:[UIColor facebookBlueColor]];
    [predictBtn addTarget:self action:@selector(moveToPredictController:) forControlEvents:UIControlEventTouchUpInside];
    [[self view] addSubview:predictBtn];
}

#pragma mark -Delegate method
- (void)requestPlayer:(PlayerDescView *)viewInstance {
    requestedView = viewInstance;
    BAPlayerSearchViewController *playerSearchController = [[BAPlayerSearchViewController alloc] init];
    [playerSearchController setDelegate:self];
    [[self navigationController] pushViewController:playerSearchController animated:YES];
}

- (void)selectPlayer:(Player *)player {
    [requestedView setupPlayer:player];
    [[self navigationController] popToViewController:self animated:YES];
}

#pragma mark -Event handle method
- (IBAction)moveToPredictController:(id)sender {
    if (![standView isAllPlayerSelected]) return;
    MatchPredictViewController *predictViewController = [MatchPredictViewController alloc];
    predictViewController = [predictViewController initWithPlayer1:[[standView player1View] player ] player2:[[standView player2View] player]];
    [[self navigationController] pushViewController:predictViewController animated:YES];
}

@end
