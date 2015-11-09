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
    UIButton                    *moreArticleBtn;
    UIView                      *subArticleContainerView;
    BAWebViewController         *articleDetailViewController;
    MainArticleView             *mainArticleView;
    
    int currOffset;
    int totalArticleCount;
}

#pragma mark -Initialize methods
- (instancetype)init {
    self = [super init];
    if (self) {
        screenSize = [[UIScreen mainScreen] bounds].size;
        totalArticleCount = 0;
        currOffset = 0;
    }
    return self;
}

#pragma mark -UIViewController implements
- (void)viewDidLoad {
    [super viewDidLoad];
    [[[self navigationController] navigationBar] setShadowImage:[[UIImage alloc] init]];
    [self setupSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [self applyTransparentBackgroundToTheNavigationBar:0];
    articleDetailViewController = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark -Request data method
- (void)requestNewsData {
    NSString *url = @"http://125.209.198.90/battleapp/wcsnews.php";
    [BAHttpTask requestJSONObjectFromURL:[NSURL URLWithString:url] compeleteHandler:^(NSURLResponse *response, NSDictionary *jsonObject, NSError *connectionError) {
        [self performSelectorOnMainThread:@selector(attachNewsArticles:) withObject:jsonObject waitUntilDone:NO];
    }  asynchronous:NO];
}

- (void)attachNewsArticles:(NSDictionary *)jsonObject {
    if ([jsonObject count] == 0) {
        NSLog(@"news article data is nil");
        return;
    }
    NSArray *result = [jsonObject objectForKey:@"articles"];
    articles = [[NSMutableArray alloc] init];
    NSDictionary *currArticle;
    for (currArticle in result) {
        [articles addObject:[[Article alloc] initWithDictionary:currArticle]];
    }
    result = nil;
    [self setupMainArticle];
    [self setupSubArticle];
    [self setupMoreArticleBtn];
}

#pragma mark -Setup View methods
- (void)setupSubviews {
    [self setupScrollView];
    [self setupNews];
}

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
    [self setupMainArticleView];
}

- (void)setupMainArticleView {
    mainArticleView = [[MainArticleView alloc] init];
    [mainArticleView setFrame:CGRectMake(0, 0, screenSize.width, 250)];
    [mainScrollView addSubview:mainArticleView];
}

- (void)setupMainArticle {
    if ([articles count] == 0) return;
    Article *mainArticle = [articles objectAtIndex:0];
    [mainArticleView attachArticleInViews:mainArticle];
    [mainArticleView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(articleTap:)]];
}

- (void)setupSubArticle {
    subArticleContainerView = [[UIView alloc] init];
    [self attachSubArticleBegan:1 toEnd:5];
    [mainScrollView addSubview:subArticleContainerView];
}

- (void)setupMoreArticleBtn {
    moreArticleBtn = [[UIButton alloc] init];
    [moreArticleBtn setFrame:CGRectMake(5, 590, screenSize.width-10, 40)];
    [moreArticleBtn setBackgroundColor:[UIColor facebookBlueColor]];
    [moreArticleBtn setTitle:@"View More Articles" forState:UIControlStateNormal];
    [moreArticleBtn addTarget:self action:@selector(moreArticleRequest:) forControlEvents:UIControlEventTouchUpInside];
    [mainScrollView addSubview:moreArticleBtn];
}

- (void)attachSubArticleBegan:(int)beganOffset toEnd:(int)endOffset {
    if (beganOffset == endOffset) return;
    int maxArticle = (int)[articles count];
    if (maxArticle < endOffset) endOffset = maxArticle;
    for (int i = beganOffset, r = 0; i < endOffset; i++) {
        SubArticleView *subArticleView = [[SubArticleView alloc] init];
        [subArticleView setFrame:CGRectMake(0, (totalArticleCount*82)+(r*82), screenSize.width, 80)];
        [subArticleView attachArticleInViews:[articles objectAtIndex:i]];
        [subArticleContainerView addSubview:subArticleView];
        [subArticleView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(articleTap:)]];
        r++;
    }
    totalArticleCount += endOffset - beganOffset;
    [subArticleContainerView setFrame:CGRectMake(0, 260, screenSize.width, totalArticleCount*82)];
    [mainScrollView setContentSize:CGSizeMake(screenSize.width, subArticleContainerView.frame.origin.y + subArticleContainerView.frame.size.height + 40)];
    currOffset = endOffset;
}

- (void)refreshMoreArticleBtnPosition {
    if (moreArticleBtn == nil) return;
    [moreArticleBtn setFrame:CGRectMake(5, 260+(totalArticleCount*82)+2, screenSize.width-10, 40)];
}

#pragma mark -Event handle methods
- (void)articleTap:(UITapGestureRecognizer *)recognizer {
    BAArticleView *tappedav = (BAArticleView *)recognizer.view;
    articleDetailViewController = [[BAWebViewController alloc] initWithLink:[@"http://wcs.battle.net" stringByAppendingString:tappedav.article.link]];
    [[self navigationController] pushViewController:articleDetailViewController animated:YES];
}

- (IBAction)moreArticleRequest:(id)sender {
    [self attachSubArticleBegan:currOffset toEnd:currOffset+5];
    [self refreshMoreArticleBtnPosition];
}

@end
