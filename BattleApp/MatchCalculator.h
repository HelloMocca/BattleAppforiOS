//
//  MatchCalculator.h
//  BattleApp
//
//  Created by mocca on 2015. 11. 2..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"

@interface MatchCalculator : NSObject

@property (nonatomic, readonly)  Player   *mPlayer1;
@property (nonatomic, readonly)  Player   *mPlayer2;
@property (nonatomic, readwrite) Score   *competitionScore;

- (instancetype)initWithPlayer1:(Player *)player1 andPlayer2:(Player *)player2 andCompetitionScore:(Score *)score;

- (NSArray *)matchCalculate;

@end
