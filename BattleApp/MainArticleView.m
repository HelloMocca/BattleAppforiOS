//
//  MainArticleView.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 16..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "MainArticleView.h"

@implementation MainArticleView

{
    UIActivityIndicatorView *spinner;
}

- (void)setupViews {
    [super setupViews];
    spinner = [[UIActivityIndicatorView alloc] init];
    spinner.color = [UIColor cloudColor];
    [spinner startAnimating];
    [self addSubview:spinner];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    if ([spinner isAnimating]) {
        [spinner setFrame:self.frame];
    }
}

- (void)attachArticle:(Article *)aArticle {
    self.article = aArticle;
    self.imageView = [[UIImageView alloc] initWithImage:[self.article thumbnail]];
    [self.imageView setFrame:CGRectMake(15, 15, [self bounds].size.width-30, 200)];
    [self addSubview:self.imageView];
    
    self.titleView = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, [self bounds].size.width-40, 80)];
    [self.titleView setBackgroundColor:[UIColor colorWithWhite:14/255.0f alpha:0.6f]];
    [self.titleView setText:[self.article title]];
    [self.titleView setLineBreakMode:NSLineBreakByWordWrapping];
    [self.titleView setNumberOfLines:2];
    [self.titleView setFont:[UIFont boldSystemFontOfSize:25]];
    [self.titleView setTextColor:[UIColor whiteColor]];
    [self addSubview:self.titleView];
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 220, [self bounds].size.width, 30)];
    [self addSubview:self.bottomView];
    
    self.authorView = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, [self bounds].size.width/2-15, 20)];
    [self.authorView setText:[self.article author]];
    [self.authorView setTextColor:[UIColor baDarkGrayColor]];
    [self.authorView setFont:[UIFont systemFontOfSize:13]];
    [self.bottomView addSubview:self.authorView];
    
    self.dateView = [[UILabel alloc] initWithFrame:CGRectMake([self bounds].size.width/2, 0, [self bounds].size.width/2-15, 20)];
    [self.dateView setText:[self.article date]];
    [self.dateView setTextColor:[UIColor baDarkGrayColor]];
    [self.dateView setTextAlignment:NSTextAlignmentRight];
    [self.dateView setFont:[UIFont systemFontOfSize:13]];
    [self.bottomView addSubview:self.dateView];
    [spinner removeFromSuperview];
}


@end
