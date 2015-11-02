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
    CGSize       ScreenSize;
    Player       *player1;
    Player       *player2;
    NSArray      *calcResult;
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
    [self matchCalculate];
    CGFloat origin;
    CGFloat target;
    int stackBarHeight = 25;
    int stackBarMargin = 5;
    UIView *predictView = [[UIView alloc] initWithFrame:CGRectMake(20, 350, ScreenSize.width-40, 200)];
    for (int i = 0; i < [calcResult count]; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, stackBarMargin + i * (stackBarHeight + stackBarMargin*2), predictView.frame.size.width, 15)];
        [label setText:calcResult[i][0]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setTextColor:BACloud];
        RCStackBar *stackBar = [[RCStackBar alloc] init];
        [stackBar setFrame:CGRectMake(0, i * (stackBarHeight + stackBarMargin*2), predictView.frame.size.width, stackBarHeight)];
        origin = [calcResult[i][3] floatValue];
        target = 1.0f - origin;
        [stackBar setData:[NSArray arrayWithObjects:@(origin),@(target),nil]];
        [predictView addSubview:stackBar];
        [predictView addSubview:label];
    }
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

- (void)requestPlayer:(id)viewInstance {
    
}

- (void)matchCalculate {
    MatchCalculator *calculator = [[MatchCalculator alloc] initWithPlayer1:player1 andPlayer2:player2];
    calcResult = [NSArray arrayWithArray:[calculator matchCalculate]];
}

@end
