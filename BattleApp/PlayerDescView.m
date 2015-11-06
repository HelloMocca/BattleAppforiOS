//
//  PlayerDescView.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 21..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "PlayerDescView.h"

@implementation PlayerDescView

{
    UIImageView *thumbnail;
    UILabel     *playIdLabel;
    UILabel     *teamLabel;
    UILabel     *raceLabel;
    Player      *player;
}

@synthesize thumbnail = thumbnail;
@synthesize playIdLabel = playIdLabel;
@synthesize teamLabel = teamLabel;
@synthesize raceLabel = raceLabel;
@synthesize delegate = delegate;
@synthesize player = player;


#pragma mark -Initialize methods
- (instancetype)init {
    self = [super init];
    if (self) {
        [self allocInitSubviews];
        [self setupSubviews];
        [self addSubviews];
    }
    return self;
}

- (instancetype)initWithDelegate:(id<PlayerDescViewDelegate>)aDelegate {
    self = [self init];
    if (self) {
        delegate = aDelegate;
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    CGFloat thumbnailWidth = self.frame.size.width-50;
    CGFloat thumbnailHeight = thumbnailWidth*1.14;
    [thumbnail setFrame:CGRectMake(25, 25, thumbnailWidth, thumbnailHeight)];
    [playIdLabel setFrame:CGRectMake(0, thumbnailHeight+5+25, self.frame.size.width, 25)];
    [teamLabel setFrame:CGRectMake(0, thumbnailHeight+5+25+25, self.frame.size.width, 25)];
    [raceLabel setFrame:CGRectMake(0, thumbnailHeight+5+25+25+15, self.frame.size.width, 25)];
}

#pragma mark -Setup Views
- (void)allocInitSubviews {
    thumbnail = [[UIImageView alloc] init];
    playIdLabel = [[UILabel alloc] init];
    teamLabel = [[UILabel alloc] init];
    raceLabel = [[UILabel alloc] init];
}

- (void)setupSubviews {
    [thumbnail setUserInteractionEnabled:YES];
    [thumbnail setImage:[UIImage imageNamed:@"noprofile"]];
    [thumbnail addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapThumbnail:)]];

    [playIdLabel setTextColor:[UIColor baYellowColor]];
    [playIdLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [playIdLabel setTextAlignment:NSTextAlignmentCenter];
    [playIdLabel setText:@"SelectPlayer"];

    [teamLabel setTextColor:[UIColor baWhiteColor]];
    [teamLabel setTextAlignment:NSTextAlignmentCenter];
    [teamLabel setFont:[UIFont systemFontOfSize:13]];

    [raceLabel setTextColor:[UIColor baWhiteColor]];
    [raceLabel setTextAlignment:NSTextAlignmentCenter];
    [raceLabel setFont:[UIFont systemFontOfSize:13]];
}

- (void)addSubviews {
    [self addSubview:thumbnail];
    [self addSubview:playIdLabel];
    [self addSubview:teamLabel];
    [self addSubview:raceLabel];
}

- (void)setupPlayer:(Player *)aPlayer {
    player = aPlayer;
    [thumbnail setImage:[player thumbnail]];
    [playIdLabel setText:[player playId]];
    [teamLabel setText:[player team]];
    [raceLabel setText:[player race]];
}

#pragma mark -Event handle methods
- (void)tapThumbnail:(UITapGestureRecognizer *)recongnizer {
    if (delegate != nil) [delegate requestPlayer:self];
}

@end
