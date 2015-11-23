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
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setTitle:@"WCS SCHEDULE"];
    }
    return self;
}

#pragma mark -UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [[[self navigationController] navigationBar] setBarTintColor:[UIColor blackColor]];
    [[[self navigationController] navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0.231f green:0.702f blue:0.753f alpha:1.00f]}];
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [self requestSchedule];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
        [cell setBackgroundColor:[UIColor oddCellColor]];
    } else {
        [cell setBackgroundColor:[UIColor evenCellColor]];
    }
    [cell setupWithSchedule:schedule];
    return cell;
}

#pragma mark - Data Request
- (void)requestSchedule {
    NSString *url =  @"http://125.209.198.90/battleapp/scheduleDummy.json";
    [BAHttpTask requestJSONObjectFromURL:[NSURL URLWithString:url] compeleteHandler:^(NSURLResponse *response, NSDictionary *jsonObject, NSError *connectionError) {
        [self performSelectorOnMainThread:@selector(parsingJsonObject:) withObject:jsonObject waitUntilDone:NO];
    }];
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

@end
