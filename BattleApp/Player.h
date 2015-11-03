//
//  Player.h
//  BattleApp
//
//  Created by mocca on 2015. 10. 13..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import <UIKit/UIKit.h>

struct BARecord {
    NSUInteger win;
    NSUInteger lose;
};
typedef struct BARecord BARecord;

@interface Player : NSObject

@property (nonatomic, readonly)  NSInteger playerId;
@property (nonatomic, readonly)  NSString *playId;
@property (nonatomic, readonly)  NSString *name;
@property (nonatomic, readonly)  NSString *race;
@property (nonatomic, readonly)  NSString *team;
@property (nonatomic, readonly)  NSURL    *thumbnailUrl;
@property (nonatomic, readonly)  UIImage  *thumbnail;
@property (nonatomic, readwrite) BARecord totalRecord;
@property (nonatomic, readwrite) BARecord recent5Record;
@property (nonatomic, readwrite) BARecord vsTerranRecord;
@property (nonatomic, readwrite) BARecord vsZergRecord;
@property (nonatomic, readwrite) BARecord vsProtossRecord;
@property (nonatomic, readonly)  NSDictionary *games;

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

- (void)requestRecordsData;

- (BARecord)getOppositeRaceRecordByRaceName:(NSString *)racename;

@end
