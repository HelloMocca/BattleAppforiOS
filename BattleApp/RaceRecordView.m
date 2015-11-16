//
//  RaceRecordView.m
//  BattleApp
//
//  Created by mocca on 2015. 11. 13..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "RaceRecordView.h"

@implementation RaceRecordView

{
    Player *player;
}

- (void)setupViewsWithPlayer:(Player *)aPlayer {
    player = aPlayer;
    [self setupViewTitle];
    [self setupDoughnutCharts];
}

- (void)setupViewTitle {
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.bounds.size.width-10, 15)];
    [title setText:@"Opposite Race Records"];
    [title setTextColor:[UIColor baDarkGrayColor]];
    [title setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [self addSubview:title];
}

- (void)setupDoughnutCharts {
    CGFloat viewWidth = self.bounds.size.width;
    CGFloat donutRadius = (viewWidth / 3) - 30;
    
    CGRect terranDonutFrame = CGRectMake(15, 40, donutRadius, donutRadius);
    [self setupDoughnutChartWithFrame:terranDonutFrame score:player.record.vsTerran title:@"vs.Terran"];
    
    CGRect zergDonutFrame = CGRectMake((15 * 2) + ((viewWidth / 3) - 15), 40, donutRadius, donutRadius);
    [self setupDoughnutChartWithFrame:zergDonutFrame score:player.record.vsZerg title:@"vs.Zerg"];
    
    CGRect protossDonutFrame = CGRectMake((15 * 3) + (((viewWidth / 3) - 15) * 2), 40, donutRadius, donutRadius);
    [self setupDoughnutChartWithFrame:protossDonutFrame score:player.record.vsProtoss title:@"vs.Protoss"];
}

- (void)setupDoughnutChartWithFrame:(CGRect)frame score:(Score *)score title:(NSString *)title {
    RCDoughnut *donut = [[RCDoughnut alloc] init];
    [donut setFrame:frame];
    [donut setRatio:score.rate];
    [donut setTitle:[NSString stringWithFormat:@"%.f %%", score.percentage]];
    [donut setTitleFont:[UIFont systemFontOfSize:20]];
    [donut setDoughnutWidth:2];
    [self addSubview:donut];
    UILabel *donutLabel = [[UILabel alloc] init];
    [donutLabel setFrame:CGRectMake(frame.origin.x, frame.origin.y+frame.size.height+5, frame.size.width, 15)];
    [donutLabel setText:title];
    [donutLabel setTextAlignment:NSTextAlignmentCenter];
    [donutLabel setTextColor:[UIColor silverColor]];
    [donutLabel setFont:[UIFont systemFontOfSize:13]];
    [self addSubview:donutLabel];
}

@end
