//
//  ScheduleCell.h
//  BattleApp
//
//  Created by mocca on 2015. 11. 9..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Schedule.h"
#import "UIColorExtension.h"
#import "NotificationManager.h"

@interface ScheduleCell : UITableViewCell

- (void)setupWithSchedule:(Schedule *)aSchedule;

@end
