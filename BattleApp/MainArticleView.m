//
//  MainArticleView.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 16..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "MainArticleView.h"

@implementation MainArticleView

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [[self imageView] setFrame:CGRectMake(15, 15, [self bounds].size.width-30, 200)];
    [[self titleView] setFrame:CGRectMake(20, 120, [self bounds].size.width-40, 80)];
    [[self bottomView] setFrame:CGRectMake(0, 220, [self bounds].size.width, 30)];
    [[self authorView] setFrame:CGRectMake(15, 0, [self bounds].size.width/2-15, 20)];
    [[self dateView] setFrame:CGRectMake([self bounds].size.width/2, 0, [self bounds].size.width/2-15, 20)];
}

- (void)setupViews {
    [super setupViews];
    [self.titleView setBackgroundColor:[UIColor colorWithWhite:14/255.0f alpha:0.6f]];
    [self.titleView setFont:[UIFont boldSystemFontOfSize:25]];
}

@end
