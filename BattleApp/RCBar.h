//
//  RCBar.h
//  BattleApp
//
//  Created by mocca on 2015. 10. 28..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCBar : NSObject

@property (nonatomic, readwrite) CGSize currSize;
@property (nonatomic, readwrite) CGSize destSize;
@property (nonatomic, readwrite) CGRect rect;
@property (nonatomic, readwrite) CGColorRef color;
@property (nonatomic, getter=isUpdateEnd) BOOL updateEnd;

- (instancetype)initWithCurrSize:(CGSize)currsize DestSize:(CGSize)destsize Rect:(CGRect)cgRect Color:(CGColorRef)cgColor;

- (void)updateValue;

- (CGFloat)rectOriginX;

- (void)setRectOriginX:(CGFloat)x;

@end
