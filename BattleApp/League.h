//
//  League.h
//  BattleApp
//
//  Created by mocca on 2015. 10. 14..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface League : NSObject

@property (nonatomic, readonly) NSUInteger leagueId;
@property (nonatomic, readonly) NSString   *title;
@property (nonatomic, readonly) NSString   *sponsor;
@property (nonatomic, readonly) NSString   *openDatetime;
@property (nonatomic, readonly) NSString   *openDate;
@property (nonatomic, readonly) NSString   *endDatetime;
@property (nonatomic, readonly) NSString   *endDate;
@property (nonatomic, readonly) NSString   *location;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
