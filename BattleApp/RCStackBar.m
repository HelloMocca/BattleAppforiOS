//
//  RCStackBar.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 23..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "RCStackBar.h"

@implementation RCStackBar

{
    BOOL startAnimation;
    BOOL endAnimation;
    NSTimer *animationTimer;
    
    NSUInteger numOfBar;
    NSArray *values;
    NSMutableArray * barRects;
    NSArray * barColors;
}

#pragma mark -Initialize methods

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self setBackgroundColor:[UIColor colorWithRed:0.059f green:0.184f blue:0.216f alpha:1.00f]];
}

- (void)setData:(NSArray *)dataArray {
    startAnimation = NO;
    values = [NSArray arrayWithArray:dataArray];
    numOfBar = [values count];
    [self setBarColors:[NSArray arrayWithObjects:
                        [UIColor colorWithRed:0.063f green:0.227f blue:0.341f alpha:1.00f],
                        [UIColor colorWithRed:0.098f green:0.376f blue:0.678f alpha:1.00f],
                        [UIColor colorWithRed:0.141f green:0.592f blue:0.847f alpha:1.00f],
                        [UIColor colorWithRed:0.224f green:0.780f blue:0.933f alpha:1.00f],
                        [UIColor colorWithRed:0.341f green:0.898f blue:0.996f alpha:1.00f],
                        nil]];
    
    barRects = [[NSMutableArray alloc] init];
    for (int i = 0; i < numOfBar; i++) {
        [barRects addObject:[[RCBar alloc]
                             initWithCurrSize:
                             CGSizeMake((self.frame.size.width/numOfBar), self.frame.size.height)
                             DestSize:
                             CGSizeMake((self.frame.size.width * [[values objectAtIndex:i] floatValue]), self.frame.size.height)
                             Rect:CGRectMake(i * (self.frame.size.width/numOfBar), 0, self.frame.size.width/numOfBar, self.frame.size.height)
                             Color:[[barColors objectAtIndex:i%[barColors count]]CGColor]
                             ]
         ];
    }
}

- (void)setBarColors:(NSArray *)uiColorArray {
    barColors = [NSArray arrayWithArray:uiColorArray];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!startAnimation) {
        startAnimation = YES;
        animationTimer = [NSTimer scheduledTimerWithTimeInterval:.025 target:self selector:@selector(updateValue) userInfo:nil repeats:YES];
    }
    for (int i = 0; i < numOfBar; i++) {
        RCBar *thisBar = [barRects objectAtIndex:i];
        CGContextSetFillColorWithColor(context, [[barColors objectAtIndex:i%[barColors count]] CGColor]);
        CGContextFillRect(context, [thisBar rect]);
    }
}

- (void)updateValue {
    endAnimation = YES;
    for (int i = 0; i < numOfBar; i++) {
        RCBar *thisBar = [barRects objectAtIndex:i];
        [thisBar updateValue];
        if (0 < i) {
            RCBar *prevBar = [barRects objectAtIndex:i-1];
            [thisBar setRectOriginX: [prevBar rectOriginX]+[prevBar currSize].width];
        }
        endAnimation = (endAnimation && [thisBar isUpdateEnd]);
    }
    if (endAnimation) {
        [animationTimer invalidate];
        animationTimer = nil;
    }
    [self setNeedsDisplay];
}

@end
