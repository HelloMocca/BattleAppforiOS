//
//  GameTableViewCell.m
//  BattleApp
//
//  Created by mocca on 2015. 11. 9..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "GameTableViewCell.h"

@implementation GameTableViewCell

{
    UILabel *dateView;
    UILabel *titleView;
    UILabel *locationView;
    UILabel *leagueNameView;
    
    CGSize  screenSize;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    screenSize = [[UIScreen mainScreen] bounds].size;
    [self setupLeagueNameView];
    [self setupTitleView];
    [self setupDateView];
}

- (void)setupLeagueNameView {
    float cellMargin = 15;
    float cellWidth = screenSize.width - (2 * cellMargin);
    leagueNameView = [[UILabel alloc] init];
    [leagueNameView setFrame:CGRectMake(cellMargin, 5, cellWidth, 15)];
    [leagueNameView setFont:[UIFont systemFontOfSize:13]];
    [self addSubview:leagueNameView];
}

- (void)setupTitleView {
    float cellMargin = 15;
    float cellWidth = screenSize.width - (2 * cellMargin);
    titleView = [[UILabel alloc] init];
    [titleView setFrame:CGRectMake(cellMargin, leagueNameView.frame.origin.y + leagueNameView.frame.size.height, cellWidth, 40)];
    [titleView setFont:[UIFont boldSystemFontOfSize:16]];
    [titleView setLineBreakMode:NSLineBreakByWordWrapping];
    [titleView setNumberOfLines:2];
    [self addSubview:titleView];
}

- (void)setupDateView {
    float cellMargin = 15;
    float cellWidth = screenSize.width - (2 * cellMargin);
    dateView = [[UILabel alloc] init];
    [dateView setFrame:CGRectMake(cellMargin, titleView.frame.origin.y+titleView.frame.size.height, cellWidth, 15)];
    [dateView setFont:[UIFont systemFontOfSize:13]];
    [self addSubview:dateView];
}

- (void)setupWithGame:(Game *)game {
    NSString *matchName = [NSString stringWithFormat:@"Round %@ - %@SET %@ vs %@", [game round], [game set], [game player1], [game player2]];
    [dateView setText:[game time]];
    [titleView setText:matchName];
    [leagueNameView setText:[game title]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
