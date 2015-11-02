//
//  SubArticleView.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 16..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "SubArticleView.h"

@implementation SubArticleView

- (void)setupViews {
    [super setupViews];
    self.imageView = [[UIImageView alloc] initWithImage:[[self article] thumbnail]];
    [self.imageView setFrame:CGRectMake(5, 10, 90, 60)];
    [self addSubview:self.imageView];
    
    self.titleView = [[UILabel alloc] initWithFrame:CGRectMake(110, 5, [self bounds].size.width - 120, 50)];
    [self.titleView setText:[self.article title]];
    [self.titleView setLineBreakMode:NSLineBreakByWordWrapping];
    [self.titleView setNumberOfLines:2];
    [self.titleView setFont:[UIFont boldSystemFontOfSize:16]];
    [self.titleView setTextColor:[UIColor baWhiteColor]];
    [self addSubview:self.titleView];
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(110, 55, [self bounds].size.width - 130, 15)];
    [self addSubview:self.bottomView];
    
    self.authorView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [self.bottomView bounds].size.width/2, 15)];
    [self.authorView setText:[self.article author]];
    [self.authorView setTextColor:[UIColor baDarkGrayColor]];
    [self.authorView setFont:[UIFont systemFontOfSize:13]];
    self.dateView = [[UILabel alloc] initWithFrame:CGRectMake([self.bottomView bounds].size.width/2, 0, [self.bottomView bounds].size.width/2, 15)];
    [self.dateView setText:[self.article date]];
    [self.dateView setFont:[UIFont systemFontOfSize:13]];
    [self.dateView setTextColor:[UIColor baDarkGrayColor]];
    [self.dateView setTextAlignment:NSTextAlignmentRight];
    
    [self.bottomView addSubview:self.authorView];
    [self.bottomView addSubview:self.dateView];
}

@end
