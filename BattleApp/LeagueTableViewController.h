//
//  LeagueTableViewController.h
//  BattleApp
//
//  Created by mocca on 2015. 10. 14..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "League.h"
#import "LeagueInfoViewController.h"

@interface LeagueTableViewController : UITableViewController

- (instancetype) initWithLeagues:(NSMutableArray *)aLeagues;

- (void)setLeagues:(NSArray *)leagueArray;

@end
