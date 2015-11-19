//
//  Schedule.m
//  BattleApp
//
//  Created by mocca on 2015. 11. 9..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "Schedule.h"

@implementation Schedule
{
    NSString *title;
    NSString *leagueName;
    NSString *time;
}

@synthesize title = title;
@synthesize leagueName = leagueName;
@synthesize time = time;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        title = [dictionary valueForKey:@"title"];
        leagueName = [dictionary objectForKey:@"leagueName"];
        time = [dictionary valueForKey:@"time"];
        //NSLog(@"%@",time);
    }
    return self;
}

@end
