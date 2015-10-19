//
//  LeagueTableViewController.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 14..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "LeagueTableViewController.h"

@implementation LeagueTableViewController

{
    NSArray *leagues;
    UIView  *cellView;
}

#pragma mark -Initialize methods
- (instancetype) initWithLeagues:(NSMutableArray *)aLeagues {
    self = [super init];
    if (self) {
        leagues = [NSArray arrayWithArray:aLeagues];
    }
    return self;
}

#pragma mark -UIViewController implements
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark -UITableViewController implements
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [leagues count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"default cell" forIndexPath:indexPath];
    League *league = [leagues objectAtIndex:[indexPath row]];
    [cell setBackgroundColor:[UIColor colorWithRed:14/255.0f green:14/255.0f blue:14/255.0f alpha:0.6]];
    [cell setSelectedBackgroundView:cellView];
    [[cell textLabel] setText:[league title]];
    [[cell textLabel] setTextColor:[UIColor whiteColor]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    League *league = [leagues objectAtIndex:[indexPath row]];
    NSLog(@"%@", [league title]);
    LeagueInfoViewController *newViewController = [[LeagueInfoViewController alloc] initWithLeague:league];
    [[self navigationController] pushViewController:newViewController animated:YES];
}

#pragma mark -Setup View methods
- (void)setupViews {
    [[self view] setBackgroundColor:[UIColor clearColor]];
    [self setupTableView];
}

- (void)setupTableView {
    [[self tableView] registerClass:[UITableViewCell class] forCellReuseIdentifier:@"default cell"];
    [[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    cellView = [[UIView alloc] init];
    [cellView setBackgroundColor:[UIColor blackColor]];
}

@end
