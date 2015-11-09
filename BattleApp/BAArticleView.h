//
//  BAArticleView.h
//  BattleApp
//
//  Created by mocca on 2015. 10. 16..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"
#import "UIColorExtension.h"

@interface BAArticleView : UIView

@property (nonatomic, readwrite) UIImageView *imageView;
@property (nonatomic, readwrite) UILabel     *titleView;
@property (nonatomic, readwrite) UIView      *bottomView;
@property (nonatomic, readwrite) UILabel     *authorView;
@property (nonatomic, readwrite) UILabel     *dateView;
@property (nonatomic, readwrite) Article     *article;

@property (nonatomic, readonly)  UIActivityIndicatorView *spinner;

- (void)setupViews;

- (void)attachArticleInViews:(Article *)aArticle;

@end
