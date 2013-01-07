//
//  VDTAppDelegate.m
//  ViewDeckTest
//
//  Created by Kevin Kelly on 11/28/12.
//  Copyright (c) 2012 KK. All rights reserved.
//

#import "VDTAppDelegate.h"

#import "PullViewController.h"
#import "StarredViewController.h"
#import "ArticleViewController.h"
#import "IIViewDeckController.h"
#import "LeftViewController.h"
#import "ViewController.h"
#import "HomeViewController.h"
#import "LibraryViewController.h"
#import "ProfileViewController.h"
#import "SettingsViewController.h"
#import "TableScrollViewController.h"
#import "HomeScrollViewController.h"
//#import "ScrollViewViewController.h"

@implementation VDTAppDelegate

@synthesize window = _window;
@synthesize centerController = _centerController;
@synthesize homeController = _homeController;
@synthesize starredController = _starredController;
@synthesize libraryController = _libraryController;
@synthesize profileController = _profileController;
@synthesize settingsController = _settingsController;
@synthesize leftController = _leftController;
@synthesize imageController = _imageController;
//@synthesize scrollController = _scrollController;

+ (void)Generalstyle {
    //navigationbar
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"top_nav.png"] forBarMetrics:UIBarMetricsDefault];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[self class] Generalstyle];

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
    NSString *testValue = [[NSUserDefaults standardUserDefaults] stringForKey:@"devState"];
    if (!testValue) {
        // since no default values have been set, create them here
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"devState"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.leftController = [[LeftViewController alloc] initWithNibName:@"LeftViewController" bundle:nil];

//    PullViewController *centerController = [[PullViewController alloc] initWithNibName:@"PullViewController" bundle:nil];
//    self.centerController = [[UINavigationController alloc] initWithRootViewController:centerController];

    TableScrollViewController *centerController = [[TableScrollViewController alloc] initWithNibName:@"TableScrollViewController" bundle:nil];
    self.centerController = [[UINavigationController alloc] initWithRootViewController:centerController];
    
    IIViewDeckController* deckController =  [[IIViewDeckController alloc] initWithCenterViewController:self.centerController
                                                                                    leftViewController:self.leftController
                                                                                   rightViewController:nil];

    deckController.leftLedge = 215;
    
    self.window.rootViewController = deckController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (UIViewController*)controllerForIndex:(int)index {
    switch (index) {
        case 0:
        {
//            HomeViewController *centerController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
//            return [[UINavigationController alloc] initWithRootViewController:centerController];
            
            HomeScrollViewController *centerController = [[HomeScrollViewController alloc] initWithNibName:@"HomeScrollViewController" bundle:nil];
            return [[UINavigationController alloc] initWithRootViewController:centerController];
        }
        case 1:{
            StarredViewController *centerController = [[StarredViewController alloc] initWithNibName:@"StarredViewController" bundle:nil];
            return [[UINavigationController alloc] initWithRootViewController:centerController];
        }
        case 2:{
            TableScrollViewController *centerController = [[TableScrollViewController alloc] initWithNibName:@"TableScrollViewController" bundle:nil];
            return [[UINavigationController alloc] initWithRootViewController:centerController];
//            LibraryViewController *centerController = [[LibraryViewController alloc] initWithNibName:@"LibraryViewController" bundle:nil];
//            return [[UINavigationController alloc] initWithRootViewController:centerController];
        }
        case 3:{
            ProfileViewController *centerController = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
            return [[UINavigationController alloc] initWithRootViewController:centerController];
        }
        case 4:{
            SettingsViewController *centerController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
            return [[UINavigationController alloc] initWithRootViewController:centerController];
        }
    }
    
    return nil;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
