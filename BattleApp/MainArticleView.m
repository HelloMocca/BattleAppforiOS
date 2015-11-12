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
    CAGradientLayer *gradientLayer;
    UILabel *titleTextView;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [[self imageView] setFrame:CGRectMake(0, 15, [self bounds].size.width, 200)];
    [[self titleView] setFrame:CGRectMake(0, 120, [self bounds].size.width, 95)];
    [[self bottomView] setFrame:CGRectMake(0, 220, [self bounds].size.width, 30)];
    [[self authorView] setFrame:CGRectMake(15, 0, [self bounds].size.width/2-15, 20)];
    [[self dateView] setFrame:CGRectMake([self bounds].size.width/2, 0, [self bounds].size.width/2-15, 20)];
    
    gradientLayer.frame = self.titleView.bounds;
    [titleTextView setFrame:CGRectMake(15, self.imageView.bounds.origin.y+self.imageView.bounds.size.height-65, self.bounds.size.width-30, 75)];
}

- (void)setupViews {
    [super setupViews];
    
    gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
    [self.titleView.layer insertSublayer:gradientLayer atIndex:0];
    
    titleTextView = [[UILabel alloc] init];
    [titleTextView setTextColor:[UIColor cloudColor]];
    [titleTextView setFont:[UIFont boldSystemFontOfSize:25]];
    [titleTextView setLineBreakMode:NSLineBreakByTruncatingTail];
    [titleTextView setNumberOfLines:2];
    
    [self addSubview:titleTextView];
}

- (void)attachArticleInViews:(Article *)aArticle {
    [super attachArticleInViews:aArticle];
    [self.titleView setText:@""];
    [titleTextView setText:[aArticle title]];
}

@end
