//
//  BAPlayerSearchViewController.h
//  BattleApp
//
//  Created by mocca on 2015. 10. 22..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import "BAHttpTask.h"
#import "BASearchDisplayController.h"
#import "PlayerTableViewCell.h"
#import "PlayerInfoViewController.h"

@protocol PlayerTableSelectDelegate <NSObject>

@optional
- (void)selectPlayer:(Player *)player;

@end

@interface BAPlayerSearchViewController : UITableViewController <UISearchDisplayDelegate>

@property (nonatomic, weak) id<PlayerTableSelectDelegate> delegate;

@end
