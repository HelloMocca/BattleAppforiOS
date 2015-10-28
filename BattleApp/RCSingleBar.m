//
//  RCSingleBar.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 23..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "RCSingleBar.h"

@implementation RCSingleBar

{
    double mValue;
    double destValue;
    double currValue;
    BOOL endAnimation;
}


#pragma mark -Initialize methods

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setBackgroundColor:[UIColor colorWithRed:0.059f green:0.184f blue:0.216f alpha:1.00f]];
}

- (void)setData:(double)data {
    mValue = data;
    destValue = data;
    currValue = 0;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor colorWithRed:0.141f green:0.431f blue:0.608f alpha:1.00f]CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, self.frame.size.width*currValue, self.frame.size.height));
    if (currValue != destValue) {
        [NSTimer scheduledTimerWithTimeInterval:.025 target:self selector:@selector(increaseValue) userInfo:nil repeats:NO];
    }
}

- (void)increaseValue {
    currValue += (destValue-currValue)*0.02f;
    if (destValue-currValue < 0.0001f) {
        currValue = destValue;
    }
    
    [self setNeedsDisplay];
}

@end
