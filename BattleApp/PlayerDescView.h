//
//  PlayerDescView.h
//  BattleApp
//
//  Created by mocca on 2015. 10. 21..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import "BAColor.h"

@protocol PlayerDescViewDelegate <NSObject>

@required
- (void)requestPlayer:(id)viewInstance;

@end

@interface PlayerDescView : UIView

@property (nonatomic, readonly) UIImageView *thumbnail;
@property (nonatomic, readonly) UILabel     *playIdLabel;
@property (nonatomic, readonly) UILabel     *teamLabel;
@property (nonatomic, readonly) UILabel     *raceLabel;
@property (nonatomic, readonly) Player      *player;
@property (nonatomic, weak) id<PlayerDescViewDelegate> delegate;

- (instancetype)initWithDelegate:(id<PlayerDescViewDelegate>)aDelegate;

- (void)setupPlayer:(Player *)aPlayer;

@end
