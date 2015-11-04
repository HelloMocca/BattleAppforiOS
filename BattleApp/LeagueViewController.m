//
//  LeagueViewController.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 12..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "LeagueViewController.h"

@implementation LeagueViewController

{
    LeagueTableViewController *leagueTableViewController;
    NSMutableArray            *leagues;
    CGSize                    screenSize;
    NSUInteger                segmentStatus;
}

#define PREMIER_STATE 0
#define MAJOR_STATE 1
#define MINOR_STATE 2


- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

#pragma mark -UIViewController implements
- (void)viewDidLoad {
    [super viewDidLoad];
    screenSize = [[UIScreen mainScreen] bounds].size;
    [self requestLeaguesData];
    [self setupTableView];
    [self setupSegmentControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupTableView {
    leagueTableViewController = [[LeagueTableViewController alloc] init];
    [[leagueTableViewController tableView] setFrame:CGRectMake(0, 5, screenSize.width, screenSize.height)];
    [self addChildViewController:leagueTableViewController];
    [[self view] addSubview:[leagueTableViewController view]];
}

- (void)setupSegmentControl {
    UIViewController *segmentViewController = [[UIViewController alloc] init];
    [[segmentViewController view] setFrame:CGRectMake(0, 64, screenSize.width, 45)];
    [[segmentViewController view] setBackgroundColor:[UIColor colorWithWhite:14/255.0f alpha:.9]];
    NSArray *segmentTextContent = [NSArray arrayWithObjects: @"Premier", @"Major", @"Minor", nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentTextContent];
    segmentedControl.frame = CGRectMake(0, 5, screenSize.width-15, 35);
    [segmentedControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.tintColor = [UIColor cloudColor];
    segmentedControl.enabled = true;
    segmentedControl.selectedSegmentIndex = 0;
    [[[self navigationController] navigationBar] addSubview:segmentedControl];
    [[segmentViewController view] addSubview:segmentedControl];
    self.navigationItem.titleView = [segmentViewController view];
}


#pragma mark -Data request methods
- (void)requestLeaguesData {
    NSString *url = @"http://125.209.198.90/battleapp/leagues.php";
    [BAHttpTask requestJSONObjectFromURL:[NSURL URLWithString:url] compeleteHandler:^(NSURLResponse *response, NSDictionary *jsonObject, NSError *connectionError) {
        [self performSelectorOnMainThread:@selector(parseLeagueData:) withObject:jsonObject waitUntilDone:NO];
    } asynchronous:YES];
}

- (void)parseLeagueData:(NSDictionary *)jsonObject {
    leagues = [[NSMutableArray alloc] init];
    NSArray *result = [jsonObject objectForKey:@"leagues"];
    for (NSDictionary *currLeague in result) {
        [leagues addObject:[[League alloc] initWithDictionary:currLeague]];
    }
    result = nil;
    [leagueTableViewController setLeagues:leagues];
    [[leagueTableViewController tableView] reloadData];
}

#pragma mark -Event handler methods
- (IBAction)segmentChanged:(id)sender {
    segmentStatus =  ((UISegmentedControl *)sender).selectedSegmentIndex;
    [self requestLeaguesData];
}

@end
