
//
//  NotificationManager.m
//  BattleApp
//
//  Created by mocca on 2015. 11. 9..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "NotificationManager.h"

@implementation NotificationManager

+ (NotificationManager *)getNotificationManager {
    static NotificationManager *notificationManager = nil;
    @synchronized(self) {
        if (notificationManager == nil) {
            NSLog(@"NotificationManager created.");
            notificationManager = [[NotificationManager alloc] init];
            [self setupLocalNotification];
        }
    }
    return notificationManager;
}

+ (void)setupLocalNotification {
    UIUserNotificationType types = UIUserNotificationTypeBadge |
    UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
}

- (void)addNotificationWithDate:(NSDate *)date body:(NSString *)bodyString {
    @synchronized(self) {
        NSMutableArray *notifications = [[NSMutableArray alloc] initWithArray:[self scheduledNotifications]];
        UILocalNotification *noti = [[UILocalNotification alloc] init];
        [noti setFireDate:date];
        [noti setTimeZone:[NSTimeZone systemTimeZone]];
        [noti setAlertBody:bodyString];
        [noti setAlertAction:@"APP"];
        [noti setSoundName:UILocalNotificationDefaultSoundName];
        [noti setUserInfo:[NSDictionary dictionaryWithObject:@"User Info" forKey:@"Key"]];
        [notifications addObject:noti]; printf("ADD NOTY! \n");
        [[UIApplication sharedApplication] setScheduledLocalNotifications:notifications];
    }
    
    [self showNotifications];
}

- (void)removeNotificationWithBody:(NSString *)bodyString {
    @synchronized(self) {
        NSMutableArray *notifications = [[NSMutableArray alloc] initWithArray:[self scheduledNotifications]];
        UILocalNotification *noti;
        for (int i = 0, count = [notifications count]; i < count; i++) {
            noti = [notifications objectAtIndex:i];
            if ([[noti alertBody] isEqualToString:bodyString]) {
                [notifications removeObjectAtIndex:i]; printf("REMOVE NOTY! \n");
                break;
            }
        }
        [[UIApplication sharedApplication] setScheduledLocalNotifications:notifications];
    }
    [self showNotifications];
}

- (void)showNotifications {
    @synchronized(self) {
        NSMutableArray *notifications = [[NSMutableArray alloc] initWithArray:[self scheduledNotifications]];
        if ([notifications count] == 0){
            printf("NOTY EMPTY \n");
            return;
        }
        UILocalNotification *noti;
        for (int i = 0, count = [notifications count]; i < count; i++) {
            noti = [notifications objectAtIndex:i];
            printf("NOTY #%d: %s \n", i, [[noti alertBody] UTF8String]);
        }
    }
}

- (NSArray *)scheduledNotifications {
    return [[UIApplication sharedApplication] scheduledLocalNotifications];
}

@end
