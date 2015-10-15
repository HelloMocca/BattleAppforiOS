//
//  Player.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 13..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "Player.h"

@implementation Player

{
    NSInteger playerId;
    NSString *playId;
    NSString *name;
    NSString *race;
    NSString *team;
    UIImage  *thumbnail;
}

@synthesize playerId = playerId;
@synthesize playId = playId;
@synthesize name = name;
@synthesize race = race;
@synthesize team = team;
@synthesize thumbnail = thumbnail;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        playerId = [[dictionary valueForKey:@"id"] integerValue];
        playId = [dictionary valueForKey:@"playId"];
        name = [dictionary valueForKey:@"name"];
        race = [dictionary valueForKey:@"race"];
        team = [dictionary valueForKey:@"team"];
        thumbnail = nil;
    }
    return self;
}

- (UIImage *)thumbnail {
    if (thumbnail == nil) {
        NSURL *thumbnailUrl = [NSURL URLWithString:[[@"http://125.209.198.90/battleapp/profile/" stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)playerId]] stringByAppendingString:@".png"]];
        NSLog(@"%@", thumbnailUrl);
        thumbnail = [UIImage imageWithData:[NSData dataWithContentsOfURL:thumbnailUrl]];
        if (thumbnail == nil) {
            thumbnail = [UIImage imageNamed:@"noprofile"];
        }
    }
    return thumbnail;
}

@end
