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
    NSString  *player1;
    NSString  *player2;
    NSString  *title;
    NSString  *round;
    NSString  *set;
    NSString  *winner;
    NSString  *time;
    NSString  *date;
    NSString  *link;
    NSString  *provider;
}

@synthesize player1 = player1;
@synthesize player2 = player2;
@synthesize title = title;
@synthesize round = round;
@synthesize set = set;
@synthesize winner = winner;
@synthesize time = time;
@synthesize date = date;
@synthesize link = link;
@synthesize provider = provider;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        player1 = [dictionary valueForKey:@"player1"];
        player2 = [dictionary valueForKey:@"player2"];
        title = [dictionary valueForKey:@"leagueName"];
        round = [[dictionary valueForKey:@"round"] stringValue];
        set = [[dictionary valueForKey:@"gameSet"] stringValue];
        winner = [dictionary valueForKey:@"winnerName"];
        time = [dictionary valueForKey:@"matchDate"];
        date = [[time componentsSeparatedByString:@" "] objectAtIndex:0];
        link = [dictionary valueForKey:@"vodLink"];
        provider = [dictionary valueForKey:@"organizer"];
    }
    return self;
}

- (NSString *)round {
    return ([round isEqualToString:@"2"]) ? @"GrandFinal" : [NSString stringWithFormat:@"Ro.%@", round];
}

@end









