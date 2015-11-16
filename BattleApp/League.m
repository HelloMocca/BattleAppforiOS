

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
    NSString   *openDatetime;
    NSString   *openDate;
    NSString   *endDatetime;
    NSString   *endDate;
    NSString   *location;
}

@synthesize leagueId = leagueId;
@synthesize title = title;
@synthesize sponsor = sponsor;
@synthesize openDatetime = openDatetime;
@synthesize openDate = openDate;
@synthesize endDatetime = endDatetime;
@synthesize endDate = endDate;
@synthesize location = location;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        leagueId = [[dictionary valueForKey:@"id"] integerValue];
        title = [dictionary valueForKey:@"name"];
        sponsor = [dictionary valueForKey:@"sponsor"];
        openDatetime = [dictionary valueForKey:@"openDate"];
        openDate = [openDatetime componentsSeparatedByString:@" "][0];
    }
    return self;
}



@end
