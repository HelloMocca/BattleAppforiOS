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
    CGSize screenSize;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setTitle:@"WCS Leagues"];
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
    leagueTableViewController = [[LeagueTableViewController alloc] initWithLeagues:leagues];
    [[leagueTableViewController tableView] setFrame:CGRectMake(0, 50, screenSize.width, screenSize.height)];
    [self addChildViewController:leagueTableViewController];
    [[self view] addSubview:[leagueTableViewController view]];
}

- (void)setupSegmentControl {
    UIViewController *segmentViewController = [[UIViewController alloc] init];
    [[segmentViewController view] setFrame:CGRectMake(0, 64, screenSize.width, 45)];
    [[segmentViewController view] setBackgroundColor:[UIColor colorWithWhite:14/255.0f alpha:.9]];
    NSArray *segmentTextContent = [NSArray arrayWithObjects: @"Premier", @"Major", @"Minor", nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentTextContent];
    segmentedControl.frame = CGRectMake(2.5, 5, screenSize.width-5, 35);
    [segmentedControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.tintColor = [UIColor colorWithRed:32/255.0f green:139/255.0f blue:181/255.0f alpha:1];
    segmentedControl.enabled = true;
    segmentedControl.selectedSegmentIndex = 0;
    [[[self navigationController] navigationBar] addSubview:segmentedControl];
    [[segmentViewController view] addSubview:segmentedControl];
    [[self view] addSubview:[segmentViewController view]];
}


#pragma mark -Data request methods
- (void)requestLeaguesData {
    leagues = [[NSMutableArray alloc] init];
    
    //Load Json Data...
    NSString *url = @"http://125.209.198.90/battleapp/leagues.php";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ([data isEqual:nil]) {
        NSLog(@"leagues data is nil");
        return;
    }
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSArray *result = [jsonObject objectForKey:@"leagues"];
    
    for (NSDictionary *currLeague in result) {
        [leagues addObject:[[League alloc] initWithDictionary:currLeague]];
    }
    result = nil;
}

#pragma mark -Event handler methods
- (IBAction)segmentChanged:(id)sender {
    [self requestLeaguesData];
    [[leagueTableViewController tableView] reloadData];
}

@end
