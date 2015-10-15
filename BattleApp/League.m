

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
    NSString *title;
}

@synthesize title = title;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        title = [dictionary valueForKey:@"name"];
    }
    return self;
}

@end
