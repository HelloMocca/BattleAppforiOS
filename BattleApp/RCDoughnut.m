//
//  RCDoughnut.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 23..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "RCDoughnut.h"

@implementation RCDoughnut

{
    float   ratio;
    float   currRatio;
    CGPoint center;
    CGFloat radius;
    CGFloat padding;
    CGFloat doughnutWidth;
    UILabel *titleLabel;
    UILabel *numericLabel;
    
    BOOL numericLabelVisible;
}

@synthesize titleLabel = titleLabel;
@synthesize numericLabelVisible = numericLabelVisible;


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        titleLabel = [[UILabel alloc] init];
        numericLabel = [[UILabel alloc] init];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setFrame:frame];
        [self addSubview:numericLabel];
        [self addSubview:titleLabel];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    //background arc
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context, center.x, center.y);
    CGContextAddArc(context, center.x, center.y, radius, -(M_PI/2), -(M_PI/2)+(M_PI*2), NO);
    CGContextClosePath(context);
    
    CGContextMoveToPoint(context, center.x, center.y);
    CGContextAddArc(context, center.x, center.y, radius-doughnutWidth, -(M_PI/2), -(M_PI/2)+(M_PI*2), NO);
    CGContextClosePath(context);
    
    CGContextSetRGBFillColor(context, 0.059, 0.184, 0.216, 1);
    CGContextEOFillPath(context);
    
    //outer arc
    CGContextMoveToPoint(context, center.x, center.y);
    CGContextAddArc(context, center.x, center.y, radius, -(M_PI/2), -(M_PI/2)+(M_PI*2) * currRatio, NO);
    CGContextClosePath(context);
    
    CGContextMoveToPoint(context, center.x, center.y);
    CGContextAddArc(context, center.x, center.y, radius-doughnutWidth, -(M_PI/2), -(M_PI/2)+(M_PI*2) * currRatio, NO);
    CGContextClosePath(context);
    CGContextSetRGBFillColor(context, 0.141f, 0.431f, 0.608f, 1);
    CGContextEOFillPath(context);
    
    if (currRatio != ratio) {
        [NSTimer scheduledTimerWithTimeInterval:.025 target:self selector:@selector(increaseValue) userInfo:nil repeats:NO];
    }
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    center.x = frame.size.width/2;
    center.y = frame.size.height/2;
    radius = (frame.size.width > frame.size.height) ? frame.size.height/2 : frame.size.width/2;
    doughnutWidth = radius*(1.0f/4.0f);
    [self setupTitleLabel];
    [self setupNumericLabel];
}

- (void)setupTitleLabel {
    [titleLabel setFrame:CGRectMake(0, (self.frame.size.height/2)-10, self.frame.size.width, 20)];
    [titleLabel setTextColor:[UIColor colorWithRed:0.769f green:0.769f blue:0.780f alpha:1.00f]];
    [titleLabel setFont:[UIFont systemFontOfSize:15]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
}

- (void)setupNumericLabel {
    if (!numericLabelVisible) return;
    [numericLabel setFrame:CGRectMake(0, (self.frame.size.height/2)+5, self.frame.size.width, 20)];
    [numericLabel setTextColor:[UIColor colorWithRed:0.769f green:0.769f blue:0.780f alpha:1.00f]];
    [numericLabel setFont:[UIFont systemFontOfSize:15]];
    [numericLabel setTextAlignment:NSTextAlignmentCenter];
}

- (void)setRatio:(float)ratioValue {
    ratio = ratioValue;
    if (isnan(ratio)) ratio = 0;
    [numericLabel setText:[NSString stringWithFormat:@"%.f%%", ratio*100]];
}

- (void)setTitle:(NSString *)title {
    [[self titleLabel] setText:title];
}

- (void)setTitleColor:(UIColor*)color {
    [[self titleLabel] setTextColor:color];
}

- (void)setTitleFont:(UIFont *)font {
    [[self titleLabel] setFont:font];
}

- (void)increaseValue {
    currRatio += (ratio-currRatio)*0.02f;
    if (ratio-currRatio < 0.0001f) {
        currRatio = ratio;
    }
    
    [self setNeedsDisplay];
}

@end
