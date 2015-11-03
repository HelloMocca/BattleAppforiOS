//
//  LeagueInfoViewController.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 15..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "LeagueInfoViewController.h"

@implementation LeagueInfoViewController

{
    League  *league;
    CGSize  screenSize;
    NSArray *games;
    UIView *leagueLabelView;
}

- (instancetype)initWithLeague:(League *)aLeague {
    self = [super init];
    if (self) {
        league = aLeague;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    screenSize = [[UIScreen mainScreen] bounds].size;
    [self setupLeagueLabelView];
    [self setupLeagueGameView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupLeagueLabelView {
    [[self view] setBackgroundColor:[UIColor colorWithRed:14/255.0f green:14/255.0f blue:14/255.0f alpha:1]];
    leagueLabelView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, screenSize.width, 80)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, screenSize.width-20, 25)];
    [titleLabel setText:[league title]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    [titleLabel setTextColor:[UIColor baWhiteColor]];
    [leagueLabelView addSubview:titleLabel];
    
    UILabel *openDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 25+5, screenSize.width-20, 25)];
    [openDateLabel setText:[league openDate]];
    [openDateLabel setFont:[UIFont systemFontOfSize:15]];
    [openDateLabel setTextColor:[UIColor baWhiteColor]];
    [leagueLabelView addSubview:openDateLabel];
    
    [[self view] addSubview:leagueLabelView];
}

- (void)setupLeagueGameView {
    NSDictionary *jsonObject = [self requestLeagueGameData];
    games = [jsonObject objectForKey:@"games"];
    BAGameTableViewController *gameTableVC = [[BAGameTableViewController alloc] initWithGames:games];
    [[gameTableVC tableView] setFrame:CGRectMake(0, leagueLabelView.frame.origin.y+leagueLabelView.frame.size.height+10, screenSize.width, screenSize.height - leagueLabelView.frame.size.height - 10)];
    [self addChildViewController:gameTableVC];
    [[self view] addSubview:[gameTableVC tableView]];
}

- (NSDictionary *)requestLeagueGameData {
    //Dummy Data!
    NSString *url = @"http://125.209.198.90/battleapp/games.php?lid=4";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

@end
