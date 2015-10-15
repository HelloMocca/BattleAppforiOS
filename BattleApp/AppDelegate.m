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
    UITabBarController *tabBarController;
    NSMutableArray     *viewControllers;
}

#pragma mark - UIApplicationDelegate methods
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [window makeKeyAndVisible];
    [self setWindow:window];
    [self setupWindowStyle];
    [self setupTabBarController];
    [[self window] setRootViewController:tabBarController];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
    tabBarController = [[UITabBarController alloc] init];
    [self createViewControllers];
    [tabBarController setViewControllers:viewControllers animated:"YES"];
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
    [[tabBarController tabBar] setTintColor:[UIColor colorWithRed:44/255.0f green:192/255.0f blue:254/255.0f alpha:1]];
}

- (void)createViewControllers {
    NSArray *viewControllerArray = [NSArray arrayWithObjects:
                                    @[@"Home", [HomeViewController class]],
                                    @[@"Player", [PlayerTableViewController class]],
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

@end
