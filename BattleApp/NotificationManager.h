//
//  NotificationManager.h
//  BattleApp
//
//  Created by mocca on 2015. 11. 9..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationManager : NSObject

+ (NotificationManager *)getNotificationManager;

- (void)addNotificationWithDate:(NSDate *)date body:(NSString *)bodyString;

- (void)removeNotificationWithBody:(NSString *)bodyString;

- (void)showNotifications;

- (NSArray *)scheduledNotifications;

@end
