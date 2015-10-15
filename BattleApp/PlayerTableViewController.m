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
    NSString           *url;
    NSMutableArray     *players;
    UIView             *cellView;
    CGSize              screenSize;
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
    screenSize = [[UIScreen mainScreen] bounds].size;
    [[[self navigationController] navigationBar] setBarTintColor:[UIColor blackColor]];
    [[self view] setBackgroundColor:[UIColor clearColor]];
    [self setupTableView];
    [self setupSearchBar];
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
    return [players count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"default cell" forIndexPath:indexPath];
    Player *player = [players objectAtIndex:[indexPath row]];
    [cell setBackgroundColor:[UIColor colorWithRed:14/255.0f green:14/255.0f blue:14/255.0f alpha:0.6]];
    [cell setSelectedBackgroundView:cellView];
    [[cell textLabel] setText:[player playId]];
    [[cell textLabel] setTextColor:[UIColor whiteColor]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Player *player = [players objectAtIndex:[indexPath row]];
    NSLog(@"%@", player);
    PlayerInfoViewController *newViewController = [[PlayerInfoViewController alloc] initWithPlayer:player];
    [[self navigationController] pushViewController:newViewController animated:YES];
}

#pragma mark -UISearchDisplayDelegate implements
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self connectSearchAPIwithQuery:searchString];
    [[self tableView] reloadData];
    return YES;
}

#pragma mark -Setup view methods
- (void)setupSearchBar {
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, 44)];
    searchController = [[BASearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    searchController.searchResultsDataSource = self;
    searchController.delegate = self;
    self.navigationItem.titleView = searchController.searchBar;
}

- (void)setupTableView {
    [[self tableView] registerClass:[UITableViewCell class] forCellReuseIdentifier:@"default cell"];
    [[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    cellView = [[UIView alloc] init];
    [cellView setBackgroundColor:[UIColor blackColor]];
}

#pragma mark -Data request methods
- (void)connectSearchAPIwithQuery:(NSString *)query {
    if ([query isEqual:nil]) {
        query = @"";
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[url stringByAppendingString:query]]];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if (data == nil) {
        NSLog(@"search player response data is nil");
        return;
    }
    [self parsingJsonObject:[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]];
}

#pragma mark -Data parsing methods
- (void)parsingJsonObject:(NSDictionary *)jsonObject {
    players = [[NSMutableArray alloc] init];
    NSArray *result = [jsonObject objectForKey:@"players"];
    for (NSDictionary *currPlayer in result) {
        [players addObject:[[Player alloc] initWithDictionary:currPlayer]];
    }
    result = nil;
}

@end
