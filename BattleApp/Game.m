//
//  Game.m
//  BattleApp
//
//  Created by mocca on 2015. 11. 3..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "Game.h"

@implementation Game
{
    NSString *player1;
    NSString *player2;
    NSString *title;
    NSString *round;
    NSString *set;
    NSString *winner;
    NSString *time;
    NSString *link;
}

@synthesize player1 = player1;
@synthesize player2 = player2;
@synthesize title = title;
@synthesize round = round;
@synthesize set = set;
@synthesize winner = winner;
@synthesize time = time;
@synthesize link = link;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        player1 = [dictionary valueForKey:@"player1"];
        player2 = [dictionary valueForKey:@"player2"];
        title = [dictionary valueForKey:@"leagueName"];
        round = [dictionary valueForKey:@"round"];
        set = [dictionary valueForKey:@"gameSet"];
        winner = [dictionary valueForKey:@"winnerName"];
        time = [dictionary valueForKey:@"matchDate"];
        link = [dictionary valueForKey:@"vodLink"];
    }
    return self;
}

@end
