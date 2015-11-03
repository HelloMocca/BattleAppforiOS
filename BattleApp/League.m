

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
}

@synthesize leagueId = leagueId;
@synthesize title = title;
@synthesize sponsor = sponsor;
@synthesize openDate = openDate;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        leagueId = [[dictionary valueForKey:@"id"] integerValue];
        title = [dictionary valueForKey:@"name"];
        sponsor = [dictionary valueForKey:@"sponsor"];
        openDate = [[dictionary valueForKey:@"openDate"] componentsSeparatedByString:@" "][0];
    }
    return self;
}

@end
