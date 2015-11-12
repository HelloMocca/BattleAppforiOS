//
//  SubArticleView.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 16..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "SubArticleView.h"

@implementation SubArticleView

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self.titleView setFrame:CGRectMake(110, 5, [self bounds].size.width - 120, 50)];
    [self.imageView setFrame:CGRectMake(5, 10, 90, 60)];
    [self.bottomView setFrame:CGRectMake(110, [self bounds].size.height - 25, [self bounds].size.width - 130, 15)];
    [self.authorView setFrame:CGRectMake(0, 0, [self.bottomView bounds].size.width / 2, 15)];
    [self.dateView setFrame:CGRectMake([self.bottomView bounds].size.width / 2, 0, [self.bottomView bounds].size.width / 2, 15)];
}

- (void)setupViews {
    [super setupViews];
    [self.titleView setLineBreakMode:NSLineBreakByTruncatingTail];
    [self.titleView setNumberOfLines:2];
    [self.titleView setFont:[UIFont boldSystemFontOfSize:16]];
    [self.titleView setTextColor:[UIColor whiteColor]];
}

@end
