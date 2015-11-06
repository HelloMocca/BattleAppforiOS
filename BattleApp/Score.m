//
//  Score.m
//  BattleApp
//
//  Created by mocca on 2015. 11. 6..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "Score.h"

@implementation Score

{
    int win;
    int lose;
    float rate;
    float percentage;
}

@synthesize win = win;
@synthesize lose = lose;
@synthesize rate = rate;
@synthesize percentage = percentage;

- (instancetype)initWithWin:(int)winCount lose:(int)loseCount {
    self = [super init];
    if (self) {
        win = winCount;
        lose = loseCount;
        rate = (win + lose == 0) ? 0 : win / (float)(win + lose);
        percentage = rate * 100;
    }
    return self;
}

+ (Score *)scoreWithScoreString:(NSString *)string {
    NSArray *components = [string componentsSeparatedByString:@"|"];
    return [[Score alloc] initWithWin: [[components objectAtIndex:0] intValue] lose:[[components objectAtIndex:1] intValue]];
}

@end
