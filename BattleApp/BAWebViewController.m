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
    CGSize screenSize;
    NSString *link;
    UIWebView *webView;
}

- (instancetype)initWithLink:(NSString *)url {
    self = [super init];
    if (self) {
        link = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    screenSize = [UIScreen mainScreen].bounds.size;
    [[self view] setBackgroundColor:[UIColor colorWithWhite:45/255.0f alpha:1]];
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    [[self view] addSubview:webView];
    
}
- (void)viewWillAppear:(BOOL)animated {
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:link]];
    [webView loadRequest:urlRequest];
    [self.view addSubview:webView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [webView removeFromSuperview];
    [[self navigationController] popToRootViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
