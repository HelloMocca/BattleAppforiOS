//
//  ScheduleTableViewController.m
//  BattleApp
//
//  Created by mocca on 2015. 11. 9..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "ScheduleTableViewController.h"

@implementation ScheduleTableViewController
{
    NSMutableArray *schedules;
    NSUInteger     segmentStatus;
}
#define PREMIER_STATE 0
#define MAJOR_STATE 1
#define MINOR_STATE 2

#define ODD_COLOR [UIColor colorWithWhite:14/255.0f alpha:.6f]
#define EVEN_COLOR [UIColor colorWithWhite:25/255.0f alpha:.2f]

#pragma mark -UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [[[self navigationController] navigationBar] setBarTintColor:[UIColor blackColor]];
    [self setupSegmentControl];
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [self requestSchedule];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [schedules count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scheduleCell" forIndexPath:indexPath];
    Schedule *schedule = [schedules objectAtIndex:[indexPath row]];
    if ([indexPath row] % 2 == 0) {
        [cell setBackgroundColor:ODD_COLOR];
    } else {
        [cell setBackgroundColor:EVEN_COLOR];
    }
    [cell setupWithSchedule:schedule];
    return cell;
}

#pragma mark - Data Request
- (void)requestSchedule {
    NSString *url;
    if (segmentStatus == PREMIER_STATE) {
        url = @"http://125.209.198.90/battleapp/scheduleDummy.json";
    } else if (segmentStatus == MAJOR_STATE) {
        url = @"http://125.209.198.90/battleapp/majorSchedule.json";
    } else {
        url = @"http://125.209.198.90/battleapp/minorSchedule.json";
    }
    [BAHttpTask requestJSONObjectFromURL:[NSURL URLWithString:url] compeleteHandler:^(NSURLResponse *response, NSDictionary *jsonObject, NSError *connectionError) {
        [self performSelectorOnMainThread:@selector(parsingJsonObject:) withObject:jsonObject waitUntilDone:NO];
    } asynchronous:YES];
}

- (void)parsingJsonObject:(NSDictionary *)jsonObject {
    if ([jsonObject count] == 0) {
        NSLog(@"JSON NOT EXIST ERROR");
        return;
    }
    schedules = [[NSMutableArray alloc] init];
    NSArray *result = [jsonObject objectForKey:@"schedules"];
    for (NSDictionary *schedule in result) {
        [schedules addObject:[[Schedule alloc] initWithDictionary:schedule]];
    }
    [[self tableView] reloadData];
}

#pragma mark - Setup Views
- (void)setupTableView {
    [[self tableView] registerClass:[ScheduleCell class] forCellReuseIdentifier:@"scheduleCell"];
    [[self tableView] setBackgroundColor:[UIColor clearColor]];
    [[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [[self tableView] setRowHeight:80];
}

- (void)setupSegmentControl {
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
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
    segmentStatus = PREMIER_STATE;
}

- (IBAction)segmentChanged:(id)sender {
    segmentStatus =  ((UISegmentedControl *)sender).selectedSegmentIndex;
    [self requestSchedule];
}

@end
