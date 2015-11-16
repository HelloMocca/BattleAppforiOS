//
//  LeagueInfoViewController.h
//  BattleApp
//
//  Created by mocca on 2015. 10. 15..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "BAViewController.h"
#import "BAGameTableViewController.h"
#import "BADoubleLabelView.h"
#import "UIColorExtension.h"
#import "BAHttpTask.h"
#import "League.h"
#import "Game.h"

@interface LeagueInfoViewController : BAViewController

- (instancetype)initWithLeague:(League *)aLeague;

@end
