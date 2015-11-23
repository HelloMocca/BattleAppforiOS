
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
    NSMutableArray            *players;
    NSUInteger                offset;
    
    CGSize                    screenSize;
    UIView                    *selectedCellView;
    UILabel                   *playerNotFoundView;
    UIButton                  *morePlayerBtn;
    
    UIActivityIndicatorView   *spinner;
}

@synthesize delegate = delegate;

#pragma mark -UIViewController Override methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self requestPlayerList:@""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -UITableViewController Override methods
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return offset;
}

- (PlayerCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"playerCell" forIndexPath:indexPath];
    Player *player = [players objectAtIndex:[indexPath row]];
    [cell setupWithPlayer:player];
    if ([indexPath row] % 2 == 0) {
        [cell setBackgroundColor:[UIColor oddCellColor]];
    } else {
        [cell setBackgroundColor:[UIColor evenCellColor]];
    }
    [cell setSelectedBackgroundView:selectedCellView];
    [[cell textLabel] setTextColor:[UIColor whiteColor]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Player *player = [players objectAtIndex:[indexPath row]];
    [delegate selectPlayer:player];
}

#pragma mark -UISearchBar delegate methods
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self requestPlayerList:searchText];
}

#pragma mark -Setup view methods
- (void)setupViews {
    screenSize = [[UIScreen mainScreen] bounds].size;
    [[[self navigationController] navigationBar] setBarTintColor:[UIColor blackColor]];
    [[self view] setBackgroundColor:[UIColor wetAsphaltColor]];
    [self setupSpinnerView];
    [self setupSearchBar];
    [self setupPlayerNotFoundView];
    [self setupTableView];
}

- (void)setupSpinnerView {
    spinner = [[UIActivityIndicatorView alloc] init];
    [self.view addSubview:spinner];
}

- (void)setupSearchBar {
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, 44)];
    searchBar.delegate = self;
    self.navigationItem.titleView = searchBar;
}

- (void)setupPlayerNotFoundView {
    playerNotFoundView = [[UILabel alloc] init];
    [playerNotFoundView setFrame:CGRectMake(0, 80, screenSize.width, 25)];
    [playerNotFoundView setFont:[UIFont boldSystemFontOfSize:20]];
    [playerNotFoundView setTextAlignment:NSTextAlignmentCenter];
    [playerNotFoundView setTextColor:[UIColor silverColor]];
    [playerNotFoundView setText:@"Player Not Found!"];
}

- (void)setupTableView {
    [[self tableView] setRowHeight:80];
    [[self tableView] registerClass:[PlayerCell class] forCellReuseIdentifier:@"playerCell"];
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

#pragma mark -Data request methods
- (void)requestPlayerList:(NSString *)query {
    [self requestDidSend];
    query = ([query isEqual:nil]) ? @"" : query;
    NSString *url = @"http://125.209.198.90/battleapp/players.php?q=";
    id handler = ^(NSURLResponse *response, NSDictionary *jsonObject, NSError *connectionError){
       [self performSelectorOnMainThread:@selector(parsingJsonObject:) withObject:jsonObject waitUntilDone:NO];
    };
    [BAHttpTask requestJSONObjectFromURL:[NSURL URLWithString:[url stringByAppendingString:query]] compeleteHandler:handler];
}

- (void)requestDidSend {
    [morePlayerBtn setHidden:YES];
    if (![spinner isAnimating]) {
        [spinner setFrame:CGRectMake(0, 150, screenSize.width, 25)];
        spinner.color = [UIColor cloudColor];
        [spinner startAnimating];
    }
}

- (void)requestDidEnd {
    offset = 0;
    [self morePlayerRequest:nil];
    [spinner stopAnimating];
}

#pragma mark -Data parsing methods
- (void)parsingJsonObject:(NSDictionary *)jsonObject {
    if ([jsonObject count] == 0) {
        NSLog(@"JSON NOT EXIST ERROR");
        return;
    }
    
    NSArray *result = [jsonObject objectForKey:@"players"];
    if ([result count] == 0) {
        [self.view addSubview:playerNotFoundView];
    } else {
        [playerNotFoundView removeFromSuperview];
    }
    
    players = [[NSMutableArray alloc] init];
    for (NSDictionary *currPlayer in result) {
        [players addObject:[[Player alloc] initWithDictionary:currPlayer]];
    }
    [self requestDidEnd];
}

#pragma mark -Event handle methods
- (IBAction)morePlayerRequest:(id)sender {
    offset += 20;
    if (offset > [players count]) {
        offset = [players count];
        [morePlayerBtn setHidden:YES];
    } else {
        [morePlayerBtn setHidden:NO];
    }
    [[self tableView] reloadData];
}

@end
