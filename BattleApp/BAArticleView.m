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
    
    UIActivityIndicatorView *spinner;
}

@synthesize imageView = imageView;
@synthesize titleView = titleView;
@synthesize bottomView = bottomView;
@synthesize authorView = authorView;
@synthesize dateView = dateView;
@synthesize article = article;
@synthesize spinner = spinner;

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupSpinner];
        [self setupViews];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [[self spinner] setFrame:self.frame];
}

- (void)setupSpinner {
    spinner = [[UIActivityIndicatorView alloc] init];
    [spinner setColor:[UIColor cloudColor]];
    [self addSubview:spinner];
}

- (void)setupViews {
    [self setBackgroundColor:[UIColor colorWithWhite:14/255.0f alpha:0.6f]];
    [spinner startAnimating];
    [self setupImageView];
    [self setupTitleView];
    [self setupBottomView];
}

- (void)setupImageView {
    imageView = [[UIImageView alloc] init];
    [self addSubview:imageView];
}

- (void)setupTitleView {
    titleView = [[UILabel alloc] init];
    [self addSubview:titleView];
}

- (void)setupBottomView {
    bottomView = [[UIView alloc] init];
    [self addSubview:bottomView];
    [self setupAuthorView];
    [self setupDateView];
}

- (void)setupAuthorView {
    authorView = [[UILabel alloc] init];
    [authorView setFont:[UIFont systemFontOfSize:13]];
    [authorView setTextColor:[UIColor baDarkGrayColor]];
    [bottomView addSubview:authorView];
}

- (void)setupDateView {
    dateView = [[UILabel alloc] init];
    [dateView setFont:[UIFont systemFontOfSize:13]];
    [dateView setTextColor:[UIColor baDarkGrayColor]];
    [dateView setTextAlignment:NSTextAlignmentRight];
    [bottomView addSubview:dateView];
}

- (void)attachArticleInViews:(Article *)aArticle {
    article = aArticle;
    [imageView setImage:[article thumbnail]];
    [titleView setText:[article title]];
    [authorView setText:[article author]];
    [dateView setText:[article date]];
    [spinner stopAnimating];
}


@end
