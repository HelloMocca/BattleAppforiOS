//
//  MatchViewController.h
//  BattleApp
//
//  Created by mocca on 2015. 10. 12..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "BAViewController.h"
#import "MatchPlayerStandView.h"
#import "BAPlayerSearchViewController.h"
#import "MatchPredictViewController.h"
#import "PlayerDescView.h"

@interface MatchViewController : BAViewController <PlayerDescViewDelegate, PlayerTableSelectDelegate>

@property (nonatomic, weak) PlayerDescView *requestedView;

@end
