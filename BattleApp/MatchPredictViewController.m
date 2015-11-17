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
    CGSize       screenSize;
    Player       *player1;
    Player       *player2;
    NSArray      *calcResult;
    UIScrollView *mainScrollView;
}

#pragma mark -Initialize methods
- (instancetype)initWithPlayer1:(Player *)aPlayer1 player2:(Player *)aPlayer2 {
    self = [super init];
    if (self) {
        player1 = aPlayer1;
        player2 = aPlayer2;
        [self setTitle:@"REPORT"];
    }
    return self;
}

#pragma mark -UIViewController implement methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor wetAsphaltColor]];
    screenSize = [[UIScreen mainScreen] bounds].size;
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -Setup view methods
- (void)setupViews {
    if([self checkEmptyPlayer]) return;
    [self setupMainScrollView];
    [self setupPlayerStandView];
    [self setupPredictView];
}

- (void)setupMainScrollView {
    mainScrollView = [[UIScrollView alloc] init];
    [mainScrollView setFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    [mainScrollView setContentSize:CGSizeMake(screenSize.width, 600)];
    [[self view] addSubview:mainScrollView];
}

- (void)setupPlayerStandView {
    MatchPlayerStandView *standView = [[MatchPlayerStandView alloc] initWithDelegate:self];
    [[standView player1View] setupPlayer:player1];
    [[standView player2View] setupPlayer:player2];
    [standView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150)];
    [mainScrollView addSubview:standView];
}

- (void)setupPredictView {
    [self matchCalculate];
    CGFloat origin;
    CGFloat target;
    int stackBarHeight = 60;
    int stackBarMargin = 5;
    
    UIView *predictView = [[UIView alloc] initWithFrame:CGRectMake(20, 250, screenSize.width-40, 200)];
    
    for (int i = 0; i < [calcResult count]; i++) {
        RCStackBar *stackBar = [[RCStackBar alloc] init];
        [stackBar setFrame:CGRectMake(0, i * (stackBarHeight + stackBarMargin*2), predictView.frame.size.width, 4)];
        origin = [[calcResult[i] objectForKey:@"origin"] floatValue];
        target = 1.0f - origin;
        [stackBar setData:[NSArray arrayWithObjects:@(origin),@(target),nil]];
        [stackBar setBarColors:[NSArray arrayWithObjects:[UIColor emeraldColor],[UIColor baPurpleColor],nil]];
        [predictView addSubview:stackBar];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, (i * (stackBarHeight + stackBarMargin*2))-18, predictView.frame.size.width, 13)];
        [label setText:[calcResult[i] valueForKey:@"title"]];
        [label setFont:[UIFont boldSystemFontOfSize:13]];
        [label setTextColor:[UIColor silverColor]];
        [predictView addSubview:label];
        
        UILabel *leftLabel = [[UILabel alloc] init];
        [leftLabel setFrame:CGRectMake(0, stackBar.frame.origin.y+stackBar.frame.size.height+3, stackBar.frame.size.width / 2, 25)];
        [leftLabel setText:[calcResult[i] valueForKey:@"leftLabel"]];
        [leftLabel setTextColor:[UIColor emeraldColor]];
        [leftLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:30]];
        [predictView addSubview:leftLabel];
        
        UILabel *rightLabel = [[UILabel alloc] init];
        [rightLabel setFrame:CGRectMake(stackBar.frame.size.width / 2, stackBar.frame.origin.y+stackBar.frame.size.height+3, stackBar.frame.size.width / 2, 25)];
        [rightLabel setText:[calcResult[i] valueForKey:@"rightLabel"]];
        [rightLabel setTextColor:[UIColor baPurpleColor]];
        [rightLabel setTextAlignment:NSTextAlignmentRight];
        [rightLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:30]];
        [predictView addSubview:rightLabel];
    }
    [mainScrollView addSubview:predictView];
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
