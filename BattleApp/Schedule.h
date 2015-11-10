//
//  Schedule.h
//  BattleApp
//
//  Created by mocca on 2015. 11. 9..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Schedule : NSObject

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *leagueName;
@property (nonatomic, readonly) NSString *time;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end
