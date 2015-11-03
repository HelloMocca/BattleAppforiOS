//
//  Game.h
//  BattleApp
//
//  Created by mocca on 2015. 11. 3..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject

@property (nonatomic, readonly) NSString *player1;
@property (nonatomic, readonly) NSString *player2;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *round;
@property (nonatomic, readonly) NSString *set;
@property (nonatomic, readonly) NSString *winner;
@property (nonatomic, readonly) NSString *time;
@property (nonatomic, readonly) NSString *link;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end
