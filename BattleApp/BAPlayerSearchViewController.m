
//
//  BAPlayerSearchViewController.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 22..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "BAPlayerSearchViewController.h"

@implementation BAPlayerSearchViewController

{
    NSString                  *url;
    
    NSMutableArray            *players;
    NSUInteger                offset;
    
    CGSize                    screenSize;
    UIView                    *selectedCellView;
    UIButton                  *morePlayerBtn;
    
    BASearchDisplayController *searchController;
    UIActivityIndicatorView   *spinner;
    
}

#define ODD_COLOR [UIColor colorWithWhite:14/255.0f alpha:.6f]
#define EVEN_COLOR [UIColor colorWithWhite:25/255.0f alpha:.6f]

@synthesize delegate = delegate;

#pragma mark -Initialize methods
- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        url = @"http://125.209.198.90/battleapp/players.php?q=";
    }
    return self;
}

#pragma mark -UIViewController implements
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self requestPlayerList:@""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -UITableViewController implements
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return offset;
}

- (PlayerTableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"playerCell" forIndexPath:indexPath];
    Player *player = [players objectAtIndex:[indexPath row]];
    [cell setupWithPlayer:player];
    if ([indexPath row] % 2 == 0) {
        [cell setBackgroundColor:ODD_COLOR];
    } else {
        [cell setBackgroundColor:EVEN_COLOR];
    }
    [cell setSelectedBackgroundView:selectedCellView];
    [[cell textLabel] setTextColor:[UIColor whiteColor]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Player *player = [players objectAtIndex:[indexPath row]];
    [delegate selectPlayer:player];
}

#pragma mark -UISearchDisplayDelegate implements
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self requestPlayerList:searchString];
    return YES;
}

#pragma mark -Setup view methods
- (void)setupViews {
    screenSize = [[UIScreen mainScreen] bounds].size;
    [[[self navigationController] navigationBar] setBarTintColor:[UIColor blackColor]];
    [[self view] setBackgroundColor:[UIColor clearColor]];
    [self setupSpinnerView];
    [self setupSearchBar];
    [self setupTableView];
}

- (void)setupSpinnerView {
    spinner = [[UIActivityIndicatorView alloc] init];
    [self.view addSubview:spinner];
}

- (void)setupSearchBar {
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, 44)];
    searchController = [[BASearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    searchController.searchResultsDataSource = self;
    searchController.delegate = self;
    self.navigationItem.titleView = searchController.searchBar;
}

- (void)setupTableView {
    [[self tableView] setRowHeight:80];
    [[self tableView] registerClass:[PlayerTableViewCell class] forCellReuseIdentifier:@"playerCell"];
    [[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self setupSelectedCellView];
    [self setupMoreBtn];
}

- (void)setupSelectedCellView {
    selectedCellView = [[UIView alloc] init];
    [selectedCellView setBackgroundColor:[UIColor blackColor]];
}

- (void)setupMoreBtn {
    morePlayerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, screenSize.width-20, 40)];
    [morePlayerBtn setBackgroundColor:[UIColor facebookBlueColor]];
    [morePlayerBtn setTitle:@"More Player" forState:UIControlStateNormal];
    [morePlayerBtn addTarget:self action:@selector(morePlayerRequest:) forControlEvents:UIControlEventTouchUpInside];
    [[self tableView] setTableFooterView:morePlayerBtn];
}

- (void)didRequestStart {
    [morePlayerBtn setHidden:YES];
    if (![spinner isAnimating]) {
        [spinner setFrame:self.view.frame];
        spinner.color = [UIColor cloudColor];
        [spinner startAnimating];
    }
}

- (void)didRequestEnd {
    offset = 0;
    [self morePlayerRequest:nil];
    [spinner stopAnimating];
}

#pragma mark -Data request methods
- (void)requestPlayerList:(NSString *)query {
    [self didRequestStart];
    query = ([query isEqual:nil]) ? @"" : query;
    id handler = ^(NSURLResponse *response, NSDictionary *jsonObject, NSError *connectionError){
       [self performSelectorOnMainThread:@selector(parsingJsonObject:) withObject:jsonObject waitUntilDone:NO];
    };
    [BAHttpTask requestJSONObjectFromURL:[NSURL URLWithString:[url stringByAppendingString:query]] compeleteHandler:handler asynchronous:YES];
}

#pragma mark -Data parsing methods
- (void)parsingJsonObject:(NSDictionary *)jsonObject {
    if ([jsonObject count] == 0) {
        NSLog(@"JSON NOT EXIST ERROR");
        return;
    }
    players = [[NSMutableArray alloc] init];
    NSArray *result = [jsonObject objectForKey:@"players"];
    for (NSDictionary *currPlayer in result) {
        [players addObject:[[Player alloc] initWithDictionary:currPlayer]];
    }
    [self didRequestEnd];
}

#pragma mark -Event handle methods
- (IBAction)morePlayerRequest:(id)sender {
    offset += 10;
    if (offset > [players count]) {
        offset = [players count];
        [morePlayerBtn setHidden:YES];
    } else {
        [morePlayerBtn setHidden:NO];
    }
    [[self tableView] reloadData];
}

@end
