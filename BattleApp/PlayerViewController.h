//
//  PlayerTableViewController.h
//  BattleApp
//
//  Created by mocca on 2015. 10. 13..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import "PlayerInfoViewController.h"
#import "PlayerCell.h"
#import "BANavigationController.h"
#import "BAPlayerSearchViewController.h"

@interface PlayerViewController : BAPlayerSearchViewController <PlayerTableSelectDelegate>

@end
