

//
//  League.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 14..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "League.h"

@implementation League

{
    NSUInteger leagueId;
    NSString   *title;
    NSString   *sponsor;
    NSString   *openDate;
    NSString   *endDate;
    NSString   *winner;
    NSString   *organizer;
    NSString   *location;
}

@synthesize leagueId = leagueId;
@synthesize title = title;
@synthesize sponsor = sponsor;
@synthesize openDate = openDate;
@synthesize endDate = endDate;
@synthesize winner = winner;
@synthesize organizer = organizer;
@synthesize location = location;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        leagueId = [[dictionary valueForKey:@"id"] integerValue];
        title = [dictionary valueForKey:@"name"];
        sponsor = [dictionary valueForKey:@"sponsor"];
        openDate = [[dictionary valueForKey:@"openDate"] componentsSeparatedByString:@" "][0];
        endDate = [[dictionary valueForKey:@"endDate"] componentsSeparatedByString:@" "][0];
        winner = [dictionary valueForKey:@"winner"];
        location = [dictionary valueForKey:@"location"];
    }
    return self;
}

- (NSString *)endDate {
    return ([endDate isEqualToString:@""]) ? @"ON GOING" : endDate;
}

- (NSString *)winner {
    return ([winner isEqualToString:@""]) ? @"TBD" : winner;
}

@end
