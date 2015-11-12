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
    UIButton                    *moreArticleBtn;
    UIView                      *subArticleContainerView;
    BAWebViewController         *articleDetailViewController;
    MainArticleView             *mainArticleView;
    
    int totalSubArticleCount;
}

#pragma mark -Initialize methods
- (instancetype)init {
    self = [super init];
    if (self) {
        screenSize = [[UIScreen mainScreen] bounds].size;
        totalSubArticleCount = 0;
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
    [super viewWillAppear:animated];
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
    [self attachMainArticle];
    [self setupSubArticle];
    [self setupMoreArticleBtn];
}

#pragma mark -Setup View methods
- (void)setupSubviews {
    [self setupScrollView];
    [self setupNews];
}

- (void)setupScrollView {
    float mainScrollViewContentHeight = 620;
    
    mainScrollView = [[UIScrollView alloc] init];
    [mainScrollView setFrame:CGRectMake(0, -40, screenSize.width, screenSize.height)];
    [mainScrollView setContentSize:CGSizeMake(screenSize.width, mainScrollViewContentHeight)];
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
    float mainArticleViewHeight = 250;
    
    mainArticleView = [[MainArticleView alloc] init];
    [mainArticleView setFrame:CGRectMake(0, 0, screenSize.width, mainArticleViewHeight)];
    [mainScrollView addSubview:mainArticleView];
}

- (void)setupSubArticle {
    subArticleContainerView = [[UIView alloc] init];
    [self attachSubArticleBegan:1 toEnd:5];
    [mainScrollView addSubview:subArticleContainerView];
}

- (void)setupMoreArticleBtn {
    moreArticleBtn = [[UIButton alloc] init];
    [moreArticleBtn setBackgroundColor:[UIColor facebookBlueColor]];
    [moreArticleBtn setTitle:@"View More Articles" forState:UIControlStateNormal];
    [moreArticleBtn addTarget:self action:@selector(moreArticleRequest:) forControlEvents:UIControlEventTouchUpInside];
    [mainScrollView addSubview:moreArticleBtn];
    
    [self refreshMoreArticleBtnPosition];
}

- (void)attachMainArticle {
    if ([articles count] == 0) return;
    
    Article *mainArticle = [articles objectAtIndex:0];
    [mainArticleView attachArticleInViews:mainArticle];
    [mainArticleView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(articleTap:)]];
}

- (void)attachSubArticleBegan:(int)beganOffset toEnd:(int)endOffset {
    if (beganOffset >= endOffset) return;
    
    float subArticleViewHeight = 82;
    float subArticleViewMarginTop = 2;
    int maxArticle = (int)[articles count];
    if (maxArticle < endOffset) endOffset = maxArticle;
    
    for (int i = beganOffset, r = 0; i < endOffset; i++) {
        SubArticleView *subArticleView = [[SubArticleView alloc] init];
        [subArticleView setFrame:CGRectMake(0, (totalSubArticleCount*subArticleViewHeight)+(r*subArticleViewHeight), screenSize.width, subArticleViewHeight-subArticleViewMarginTop)];
        [subArticleView attachArticleInViews:[articles objectAtIndex:i]];
        [subArticleContainerView addSubview:subArticleView];
        [subArticleView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(articleTap:)]];
        r++;
    }
    totalSubArticleCount = endOffset-1;
    
    //refresh subArticleContainerView and mainScrollView
    float heightOfMainArticleView = mainArticleView.frame.size.height;
    [subArticleContainerView setFrame:CGRectMake(0, heightOfMainArticleView+10, screenSize.width, totalSubArticleCount*subArticleViewHeight)];
    [mainScrollView setContentSize:CGSizeMake(screenSize.width, subArticleContainerView.frame.origin.y + subArticleContainerView.frame.size.height + moreArticleBtn.frame.size.height + 20)];
}

- (void)refreshMoreArticleBtnPosition {
    if (moreArticleBtn == nil) return;
    
    float margin = 5;
    float BtnHeight = 40;
    
    [moreArticleBtn setFrame:CGRectMake(margin, subArticleContainerView.frame.origin.y+subArticleContainerView.frame.size.height+margin, screenSize.width - (2 * margin), BtnHeight)];
}

#pragma mark -Event handle methods
- (void)articleTap:(UITapGestureRecognizer *)recognizer {
    BAArticleView *tappedav = (BAArticleView *)recognizer.view;
    articleDetailViewController = [[BAWebViewController alloc] initWithLink:[@"http://wcs.battle.net" stringByAppendingString:tappedav.article.link]];
    [[self navigationController] pushViewController:articleDetailViewController animated:YES];
}

- (IBAction)moreArticleRequest:(id)sender {
    [self attachSubArticleBegan:totalSubArticleCount+1 toEnd:totalSubArticleCount+1+5];
    [self refreshMoreArticleBtnPosition];
}

@end
