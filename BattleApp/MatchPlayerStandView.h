//
//  MatchPlayerStandView.h
//  BattleApp
//
//  Created by mocca on 2015. 10. 21..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerDescView.h"

@interface MatchPlayerStandView : UIView

@property (nonatomic, readonly) PlayerDescView *player1View;
@property (nonatomic, readonly) PlayerDescView *player2View;
@property (nonatomic, weak) id<PlayerDescViewDelegate> delegate;

- (instancetype)initWithDelegate:(id<PlayerDescViewDelegate>)aDelegate;

- (BOOL)isAllPlayerSelected;

- (BOOL)isSamePlayerSelected;

@end

