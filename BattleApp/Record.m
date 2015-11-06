//
//  Record.m
//  BattleApp
//
//  Created by mocca on 2015. 11. 6..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "Record.h"

@implementation Record

{
    Score *total;
    Score *recent5;
    Score *vsTerran;
    Score *vsZerg;
    Score *vsProtoss;
    NSArray *games;
}

@synthesize total = total;
@synthesize recent5 = recent5;
@synthesize vsTerran = vsTerran;
@synthesize vsZerg = vsZerg;
@synthesize vsProtoss = vsProtoss;
@synthesize games = games;

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        total = [[Score alloc] initWithWin:[[dict objectForKey:@"win"] intValue] lose:[[dict objectForKey:@"lose"] intValue]];
        recent5 = [Score scoreWithScoreString:[dict objectForKey:@"recent5Games"]];
        vsTerran = [Score scoreWithScoreString:[dict objectForKey:@"vsT"]];
        vsZerg = [Score scoreWithScoreString:[dict objectForKey:@"vsZ"]];
        vsProtoss = [Score scoreWithScoreString:[dict objectForKey:@"vsP"]];
        games = [dict objectForKey:@"games"];
    }
    return self;
}

@end
