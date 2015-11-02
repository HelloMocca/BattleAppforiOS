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
    BARecord totalRecord;
    BARecord recent5Record;
    BARecord vsTerranRecord;
    BARecord vsZergRecord;
    BARecord vsProtossRecord;
}

@synthesize playerId = playerId;
@synthesize playId = playId;
@synthesize name = name;
@synthesize race = race;
@synthesize team = team;
@synthesize thumbnail = thumbnail;
@synthesize totalRecord = totalRecord;
@synthesize recent5Record = recent5Record;
@synthesize vsTerranRecord = vsTerranRecord;
@synthesize vsZergRecord = vsZergRecord;
@synthesize vsProtossRecord = vsProtossRecord;

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

- (void)requestRecordsData {
    //Synchronous request...
    NSString *url = [NSString stringWithFormat:@"http://125.209.198.90/battleapp/playerRecords.php?pid=%ld",(long)playerId];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    totalRecord.win = [[jsonObject valueForKey:@"win"] integerValue];
    totalRecord.lose = [[jsonObject valueForKey:@"lose"] integerValue];
    NSString *tempStr = [jsonObject valueForKey:@"recent5Games"];
    recent5Record.win = [[[tempStr componentsSeparatedByString:@"|"] objectAtIndex:0] integerValue];
    recent5Record.lose = [[[tempStr componentsSeparatedByString:@"|"] objectAtIndex:1] integerValue];
    tempStr = [jsonObject valueForKey:@"vsT"];
    vsTerranRecord.win = [[[tempStr componentsSeparatedByString:@"|"] objectAtIndex:0] integerValue];
    vsTerranRecord.lose = [[[tempStr componentsSeparatedByString:@"|"] objectAtIndex:1] integerValue];
    tempStr = [jsonObject valueForKey:@"vsZ"];
    vsZergRecord.win = [[[tempStr componentsSeparatedByString:@"|"] objectAtIndex:0] integerValue];
    vsZergRecord.lose = [[[tempStr componentsSeparatedByString:@"|"] objectAtIndex:1] integerValue];
    tempStr = [jsonObject valueForKey:@"vsP"];
    vsProtossRecord.win = [[[tempStr componentsSeparatedByString:@"|"] objectAtIndex:0] integerValue];
    vsProtossRecord.lose = [[[tempStr componentsSeparatedByString:@"|"] objectAtIndex:1] integerValue];
}

- (BARecord)getOppositeRaceRecordByRaceName:(NSString *)racename {
    racename = [racename lowercaseString];
    if ([racename isEqual:@"terran"]) return vsTerranRecord;
    if ([racename isEqual:@"zerg"]) return vsZergRecord;
    return vsProtossRecord;
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
