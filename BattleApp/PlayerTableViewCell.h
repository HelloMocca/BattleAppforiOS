//
//  PlayerTableViewCell.h
//  BattleApp
//
//  Created by mocca on 2015. 10. 16..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"

@interface PlayerTableViewCell : UITableViewCell

@property (nonatomic, readwrite) UIColor *oddColor;
@property (nonatomic, readwrite) UIColor *evenColor;

-(void)setupWithPlayer:(Player *)player;

@end
