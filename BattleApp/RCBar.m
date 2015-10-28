
//
//  RCBar.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 28..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "RCBar.h"

@implementation RCBar

{
    CGSize currSize;
    CGSize destSize;
    CGRect rect;
    CGColorRef color;
    BOOL updateEnd;
}

@synthesize currSize = currSize;
@synthesize destSize = destSize;
@synthesize rect = rect;
@synthesize color = color;
@synthesize updateEnd = updateEnd;

- (instancetype)initWithCurrSize:(CGSize)currsize DestSize:(CGSize)destsize Rect:(CGRect)cgRect Color:(CGColorRef)cgColor {
    self = [self init];
    if (self) {
        currSize = currsize;
        destSize = destsize;
        rect = cgRect;
        color = cgColor;
        updateEnd = NO;
    }
    return self;
}

- (void)updateValue {
    if (updateEnd) return;
    currSize.width += (destSize.width-currSize.width)*0.02f;
    if ((destSize.width-currSize.width)*(destSize.width-currSize.width) < 0.0001f) {
        currSize.width = destSize.width;
    }
    rect.size.width = currSize.width;
    [self updateEndCheck];
}

- (CGFloat)rectOriginX {
    return rect.origin.x;
}

- (void)setRectOriginX:(CGFloat)x {
    rect.origin.x = x;
}

- (void)updateEndCheck {
    if (currSize.width == destSize.width && currSize.height == destSize.height) {
        updateEnd = YES;
    }
}

@end
