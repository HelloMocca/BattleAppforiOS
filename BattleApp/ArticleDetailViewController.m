//
//  ArticleDetailViewController.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 16..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "ArticleDetailViewController.h"

@implementation ArticleDetailViewController

{
    Article *article;
    CGSize  screenSize;
}

#pragma mark -Initialize methods
- (instancetype)initWithArticle:(Article *)aArticle {
    self = [super init];
    if (self) {
        screenSize = [[UIScreen mainScreen] bounds].size;
        article = aArticle;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor colorWithWhite:45/255.0f alpha:1]];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    NSString *urlString = [@"http://wcs.battle.net" stringByAppendingString:article.link];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [webView loadRequest:urlRequest];
    [self.view addSubview:webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
