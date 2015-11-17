//
//  MatchCalculator.m
//  BattleApp
//
//  Created by mocca on 2015. 11. 2..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "MatchCalculator.h"

@implementation MatchCalculator

{
    Player         *mPlayer1;
    Player         *mPlayer2;
    Score          *competitionScore;
    NSMutableArray *returnArray;
}

@synthesize mPlayer1 = mPlayer1;
@synthesize mPlayer2 = mPlayer2;
@synthesize competitionScore = competitionScore;


- (instancetype)initWithPlayer1:(Player *)player1 andPlayer2:(Player *)player2 {
    self = [super init];
    if (self) {
        mPlayer1 = player1;
        mPlayer2 = player2;
        returnArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setCompetitionRecord {
    NSString *url = [NSString stringWithFormat:@"http://125.209.198.90/battleapp/verdict.php?pid1=%ld&pid2=%ld",(long)mPlayer1.playerId, (long)mPlayer2.playerId];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    competitionScore = [[Score alloc] initWithWin:[[jsonObject objectForKey:@"win"] intValue] lose:[[jsonObject objectForKey:@"lose"] intValue]];
}

- (void)setPlayerRecord {
    [mPlayer1 requestRecordsData];
    [mPlayer2 requestRecordsData];
}

- (NSArray *)matchCalculate {
    [self setCompetitionRecord];
    [self setPlayerRecord];
    
    float total = [self calcTotalScore];
    NSLog(@"%f", total);
    [returnArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                            @"Total Record", @"title",
                            [NSString stringWithFormat:@"%.f%%", total*100], @"leftLabel",
                            [NSString stringWithFormat:@"%.f%%", (1-total)*100], @"rightLabel",
                            @(total), @"origin",
                            nil]];
    float competition = [self calcCompetitionScore];
    [returnArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                            @"vs Record", @"title",
                            [NSString stringWithFormat:@"%.f%%", competition*100], @"leftLabel",
                            [NSString stringWithFormat:@"%.f%%", (1-competition)*100], @"rightLabel",
                            @(competition), @"origin",
                            nil]];
    
    float recent = [self calcRecentGameScore];
    [returnArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                            @"Recent 5 Games", @"title",
                            [NSString stringWithFormat:@"%.f%%", recent*100], @"leftLabel",
                            [NSString stringWithFormat:@"%.f%%", (1-recent)*100], @"rightLabel",
                            @(recent), @"origin",
                            nil]];
    
    float opposite = [self calcOppositeRaceScore];
    [returnArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                            @"vs Opposite Race Record", @"title",
                            [NSString stringWithFormat:@"%.f%%", opposite*100], @"leftLabel",
                            [NSString stringWithFormat:@"%.f%%", (1-opposite)*100], @"rightLabel",
                            @(opposite), @"origin",
                            nil]];
    
    float result = [self calcMatchScoreFromTotal:total competition:competition recentGame:recent oppositeRace:opposite];
    [returnArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                            @"Match Result", @"title",
                            [NSString stringWithFormat:@"%.f%%", result*100], @"leftLabel",
                            [NSString stringWithFormat:@"%.f%%", (1-result)*100], @"rightLabel",
                            @(result), @"origin",
                            nil]];
    
    return [returnArray copy];
}

- (float)calcTotalScore {
    float totalWinRate = mPlayer1.record.total.rate / (float)(mPlayer1.record.total.rate + mPlayer2.record.total.rate);
    totalWinRate = (isnan(totalWinRate)) ? 0.50f : totalWinRate;
    return totalWinRate;
}

- (float)calcCompetitionScore {
    float competitionWinRate = competitionScore.win / (float)(competitionScore.win + competitionScore.lose);
    competitionWinRate = (isnan(competitionWinRate)) ? 0.50f : competitionWinRate;
    return competitionWinRate;
}

- (float)calcRecentGameScore {
    float recentGameWinRate = mPlayer1.record.recent5.rate / (float)(mPlayer1.record.recent5.rate + mPlayer2.record.recent5.rate);
    recentGameWinRate = (isnan(recentGameWinRate)) ? 0.50f : recentGameWinRate;
    return recentGameWinRate;
}

- (float)calcOppositeRaceScore {
    Score *p1OppositeRaceScore = [mPlayer1 oppositeRaceScoreByRaceName:[mPlayer2 race]];
    Score *p2OppositeRaceScore = [mPlayer1 oppositeRaceScoreByRaceName:[mPlayer1 race]];
    float player1WinRate = p1OppositeRaceScore.rate;
    float player2WinRate = p2OppositeRaceScore.rate;
    float oppositeRaceWinRate = player1WinRate / (float)(player1WinRate + player2WinRate);
    oppositeRaceWinRate = (isnan(oppositeRaceWinRate)) ? 0.50f : oppositeRaceWinRate;
    return oppositeRaceWinRate;
}

- (float)calcMatchScoreFromTotal:(float)totalScore competition:(float)competition recentGame:(float)recentGameScore oppositeRace:(float)oppositeRaceScore {
    totalScore *= 100.0f;
    competition *= 100.0f;
    recentGameScore *= 100.0f;
    oppositeRaceScore *= 100.0f;
    float matchScore = (totalScore+competition+recentGameScore+oppositeRaceScore) / 400.0f;
    return matchScore;
}

@end
