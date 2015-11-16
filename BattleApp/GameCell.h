//
//  GameCell.h
//  BattleApp
//
//  Created by mocca on 2015. 11. 9..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "UIColorExtension.h"

@interface GameCell : UITableViewCell

- (void)setupWithGame:(Game *)game;

@end
