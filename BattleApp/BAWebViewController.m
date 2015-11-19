//
//  BAWebViewController.m
//  BattleApp
//
//  Created by mocca on 2015. 11. 5..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "BAWebViewController.h"

@implementation BAWebViewController
{
    NSString  *link;
    UIWebView *webView;
}

#pragma mark -Initialize methods
- (instancetype)initWithLink:(NSString *)url {
    self = [super init];
    if (self) {
        link = url;
    }
    return self;
}

#pragma mark -UIViewController Override methods
- (void)viewDidLoad {
    [super viewDidLoad];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (link == nil) return;
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:link]];
    [webView loadRequest:urlRequest];
    [self.view addSubview:webView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (link == nil) return;
    
    [super viewWillDisappear:animated];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [webView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
