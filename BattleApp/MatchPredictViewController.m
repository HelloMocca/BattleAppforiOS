//
//  MatchPredictViewController.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 22..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "MatchPredictViewController.h"

@implementation MatchPredictViewController

{
    CGSize ScreenSize;
    Player *player1;
    Player *player2;
}

#pragma mark -Initialize methods
- (instancetype)initWithPlayer1:(Player *)aPlayer1 player2:(Player *)aPlayer2 {
    self = [super init];
    if (self) {
        player1 = aPlayer1;
        player2 = aPlayer2;
    }
    return self;
}

#pragma mark -UIViewController implement methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor colorWithWhite:13/225.0f alpha:1]];
    ScreenSize = [[UIScreen mainScreen] bounds].size;
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -Setup view methods
- (void)setupViews {
    if([self checkEmptyPlayer]) return;
    [self setupPlayerStandView];
    [self setupPredictView];
}

- (void)setupPlayerStandView {
    MatchPlayerStandView *standView = [[MatchPlayerStandView alloc] initWithDelegate:self];
    [[standView player1View] setupPlayer:player1];
    [[standView player2View] setupPlayer:player2];
    [[self view] addSubview:standView];
}

- (void)setupPredictView {
    UIView *predictView = [[UIView alloc] initWithFrame:CGRectMake(20, 350, ScreenSize.width-40, 200)];
    
    UILabel *firstUILabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, predictView.frame.size.width, 15)];
    [firstUILabel setText:@"Total Records"];
    [firstUILabel setTextAlignment:NSTextAlignmentCenter];
    [firstUILabel setTextColor:BACloud];
    RCStackBar *firstStackBar = [[RCStackBar alloc] init];
    [firstStackBar setFrame:CGRectMake(0, 0, predictView.frame.size.width, 25)];
    [firstStackBar setData:[NSArray arrayWithObjects:@(0.65f),@(0.35f),nil]];
    [predictView addSubview:firstStackBar];
    [predictView addSubview:firstUILabel];
    
    UILabel *secondUILabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, predictView.frame.size.width, 15)];
    [secondUILabel setText:@"vs Records"];
    [secondUILabel setTextAlignment:NSTextAlignmentCenter];
    [secondUILabel setTextColor:BACloud];
    RCStackBar *secondStackBar = [[RCStackBar alloc] init];
    [secondStackBar setFrame:CGRectMake(0, 35, predictView.frame.size.width, 25)];
    [secondStackBar setData:[NSArray arrayWithObjects:@(0.45f), @(0.55f), nil]];
    [predictView addSubview:secondStackBar];
    [predictView addSubview:secondUILabel];
    
    UILabel *thirdUILabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 75, predictView.frame.size.width, 15)];
    [thirdUILabel setText:@"Recent 5 Games"];
    [thirdUILabel setTextAlignment:NSTextAlignmentCenter];
    [thirdUILabel setTextColor:BACloud];
    RCStackBar *thirdStackBar = [[RCStackBar alloc] init];
    [thirdStackBar setFrame:CGRectMake(0, 70, predictView.frame.size.width, 25)];
    [thirdStackBar setData:[NSArray arrayWithObjects:@(0.22f), @(0.78f), nil]];
    [predictView addSubview:thirdStackBar];
    [predictView addSubview:thirdUILabel];
    
    UILabel *fourthUILabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 110, predictView.frame.size.width, 15)];
    [fourthUILabel setText:@"Opposite Race"];
    [fourthUILabel setTextAlignment:NSTextAlignmentCenter];
    [fourthUILabel setTextColor:BACloud];
    RCStackBar *fourthStackBar = [[RCStackBar alloc] init];
    [fourthStackBar setFrame:CGRectMake(0, 105, predictView.frame.size.width, 25)];
    [fourthStackBar setData:[NSArray arrayWithObjects:@(0.67f), @(0.33f), nil]];
    [predictView addSubview:fourthStackBar];
    [predictView addSubview:fourthUILabel];
    
    UILabel *totalUILabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 145, predictView.frame.size.width, 15)];
    [totalUILabel setText:@"Match Verdict"];
    [totalUILabel setTextAlignment:NSTextAlignmentCenter];
    [totalUILabel setTextColor:BACloud];
    RCStackBar *totalStackBar = [[RCStackBar alloc] init];
    [totalStackBar setFrame:CGRectMake(0, 140, predictView.frame.size.width, 30)];
    [totalStackBar setData:[NSArray arrayWithObjects:@(0.38f), @(0.62f), nil]];
    [predictView addSubview:totalStackBar];
    [predictView addSubview:totalUILabel];
    
    [[self view] addSubview:predictView];
}

#pragma mark -Condition check methods
- (BOOL)checkEmptyPlayer {
    if (player1 == nil || player2 == nil) {
        NSLog(@"%@",@"MatchPredictViewController: Empty Player Exist");
        return YES;
    }
    return NO;
}

#pragma mark -PlayerDescViewDelegate implements
- (void)requestPlayer:(id)viewInstance {
    
}

@end
