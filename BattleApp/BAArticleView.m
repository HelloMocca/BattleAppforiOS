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
    [self.titleView setLineBreakMode:NSLineBreakByWordWrapping];
    [self.titleView setNumberOfLines:2];
    [self.titleView setTextColor:[UIColor whiteColor]];
    [self.titleView setFont:[UIFont boldSystemFontOfSize:16]];
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
    [self.authorView setFont:[UIFont systemFontOfSize:13]];
    [self.authorView setTextColor:[UIColor baDarkGrayColor]];
    [[self bottomView ] addSubview:authorView];
}

- (void)setupDateView {
    dateView = [[UILabel alloc] init];
    [self.dateView setFont:[UIFont systemFontOfSize:13]];
    [self.dateView setTextColor:[UIColor baDarkGrayColor]];
    [self.dateView setTextAlignment:NSTextAlignmentRight];
    [[self bottomView ] addSubview:dateView];
}

- (void)attachArticleInViews:(Article *)aArticle {
    article = aArticle;
    [self.imageView setImage:[article thumbnail]];
    [[self titleView] setText:[article title]];
    [[self authorView] setText:[article author]];
    [[self dateView] setText:[article date]];
    [spinner stopAnimating];
}


@end
