//
//  PlayerTableViewController.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 13..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "PlayerTableViewController.h"

@implementation PlayerTableViewController

{
    NSString                  *url;
    NSMutableArray            *players;
    UIView                    *cellView;
    CGSize                    screenSize;
    UIButton                  *morePlayerBtn;
    NSUInteger                offset;
    BASearchDisplayController *searchController;
}

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
    [self connectSearchAPIwithQuery:@""];
    
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
        [cell setBackgroundColor:[cell oddColor]];
    } else {
        [cell setBackgroundColor:[cell evenColor]];
    }
    [cell setSelectedBackgroundView:cellView];
    [[cell textLabel] setTextColor:[UIColor whiteColor]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Player *player = [players objectAtIndex:[indexPath row]];
    PlayerInfoViewController *newViewController = [[PlayerInfoViewController alloc] initWithPlayer:player];
    [[self navigationController] pushViewController:newViewController animated:YES];
}

#pragma mark -UISearchDisplayDelegate implements
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self connectSearchAPIwithQuery:searchString];
    return YES;
}

#pragma mark -Setup view methods
- (void)setupViews {
    screenSize = [[UIScreen mainScreen] bounds].size;
    [[[self navigationController] navigationBar] setBarTintColor:[UIColor blackColor]];
    [[self view] setBackgroundColor:[UIColor clearColor]];
    [self setupSearchBar];
    [self setupTableView];
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
    [[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [[self tableView] setSeparatorInset:UIEdgeInsetsZero];
    [[self tableView] setSeparatorColor:[UIColor colorWithRed:108/255.0f green:108/255.0f blue:108/255.0f alpha:1.00f]];
    cellView = [[UIView alloc] init];
    [cellView setBackgroundColor:[UIColor blackColor]];
    [self setupMoreBtn];
}

- (void)setupMoreBtn {
    morePlayerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, screenSize.width-20, 40)];
    [morePlayerBtn setBackgroundColor:[UIColor colorWithWhite:45/255.0f alpha:1]];
    [morePlayerBtn setTitleColor:[UIColor colorWithRed:0.141f green:0.592f blue:0.847f alpha:1.00f] forState:UIControlStateNormal];
    morePlayerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [morePlayerBtn setTitle:@"More Player" forState:UIControlStateNormal];
    [morePlayerBtn addTarget:self action:@selector(morePlayerRequest:) forControlEvents:UIControlEventTouchUpInside];
    [[self tableView] setTableFooterView:morePlayerBtn];
}

#pragma mark -Data request methods
- (void)connectSearchAPIwithQuery:(NSString *)query {
    if ([query isEqual:nil]) {
        query = @"";
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[url stringByAppendingString:query]]];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    [self parsingJsonObject:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]];
}

#pragma mark -Data parsing methods
- (void)parsingJsonObject:(NSDictionary *)jsonObject {
    if ([jsonObject count] == 0) {
        NSLog(@"player data is nil");
        return;
    }
    players = [[NSMutableArray alloc] init];
    NSArray *result = [jsonObject objectForKey:@"players"];
    for (NSDictionary *currPlayer in result) {
        [players addObject:[[Player alloc] initWithDictionary:currPlayer]];
    }
    offset = 0;
    [morePlayerBtn setHidden:NO];
    [self morePlayerRequest:nil];
    result = nil;
}

#pragma mark -Event handle methods
- (IBAction)morePlayerRequest:(id)sender {
    offset += 10;
    if (offset > [players count]) {
        offset = [players count];
        [morePlayerBtn setHidden:YES];
    }
    [[self tableView] reloadData];
}

@end
