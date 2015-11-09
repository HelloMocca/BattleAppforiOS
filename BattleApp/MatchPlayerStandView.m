//
//  MatchPlayerStandView.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 21..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "MatchPlayerStandView.h"

@implementation MatchPlayerStandView

{
    PlayerDescView *player1View;
    PlayerDescView *player2View;
}

@synthesize player1View = player1View;
@synthesize player2View = player2View;
@synthesize delegate = delegate;

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
        [self setDelegate:aDelegate];
    }
    return self;
}

#pragma mark -Setter methods
- (void)setDelegate:(id<PlayerDescViewDelegate>)aDelegate {
    delegate = aDelegate;
    [player1View setDelegate:delegate];
    [player2View setDelegate:delegate];
}

#pragma mark -Getter methods
- (BOOL)isAllPlayerSelected {
    if ([player1View player] != nil && [player2View player] != nil) {
        return YES;
    }
    return NO;
}

#pragma mark -Setup view methods
- (void)setupViews {
    [self setFrame:CGRectMake(0, 70, [UIScreen mainScreen].bounds.size.width, 300)];
    CGFloat playerViewMargin = 10;
    CGFloat playerViewWidth = ([UIScreen mainScreen].bounds.size.width / 2) - (2 * playerViewMargin);
    CGFloat playerViewHeight = self.frame.size.height - 20;
    
    player1View = [[PlayerDescView alloc] init];
    [player1View setFrame:CGRectMake(playerViewMargin, 0, playerViewWidth, playerViewHeight)];
    [self addSubview:player1View];
    
    player2View = [[PlayerDescView alloc] init];
    [player2View setFrame:CGRectMake(playerViewWidth + (3 * playerViewMargin), 0, playerViewWidth, playerViewHeight)];
    [self addSubview:player2View];
}

@end
