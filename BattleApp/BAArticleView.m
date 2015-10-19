//
//  BAArticleView.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 16..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "BAArticleView.h"

@implementation BAArticleView

{
    UIImageView *imageView;
    UILabel     *titleView;
    UIView      *bottomView;
    UILabel     *authorView;
    UILabel     *dateView;
    Article     *article;
}

@synthesize imageView = imageView;
@synthesize titleView = titleView;
@synthesize bottomView = bottomView;
@synthesize authorView = authorView;
@synthesize dateView = dateView;
@synthesize article = article;

- (instancetype)initWithFrame:(CGRect)frame andArticle:(Article *)aArticle {
    self = [super initWithFrame:frame];
    if (self) {
        article = aArticle;
        [self setBackgroundColor:[UIColor colorWithWhite:14/255.0f alpha:0.8f]];
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
        [self setBackgroundColor:[UIColor colorWithWhite:14/255.0f alpha:0.8f]];
}


@end
