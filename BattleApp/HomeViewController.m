//
//  HomeViewController.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 12..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "HomeViewController.h"

@implementation HomeViewController

{
    NSMutableArray              *articles;
    CGSize                      screenSize;
    UIScrollView                *mainScrollView;
    UITapGestureRecognizer      *tapRecognizer;
    ArticleDetailViewController *articleDetailViewController;
}

#pragma mark -Initialize methods
- (instancetype)init {
    self = [super init];
    if (self) {
        screenSize = [[UIScreen mainScreen] bounds].size;
    }
    return self;
}

#pragma mark -UIViewController implements
- (void)viewDidLoad {
    [super viewDidLoad];
    [[[self navigationController] navigationBar] setShadowImage:[[UIImage alloc] init]];
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [self applyTransparentBackgroundToTheNavigationBar:0];
}

- (void)setupViews {
    [self setupScrollView];
    [self setupNews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark -Request data method
- (void)requestNewsData {
    articles = [[NSMutableArray alloc] init];
    NSString *url = @"http://125.209.198.90/battleapp/wcsnews.php";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    if ([jsonObject count] == 0) {
        NSLog(@"news article data is nil");
        return;
    }
    NSArray *result = [jsonObject objectForKey:@"articles"];
    for (NSDictionary *currArticle in result) {
        [articles addObject:[[Article alloc] initWithDictionary:currArticle]];
    }
    result = nil;
}


#pragma mark -Setup View methods
- (void)setupScrollView {
    mainScrollView = [[UIScrollView alloc] init];
    [mainScrollView setFrame:CGRectMake(0, -40, screenSize.width, screenSize.height)];
    [mainScrollView setContentSize:CGSizeMake(screenSize.width, 600)];
    [mainScrollView setShowsVerticalScrollIndicator:NO];
    [mainScrollView setShowsHorizontalScrollIndicator:NO];
    [mainScrollView setScrollEnabled:YES];
    [[self view] addSubview:mainScrollView];
}

- (void)setupNews {
    [self requestNewsData];
    [self setupMainArticle];
    [self setupSubArticle];
    [self setupMoreArticleBtn];
}

- (void)setupMainArticle {
    if ([articles count] == 0) return; //article null check
    Article *mainArticle = [articles objectAtIndex:0];
    UIView *mainArticleView = [[MainArticleView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, 250) andArticle:mainArticle];
    [mainScrollView addSubview:mainArticleView];
    [mainArticleView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(articleTap:)]];
}

- (void)setupSubArticle {
    UIView *subArticleContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 260, screenSize.width, 330)];
    NSUInteger maxArticle = [articles count];
    if (maxArticle > 5) maxArticle = 5;
    for (int i = 1; i < maxArticle; i++) {
        SubArticleView *subArticleView = [[SubArticleView alloc] initWithFrame:CGRectMake(0, ((i-1)*82), screenSize.width, 80) andArticle:[articles objectAtIndex:i]];
        [subArticleContainerView addSubview:subArticleView];
        [subArticleView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(articleTap:)]];
    }
    [mainScrollView addSubview:subArticleContainerView];
}

- (void)setupMoreArticleBtn {
    UIButton *moreArticleBtn = [[UIButton alloc] init];
    [moreArticleBtn setFrame:CGRectMake(5, 590, screenSize.width-10, 40)];
    [moreArticleBtn setBackgroundColor:[UIColor facebookBlueColor]];
    [moreArticleBtn setTitle:@"More News" forState:UIControlStateNormal];
    [mainScrollView addSubview:moreArticleBtn];
}


#pragma mark -Event handle methods
- (void)articleTap:(UITapGestureRecognizer *)recognizer {
    BAArticleView *tappedav = (BAArticleView *)recognizer.view;
    articleDetailViewController = [[ArticleDetailViewController alloc] initWithArticle:tappedav.article];
    [[self navigationController] pushViewController:articleDetailViewController animated:YES];
}

@end
