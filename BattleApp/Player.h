//
//  Player.h
//  BattleApp
//
//  Created by mocca on 2015. 10. 13..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BAHttpTask.h"
#import "Record.h"
#import "Score.h"

@interface Player : NSObject

@property (nonatomic, readonly)  NSInteger playerId;
@property (nonatomic, readonly)  NSString *playId;
@property (nonatomic, readonly)  NSString *name;
@property (nonatomic, readonly)  NSString *race;
@property (nonatomic, readonly)  NSString *team;
@property (nonatomic, readonly)  NSURL    *thumbnailUrl;
@property (nonatomic, readonly)  UIImage  *thumbnail;
@property (nonatomic, readonly)  Record   *record;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

- (void)setRecordWithDictionary:(NSDictionary *)dictionary;

- (void)requestRecordsData;

- (Score *)oppositeRaceScoreByRaceName:(NSString *)racename;

@end
