//
//  ScheduleCell.m
//  BattleApp
//
//  Created by mocca on 2015. 11. 9..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "ScheduleCell.h"

@implementation ScheduleCell
{
    UILabel     *dateView;
    UILabel     *titleView;
    UILabel     *leagueNameView;
    UIImageView *alramBtn;
    
    Schedule *schedule;
    BOOL     alramChecked;
    NSString *alramBody;
    CGSize   screenSize;
}

#pragma mark -Initialize methods

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}


#pragma mark -Setup view methods

- (void)setupViews {
    screenSize = [[UIScreen mainScreen] bounds].size;
    [self setupLeagueNameView];
    [self setupTitleView];
    [self setupDateView];
    [self setupAlramBtn];
    [self setupGestureEvent];
}

- (void)setupLeagueNameView {
    float cellMargin = 15;
    float cellWidth = screenSize.width - (2 * cellMargin);
    leagueNameView = [[UILabel alloc] init];
    [leagueNameView setFrame:CGRectMake(cellMargin, 5, cellWidth, 15)];
    [leagueNameView setFont:[UIFont systemFontOfSize:13]];
    [leagueNameView setTextColor:[UIColor cloudColor]];
    [self addSubview:leagueNameView];
}

- (void)setupTitleView {
    float leftMargin = 15;
    float rightMargin = 50;
    float cellWidth = screenSize.width - (leftMargin + rightMargin);
    titleView = [[UILabel alloc] init];
    [titleView setFrame:CGRectMake(leftMargin, leagueNameView.frame.origin.y + leagueNameView.frame.size.height, cellWidth, 40)];
    [titleView setFont:[UIFont boldSystemFontOfSize:16]];
    [titleView setLineBreakMode:NSLineBreakByWordWrapping];
    [titleView setNumberOfLines:2];
    [titleView setTextColor:[UIColor cloudColor]];
    [self addSubview:titleView];
}

- (void)setupDateView {
    float cellMargin = 15;
    float cellWidth = screenSize.width - (2 * cellMargin);
    dateView = [[UILabel alloc] init];
    [dateView setFrame:CGRectMake(cellMargin, titleView.frame.origin.y+titleView.frame.size.height, cellWidth, 15)];
    [dateView setFont:[UIFont systemFontOfSize:13]];
    [dateView setTextColor:[UIColor cloudColor]];
    [self addSubview:dateView];
}

- (void)setupAlramBtn {
    alramBtn = [[UIImageView alloc] init];
    [alramBtn setFrame:CGRectMake(screenSize.width-(40+5), titleView.frame.origin.y, 40, 40)];
    [self addSubview:alramBtn];
}

- (void)setupGestureEvent {
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(alramTap:)]];
}

- (void)setupWithSchedule:(Schedule *)aSchedule {
    alramChecked = NO;
    schedule = aSchedule;
    [dateView setText:[schedule time]];
    [titleView setText:[schedule title]];
    [leagueNameView setText:[schedule leagueName]];
    [self setupAlramBody];
    [self updateAlramBtn];
}

- (void)setupAlramBody {
    alramBody = [NSString stringWithFormat:@"%@ now began!", [schedule title]];
}

- (void)updateAlramBtn {
    NSArray *notifications = [[NotificationManager getNotificationManager] scheduledNotifications];
    UILocalNotification *noti;
    for (int i = 0, count = (int)[notifications count]; i < count; i++) {
        noti = [notifications objectAtIndex:i];
        if ([[noti alertBody] isEqualToString:alramBody]) {
            alramChecked = YES;
            break;
        }
    }
    
    UIImage *alramImage;
    if (alramChecked) {
        //add Noti
        alramImage = [UIImage imageNamed:@"AlramChecked"];
        alramImage = [alramImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [alramBtn setImage:alramImage];
        [alramBtn setTintColor:[UIColor dodgerBlueColor]];
    } else {
        //removeNoti
        alramImage = [UIImage imageNamed:@"Alram"];
        alramImage = [alramImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [alramBtn setImage:alramImage];
        [alramBtn setTintColor:[UIColor baDarkGrayColor]];
    }
}

#pragma mark - Event handle methods

- (void)alramTap:(UITapGestureRecognizer *)recognizer {
    alramChecked = !alramChecked;
    if (alramChecked) {
        [[NotificationManager getNotificationManager] addNotificationWithDate:[NSDate dateWithTimeIntervalSinceNow:10] body:alramBody];
    } else {
        [[NotificationManager getNotificationManager] removeNotificationWithBody:alramBody];
    }
    [self updateAlramBtn];
}

@end
