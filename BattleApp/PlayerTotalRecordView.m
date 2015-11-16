//
//  PlayerTotalRecordView.m
//  BattleApp
//
//  Created by mocca on 2015. 11. 13..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "PlayerTotalRecordView.h"

@implementation PlayerTotalRecordView
{
    Player *player;
}

- (void)setupViewsWithPlayer:(Player *)aPlayer {
    player = aPlayer;
    [self setupTitleView];
    [self setupScoreLabelViews];
}

- (void)setupTitleView {
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.bounds.size.width-10, 15)];
    [title setText:@"Player Records"];
    [title setTextColor:[UIColor baDarkGrayColor]];
    [title setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [self addSubview:title];
}

- (void)setupScoreLabelViews {
    float marginLeft = (self.bounds.size.width - 270) / 2.0f;
    float marginTop = 40;
    float labelContainerMargin = 15;
    float labelContainerWidth = 80;
    float labelContainerHeight = 65;
    
    CGRect winScoreLabelFrame = CGRectMake(marginLeft, marginTop, labelContainerWidth, labelContainerHeight);
    [self setupLabelWithFrame:winScoreLabelFrame scoreValue:player.record.total.win title:@"Wins"];
    
    CGRect loseScoreLabelFrame = CGRectMake(marginLeft+labelContainerMargin+labelContainerWidth, marginTop, labelContainerWidth, labelContainerHeight);
    [self setupLabelWithFrame:loseScoreLabelFrame scoreValue:player.record.total.lose title:@"Loses"];
    
    [self setupDonutView];
}

- (void)setupLabelWithFrame:(CGRect)frame scoreValue:(int)value title:(NSString *)title {
    UIView *scoreLabelContainer = [[UIView alloc] initWithFrame:frame];
    
    UILabel *scoreValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, scoreLabelContainer.frame.size.width, 35)];
    [scoreValueLabel setText:[NSString stringWithFormat:@"%d", value]];
    [scoreValueLabel setFont:[UIFont systemFontOfSize:40]];
    [scoreValueLabel setTextAlignment:NSTextAlignmentCenter];
    [scoreValueLabel setTextColor:[UIColor cloudColor]];
    [scoreLabelContainer addSubview:scoreValueLabel];
    
    UILabel *scoreTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, scoreLabelContainer.frame.size.height-15, scoreLabelContainer.frame.size.width, 15)];
    [scoreTitleLabel setText:title];
    [scoreTitleLabel setFont:[UIFont systemFontOfSize:15]];
    [scoreTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [scoreTitleLabel setTextColor:[UIColor silverColor]];
    [scoreLabelContainer addSubview:scoreTitleLabel];
    
    [self addSubview:scoreLabelContainer];
}

- (void)setupDonutView {
    float marginLeft = (self.bounds.size.width - 270) / 2.0f;
    float marginTop = 40;
    float labelContainerHeight = 65;
    
    RCDoughnut *donut = [[RCDoughnut alloc] init];
    [donut setFrame:CGRectMake(marginLeft+205, marginTop, labelContainerHeight, labelContainerHeight)];
    [donut setRatio:  player.record.total.rate];
    [donut setTitle:[NSString stringWithFormat:@"%.f%%", player.record.total.percentage]];
    [donut setTitleFont:[UIFont systemFontOfSize:25]];
    [donut setDoughnutWidth:2];
    [donut setNumericLabelVisible:false];
    [self addSubview:donut];
}

@end
