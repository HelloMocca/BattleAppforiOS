//
//  BAGameTableViewController.m
//  BattleApp
//
//  Created by mocca on 2015. 11. 3..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "BAGameTableViewController.h"

@implementation BAGameTableViewController

{
    NSArray *games;
    BAWebViewController *vodViewController;
}

#pragma mark -Initialize methods
- (instancetype)initWithGames:(NSArray *)array {
    self = [super init];
    if (self) {
        NSMutableArray *tempGameArray = [[NSMutableArray alloc] init];
        NSDictionary *currGame;
        Game *tmpGame;
        for (currGame in array) {
            tmpGame = [[Game alloc] initWithDictionary:currGame];
            [tempGameArray addObject:tmpGame];
        }
        games = [NSArray arrayWithArray:tempGameArray];
    }
    return self;
}

#pragma mark -UITableViewCell Override methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [[self tableView] registerClass:[GameCell class] forCellReuseIdentifier:@"gameCell"];
    [[self tableView] setRowHeight:80];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    vodViewController = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [games count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"gameCell" forIndexPath:indexPath];
    Game *game = [games objectAtIndex:[indexPath row]];
    [cell setupWithGame:game];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Game *currGame = [games objectAtIndex:[indexPath row]];
    vodViewController = [[BAWebViewController alloc] initWithLink:@"https://youtu.be/MeH_z7Qe0CE"];
    [[self navigationController] pushViewController:vodViewController animated:NO];
}

@end
