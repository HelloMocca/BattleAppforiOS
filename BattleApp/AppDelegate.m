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
    UIGraphicsBeginImageContext(self.window.frame.size);
    [[UIImage imageNamed:@"bg1242x2208"] drawInRect:self.window.bounds];
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.window.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
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
    UIImage *transparentBackground;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), NO, tabBarController.tabBar.layer.contentsScale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBFillColor(context, 14/255.0f, 14/255.0f, 14/255.0f, 0.8f);
    UIRectFill(CGRectMake(0, 0, 1, 1));
    transparentBackground = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [[tabBarController tabBar] setBackgroundImage:transparentBackground];
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
        NSLog(@"SKIP: %@", [notif alertBody]);
        return;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[notif alertTitle] message:[notif alertBody] delegate:self cancelButtonTitle:@"Show" otherButtonTitles:@"Cancel",nil];
    [alert show];
}

- (BOOL)isLiveViewControllerAlreadyLoaded {
    id currNavigationController = [[[self window] rootViewController] presentedViewController];
    id currViewController = [[currNavigationController viewControllers] lastObject];
    return ([currViewController isKindOfClass:[LiveViewController class]]) ? YES : NO;
}

#pragma mark - AlertView Event delegate
- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self presentLiveViewcontroller];
    }
}

- (void)presentLiveViewcontroller {
    UINavigationController *viewcontroller = (UINavigationController *)[tabBarController selectedViewController];
    LiveViewController *onLiveViewController = [[LiveViewController alloc] initWithLink:@"https://www.youtube.com/user/WCSStarCraft"];
    BANavigationController *liveViewNavigationController = [[BANavigationController alloc] initWithRootViewController:onLiveViewController title:@"TITLE"];
    [viewcontroller presentViewController:liveViewNavigationController animated:YES completion:nil];
}

@end
