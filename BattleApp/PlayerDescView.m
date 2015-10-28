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
        [self setupViews];
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

- (void)setupPlayer:(Player *)aPlayer {
    player = aPlayer;
    [thumbnail setImage:[player thumbnail]];
    [playIdLabel setText:[player playId]];
    [teamLabel setText:[player team]];
    [raceLabel setText:[player race]];
}

- (void)setupViews {
    thumbnail = [[UIImageView alloc] init];
    [thumbnail setUserInteractionEnabled:YES];
    [thumbnail setImage:[UIImage imageNamed:@"noprofile"]];
    [self addSubview:thumbnail];
    
    playIdLabel = [[UILabel alloc] init];
    [playIdLabel setTextColor:BAYellow];
    [playIdLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [playIdLabel setTextAlignment:NSTextAlignmentCenter];
    [playIdLabel setText:@"PlayId"];
    [self addSubview:playIdLabel];
    
    teamLabel = [[UILabel alloc] init];
    [teamLabel setTextColor:BAWhite];
    [teamLabel setTextAlignment:NSTextAlignmentCenter];
    [teamLabel setFont:[UIFont systemFontOfSize:13]];
    [teamLabel setText:@"PlayerTeam"];
    [self addSubview:teamLabel];
    
    raceLabel = [[UILabel alloc] init];
    [raceLabel setTextColor:BAWhite];
    [raceLabel setTextAlignment:NSTextAlignmentCenter];
    [raceLabel setFont:[UIFont systemFontOfSize:13]];
    [raceLabel setText:@"Terran"];
    [self addSubview:raceLabel];
    
    [thumbnail addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapThumbnail:)]];
}

- (void)tapThumbnail:(UITapGestureRecognizer *)recongnizer {
    if (delegate != nil) [delegate requestPlayer:self];
}

@end
