//
//  GameCell.m
//  BattleApp
//
//  Created by mocca on 2015. 11. 9..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "GameCell.h"

@implementation GameCell

{
    UILabel *dateView;
    UILabel *providerView;
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
    [self setupProviderView];
}

- (void)setupLeagueNameView {
    float cellMargin = 15;
    float cellWidth = screenSize.width - (2 * cellMargin);
    leagueNameView = [[UILabel alloc] init];
    [leagueNameView setFrame:CGRectMake(cellMargin, 5, cellWidth, 15)];
    [leagueNameView setFont:[UIFont systemFontOfSize:13]];
    [leagueNameView setTextColor:[UIColor baDarkGrayColor]];
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
    float cellWidth = (screenSize.width/2) - cellMargin;
    dateView = [[UILabel alloc] init];
    [dateView setFrame:CGRectMake(cellMargin, titleView.frame.origin.y+titleView.frame.size.height, cellWidth, 15)];
    [dateView setFont:[UIFont systemFontOfSize:13]];
    [dateView setTextColor:[UIColor concreteColor]];
    [self addSubview:dateView];
}

- (void)setupProviderView {
    float cellMargin = 15;
    float cellWidth = (screenSize.width/2) - cellMargin;
    providerView = [[UILabel alloc] init];
    [providerView setFrame:CGRectMake(self.frame.size.width-cellWidth-15, titleView.frame.origin.y+titleView.frame.size.height, cellWidth, 15)];
    [providerView setTextAlignment:NSTextAlignmentRight];
    [providerView setFont:[UIFont systemFontOfSize:13]];
    [providerView setTextColor:[UIColor concreteColor]];
    [self addSubview:providerView];
}

- (void)setupWithGame:(Game *)game {
    NSString *matchName = [NSString stringWithFormat:@"Round %@ - %@SET %@ vs %@", [game round], [game set], [game player1], [game player2]];
    [dateView setText:[game date]];
    [titleView setText:matchName];
    [leagueNameView setText:[game title]];
    [providerView setText:[game provider]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
