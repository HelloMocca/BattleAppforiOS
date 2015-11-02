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
    Player   *mPlayer1;
    Player   *mPlayer2;
    BARecord competitionRecord;
    NSMutableArray *returnArray;
}

@synthesize mPlayer1 = mPlayer1;
@synthesize mPlayer2 = mPlayer2;
@synthesize competitionRecord = competitionRecord;


- (instancetype)initWithPlayer1:(Player *)player1 andPlayer2:(Player *)player2 {
    self = [super init];
    if (self) {
        mPlayer1 = player1;
        mPlayer2 = player2;
        returnArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)getCompetitionRecord {
    NSString *url = [NSString stringWithFormat:@"http://125.209.198.90/battleapp/verdict.php?pid1=%ld&pid2=%ld",mPlayer1.playerId, mPlayer2.playerId];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    competitionRecord.win = [[jsonObject valueForKey:@"win"] integerValue];
    competitionRecord.lose = [[jsonObject valueForKey:@"lose"] integerValue];
}

- (void)getPlayerRecord {
    [mPlayer1 requestRecordsData];
    [mPlayer2 requestRecordsData];
}

- (NSArray *)matchCalculate {
    [self getCompetitionRecord];
    [self getPlayerRecord];
    
    float total = [self calcTotalScore];
    [returnArray addObject:@[@"Total Record",@"",@"",@(total)]];
    float competition = [self calcCompetitionScore];
    [returnArray addObject:@[@"vs Record",@"",@"",@(competition)]];
    float recent = [self calcRecentGameScore];
    [returnArray addObject:@[@"Recent 5 Games",@"",@"",@(recent)]];
    float opposite = [self calcOppositeRaceScore];
    [returnArray addObject:@[@"Opposite Race",@"",@"",@(opposite)]];
    float result = [self calcMatchScoreFromTotal:total competition:competition recentGame:recent oppositeRace:opposite];
    [returnArray addObject:@[@"Match Result",@"",@"",@(result)]];
    return [returnArray copy];
}

- (float)calcTotalScore {
    float player1WinRate = [mPlayer1 totalRecord].win*1.0f / ([mPlayer1 totalRecord].win + [mPlayer1 totalRecord].lose)*1.0f;
    float player2WinRate = [mPlayer2 totalRecord].win*1.0f / ([mPlayer2 totalRecord].win + [mPlayer2 totalRecord].lose)*1.0f;
    player1WinRate = (isnan(player1WinRate)) ? 0 : player1WinRate;
    player2WinRate = (isnan(player2WinRate)) ? 0 : player2WinRate;
    if (player1WinRate == 0 && player2WinRate == 0) {
        return 0.50f;
    }
    float winRateScore = player1WinRate*100.0f / (player1WinRate*100.0f + player2WinRate*100.0f);
    return winRateScore;
}

- (float)calcCompetitionScore {
    float competitionWinRate = competitionRecord.win*1.0f / (competitionRecord.win + competitionRecord.lose)*1.0f;
    competitionWinRate = (isnan(competitionWinRate)) ? 0.50f : competitionWinRate;
    return competitionWinRate;
}

- (float)calcRecentGameScore {
    float player1RecentGame = ([mPlayer1 recent5Record].win*1.0f) / ([mPlayer1 recent5Record].win + [mPlayer1 recent5Record].lose)*1.0f;
    float player2RecentGame = ([mPlayer2 recent5Record].win*1.0f) / ([mPlayer2 recent5Record].win + [mPlayer2 recent5Record].lose)*1.0f;
    player1RecentGame = (isnan(player1RecentGame)) ? 0 : player1RecentGame;
    player2RecentGame = (isnan(player2RecentGame)) ? 0 : player2RecentGame;
    if (player1RecentGame == 0 && player2RecentGame == 0) {
        return 0.50f;
    }
    float recentGameWinRate = player1RecentGame*100.0f / (player1RecentGame*100.0f + player2RecentGame*100.0f);
    return recentGameWinRate;
}

- (float)calcOppositeRaceScore {
    BARecord p1OppositeRaceScore = [mPlayer1 getOppositeRaceRecordByRaceName:[mPlayer2 race]];
    BARecord p2OppositeRaceScore = [mPlayer1 getOppositeRaceRecordByRaceName:[mPlayer1 race]];
    float player1WinRate = (p1OppositeRaceScore.win*1.0f) / (p1OppositeRaceScore.win + p1OppositeRaceScore.lose)*1.0f;
    float player2WinRate = (p2OppositeRaceScore.lose*1.0f) / (p2OppositeRaceScore.win + p2OppositeRaceScore.lose)*1.0f;
    player1WinRate = (isnan(player1WinRate)) ? 0 : player1WinRate;
    player2WinRate = (isnan(player2WinRate)) ? 0 : player2WinRate;
    if (player1WinRate == 0 && player2WinRate == 0) {
        return 0.50f;
    }
    float winRateScore = player1WinRate*100.0f / (player1WinRate * 100.0f + player2WinRate * 100.0f);
    return winRateScore;
}

- (float)calcMatchScoreFromTotal:(float)totalScore competition:(float)competitionScore recentGame:(float)recentGameScore oppositeRace:(float)oppositeRaceScore {
    totalScore *= 100.0f;
    competitionScore *= 100.0f;
    recentGameScore *= 100.0f;
    oppositeRaceScore *= 100.0f;
    float matchScore = (totalScore+competitionScore+recentGameScore+oppositeRaceScore) / 400.0f;
    return matchScore;
}

@end
