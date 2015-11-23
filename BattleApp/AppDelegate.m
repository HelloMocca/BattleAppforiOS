//
//  AppDelegate.m
//  BattleApp
//
//  Created by mocca on 2015. 10. 6..
//  Copyright (c) 2015년 mocca. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

{
    BATabBarController *tabBarController;
    NSMutableArray     *viewControllers;
}

#pragma mark - UIApplicationDelegate methods
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSLog(@"Application Launch");
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [window makeKeyAndVisible];
    [self setWindow:window];
    [self setupWindowStyle];
    [self createViewControllers];
    [self setupTabBarController];
    [[self window] setRootViewController:tabBarController];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"Application Resign Active");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[NotificationManager getNotificationManager] showNotifications];
    NSLog(@"Application Enter Background");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"Application Enter Foreground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"Application BecomeActive");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"Application Terminate");
}

#pragma mark - Setup methods
- (void)setupWindowStyle {
    [[self window] setBackgroundColor:[UIColor germanGreyColor]];
}

- (void)setupTabBarController {
    tabBarController = [[BATabBarController alloc] init];
    [tabBarController setViewControllers:viewControllers animated:YES];
    [self setupTabBar];
    [self setupTabBarStyle];
}

- (void)setupTabBar {
    NSArray *items = [[tabBarController tabBar] items];
    for (int i = 0; i < [viewControllers count]; i++) {
        UITabBarItem *item = [items objectAtIndex:i];
        UIViewController *viewController = [viewControllers objectAtIndex:i];
        [item setTitle:[viewController title]];
        [item setImage:[UIImage imageNamed:[viewController title]]];
    }
}

- (void)setupTabBarStyle {
    [[tabBarController tabBar] setBarStyle:UIBarStyleBlack];
    [[tabBarController tabBar] setTintColor:[UIColor dodgerBlueColor]];
}

- (void)createViewControllers {
    NSArray *viewControllerArray = [NSArray arrayWithObjects:
                                    @[@"News", [HomeViewController class]],
                                    @[@"Schedule",[ScheduleTableViewController class]],
                                    @[@"Player", [PlayerViewController class]],
                                    @[@"League", [LeagueViewController class]],
                                    @[@"Match", [MatchViewController class]],
                                    nil];
    viewControllers = [[NSMutableArray alloc] init];
    UINavigationController *navigationController;
    NSString *viewControllerTitle;
    Class viewControllerClass;
    for (NSArray *viewControllerInfo in viewControllerArray) {
        viewControllerTitle = viewControllerInfo[0];
        viewControllerClass = viewControllerInfo[1];
        navigationController = [[BANavigationController alloc] initWithRootViewController:[[viewControllerClass alloc] init] title:viewControllerTitle];
        [viewControllers addObject:navigationController];
    }
}

#pragma mark - LocalNotification handle methods
- (void)application:(UIApplication *)app didReceiveLocalNotification:(UILocalNotification *)notif {
    if ([self isLiveViewControllerAlreadyLoaded]) {
        NSLog(@"SKIP NOTY: %@", [notif alertBody]);
        return;
    }
    [self showAlarm:notif];
}

- (BOOL)isLiveViewControllerAlreadyLoaded {
    id currNavigationController = [[[self window] rootViewController] presentedViewController];
    id currViewController = [[currNavigationController viewControllers] lastObject];
    return ([currViewController isKindOfClass:[LiveViewController class]]) ? YES : NO;
}

- (void)showAlarm:(UILocalNotification *)notif {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:[notif alertTitle] message:[notif alertBody] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"SHOW" style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) { [self presentLiveViewcontroller]; }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    
    UINavigationController *currNavigationController = (UINavigationController *)[tabBarController selectedViewController];
    [currNavigationController presentViewController:alert animated:YES completion:nil];
}

- (void)presentLiveViewcontroller {
    UINavigationController *viewcontroller = (UINavigationController *)[tabBarController selectedViewController];
    LiveViewController *onLiveViewController = [[LiveViewController alloc] initWithLink:@"https://www.youtube.com/user/WCSStarCraft"];
    BANavigationController *liveViewNavigationController = [[BANavigationController alloc] initWithRootViewController:onLiveViewController title:@"TITLE"];
    [liveViewNavigationController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [viewcontroller presentViewController:liveViewNavigationController animated:YES completion:nil];
}

@end
