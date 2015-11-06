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
    Record   *record;
}

@synthesize playerId = playerId;
@synthesize playId = playId;
@synthesize name = name;
@synthesize race = race;
@synthesize team = team;
@synthesize thumbnail = thumbnail;
@synthesize record = record;

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

- (void)setRecordWithDictionary:(NSDictionary *)dictionary {
    record = [[Record alloc] initWithDictionary:dictionary];
}

- (void)requestRecordsData {
    //Synchronous request...
    NSString *url = [NSString stringWithFormat:@"http://125.209.198.90/battleapp/playerRecords.php?pid=%ld",(long)playerId];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NO error:nil];
    record = [[Record alloc] initWithDictionary:jsonObject];
}

- (Score *)oppositeRaceScoreByRaceName:(NSString *)racename {
    racename = [racename lowercaseString];
    if ([racename isEqual:@"terran"]) return record.vsTerran;
    if ([racename isEqual:@"zerg"]) return record.vsZerg;
    return record.vsProtoss;
}

- (UIImage *)thumbnail {
    if (thumbnail == nil) {
        NSString *url = [NSString stringWithFormat:@"http://125.209.198.90/battleapp/profile/%ld.png",(long)playerId];
        NSURL *thumbnailUrl = [NSURL URLWithString:url];
        thumbnail = [UIImage imageWithData:[NSData dataWithContentsOfURL:thumbnailUrl]];
        if (thumbnail == nil) {
            thumbnail = [UIImage imageNamed:@"noprofile"];
        }
    }
    return thumbnail;
}

@end
