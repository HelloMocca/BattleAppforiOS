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
        [self setTitle:@"INFOMATION"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    screenSize = [[UIScreen mainScreen] bounds].size;
    [self setupLeagueLabelView];
    [self requestLeagueGameData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupLeagueLabelView {
    [[self view] setBackgroundColor:[UIColor wetAsphaltColor]];
    leagueLabelView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, screenSize.width, 120)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, screenSize.width-20, 50)];
    [titleLabel setText:[league title]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
    [titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [titleLabel setNumberOfLines:2];
    [titleLabel setTextColor:[UIColor baWhiteColor]];
    [leagueLabelView addSubview:titleLabel];
    
    BADoubleLabelView *opendateLabel = [[BADoubleLabelView alloc] init];
    [opendateLabel setFrame:CGRectMake(10, titleLabel.frame.origin.y+titleLabel.frame.size.height+5, screenSize.width-20, 15)];
    [opendateLabel setLeftLabelText:@"OPEN DATE" rightLabelText:[league openDate]];
    [leagueLabelView addSubview:opendateLabel];
    
    BADoubleLabelView *enddateLabel = [[BADoubleLabelView alloc] init];
    [enddateLabel setFrame:CGRectMake(10, opendateLabel.frame.origin.y+opendateLabel.frame.size.height+5, screenSize.width-20, 15)];
    [enddateLabel setLeftLabelText:@"END DATE" rightLabelText:@"ON GOING"];
    [leagueLabelView addSubview:enddateLabel];
    
    BADoubleLabelView *locationLabel = [[BADoubleLabelView alloc] init];
    [locationLabel setFrame:CGRectMake(10, enddateLabel.frame.origin.y+enddateLabel.frame.size.height+5, screenSize.width-20, 15)];
    [locationLabel setLeftLabelText:@"LOCATION" rightLabelText:@"KOREA"];
    [leagueLabelView addSubview:locationLabel];
    
    [[self view] addSubview:leagueLabelView];
}

- (void)setupLeagueGameView:(NSDictionary *)jsonObject {
    games = [jsonObject objectForKey:@"games"];
    BAGameTableViewController *gameTableVC = [[BAGameTableViewController alloc] initWithGames:games];
    [[gameTableVC tableView] setFrame:CGRectMake(0, leagueLabelView.frame.origin.y+leagueLabelView.frame.size.height+10, screenSize.width, screenSize.height - leagueLabelView.frame.size.height - 130)];
    [self addChildViewController:gameTableVC];
    [[self view] addSubview:[gameTableVC tableView]];
}

- (void)requestLeagueGameData {
    //Dummy Data!
    NSString *url = @"http://125.209.198.90/battleapp/games.php?lid=3";
    [BAHttpTask requestJSONObjectFromURL:[NSURL URLWithString:url] compeleteHandler:^(NSURLResponse *response, NSDictionary *jsonObject, NSError *connectionError) {
        [self performSelectorOnMainThread:@selector(setupLeagueGameView:) withObject:jsonObject waitUntilDone:NO];
    } asynchronous:YES];
}

@end
