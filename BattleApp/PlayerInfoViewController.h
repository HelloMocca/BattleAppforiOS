//
//  PlayerInfoViewController.h
//  BattleApp
//
//  Created by mocca on 2015. 10. 15..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "BAViewController.h"
#import "BAGameTableViewController.h"
#import "Player.h"
#import "UIColorExtension.h"
#import "Racoon.h"

@interface PlayerInfoViewController : BAViewController

- (instancetype)initWithPlayer:(Player *)aPlayer;

@end
