//
//  MatchPredictViewController.h
//  BattleApp
//
//  Created by mocca on 2015. 10. 22..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Player.h"
#import "MatchPlayerStandView.h"
#import "MatchCalculator.h"
#import "Racoon.h"

@interface MatchPredictViewController : UIViewController <PlayerDescViewDelegate>

- (instancetype)initWithPlayer1:(Player *)player1 player2:(Player *)player2;

@end
