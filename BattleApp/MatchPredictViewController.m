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
    
    UIScrollView         *mainScrollView;
    MatchPlayerStandView *standView;
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
    [self requestPlayerRecords];
}

- (void)setupMainScrollView {
    mainScrollView = [[UIScrollView alloc] init];
    [mainScrollView setFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    [[self view] addSubview:mainScrollView];
}

- (void)setupPlayerStandView {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = width * 0.65;
    
    standView = [[MatchPlayerStandView alloc] initWithDelegate:self];
    [[standView player1View] setupPlayer:player1];
    [[standView player2View] setupPlayer:player2];
    [standView setFrame:CGRectMake(0, 0, width, height)];
    [mainScrollView addSubview:standView];
}

- (void)setupPredictView {
    CGFloat origin;
    CGFloat target;
    int stackBarHeight = 60;
    int stackBarMargin = 5;
    
    UIView *predictView = [[UIView alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(standView.frame)+25, screenSize.width-40, 350)];
    
    for (int i = 0; i < [calcResult count]; i++) {
        RCStackBar *stackBar = [[RCStackBar alloc] init];
        [stackBar setFrame:CGRectMake(0, i * (stackBarHeight + stackBarMargin*2)+18, predictView.frame.size.width, 4)];
        origin = [[calcResult[i] objectForKey:@"origin"] floatValue];
        target = 1.0f - origin;
        [stackBar setData:[NSArray arrayWithObjects:@(origin),@(target),nil]];
        [stackBar setBarColors:[NSArray arrayWithObjects:[UIColor emeraldColor],[UIColor lightCoralColor],nil]];
        [predictView addSubview:stackBar];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, (i * (stackBarHeight + stackBarMargin*2)), CGRectGetWidth(predictView.frame), 13)];
        [label setText:[calcResult[i] valueForKey:@"title"]];
        [label setFont:[UIFont boldSystemFontOfSize:13]];
        [label setTextColor:[UIColor silverColor]];
        [predictView addSubview:label];
        
        UILabel *leftLabel = [[UILabel alloc] init];
        [leftLabel setFrame:CGRectMake(0, CGRectGetMaxY(stackBar.frame) + 3, CGRectGetWidth(stackBar.frame) / 2, 25)];
        [leftLabel setText:[calcResult[i] valueForKey:@"leftLabel"]];
        [leftLabel setTextColor:[UIColor emeraldColor]];
        [leftLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:30]];
        [predictView addSubview:leftLabel];
        
        UILabel *rightLabel = [[UILabel alloc] init];
        [rightLabel setFrame:CGRectMake(CGRectGetWidth(stackBar.frame) / 2, CGRectGetMaxY(stackBar.frame) + 3, CGRectGetWidth(stackBar.frame) / 2, 25)];
        [rightLabel setText:[calcResult[i] valueForKey:@"rightLabel"]];
        [rightLabel setTextColor:[UIColor lightCoralColor]];
        [rightLabel setTextAlignment:NSTextAlignmentRight];
        [rightLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Thin" size:30]];
        [predictView addSubview:rightLabel];
    }
    [mainScrollView addSubview:predictView];
    
    [mainScrollView setContentSize:CGSizeMake(screenSize.width, CGRectGetMaxY(predictView.frame) + 25)];
}

#pragma mark -Condition check methods
- (BOOL)checkEmptyPlayer {
    if (player1 == nil || player2 == nil) {
        NSLog(@"%@",@"MatchPredictViewController: Empty Player Exist");
        return YES;
    }
    return NO;
}

#pragma mark -PlayerDescViewDelegate methods
- (void)requestPlayer:(id)viewInstance{}

- (void)requestPlayerRecords {
    NSString *player1url = [NSString stringWithFormat:@"http://125.209.198.90/battleapp/playerRecords.php?pid=%lu",(long)[player1 playerId]];
    [BAHttpTask requestJSONObjectFromURL:[NSURL URLWithString:player1url] compeleteHandler:^(NSURLResponse *response, NSDictionary *jsonObject, NSError *connectionError){
        [self performSelectorOnMainThread:@selector(setPlayer1Records:) withObject:jsonObject waitUntilDone:NO];
    }];
}

- (void)requestPlayer2Records {
    NSString *player2url = [NSString stringWithFormat:@"http://125.209.198.90/battleapp/playerRecords.php?pid=%lu",(long)[player2 playerId]];
    [BAHttpTask requestJSONObjectFromURL:[NSURL URLWithString:player2url] compeleteHandler:^(NSURLResponse *response, NSDictionary *jsonObject, NSError *connectionError){
        [self performSelectorOnMainThread:@selector(setPlayer2Records:) withObject:jsonObject waitUntilDone:NO];
    }];
}

- (void)requestCompetitionRecord {
    NSString *url = [NSString stringWithFormat:@"http://125.209.198.90/battleapp/verdict.php?pid1=%ld&pid2=%ld",(long)player1.playerId, (long)player2.playerId];
    
    [BAHttpTask requestJSONObjectFromURL:[NSURL URLWithString:url] compeleteHandler:^(NSURLResponse *response, NSDictionary *jsonObject, NSError *connectionError) {
        Score *competitionScore = [[Score alloc] initWithWin:[[jsonObject objectForKey:@"win"] intValue] lose:[[jsonObject objectForKey:@"lose"] intValue]];
        [self performSelectorOnMainThread:@selector(matchCalculateWithCompetitionScore:) withObject:competitionScore waitUntilDone:NO];
    }];
}

- (void)setPlayer1Records:(NSDictionary *)dict {
    [player1 setRecordWithDictionary:dict];
    [self requestPlayer2Records];
}

- (void)setPlayer2Records:(NSDictionary *)dict {
    [player2 setRecordWithDictionary:dict];
    [self requestCompetitionRecord];
}

#pragma mark -Others
- (void)matchCalculateWithCompetitionScore:(Score *)competitionScore {
    MatchCalculator *calculator = [[MatchCalculator alloc] initWithPlayer1:player1 andPlayer2:player2 andCompetitionScore:competitionScore];
    calcResult = [NSArray arrayWithArray:[calculator matchCalculate]];
    [self setupPredictView];
}

@end
