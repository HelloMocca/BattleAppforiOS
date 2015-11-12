//
//  BAGameTableViewController.h
//  BattleApp
//
//  Created by mocca on 2015. 11. 3..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "BAWebViewController.h"
#import "GameCell.h"

@interface BAGameTableViewController : UITableViewController

- (instancetype)initWithGames:(NSArray *)array;

@end
