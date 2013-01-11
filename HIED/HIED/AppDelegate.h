//
//  VDTAppDelegate.h
//  ViewDeckTest
//
//  Created by Kevin Kelly on 11/28/12.
//  Copyright (c) 2012 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PullViewController;
@class TableScrollViewController;
@class ScrollViewViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//@property (retain, nonatomic) UIViewController *centerController;

@property (retain, nonatomic) UIViewController *centerController;
@property (retain, nonatomic) UIViewController *homeController;
@property (retain, nonatomic) UIViewController *starredController;
@property (retain, nonatomic) UIViewController *libraryController;
@property (retain, nonatomic) UIViewController *profileController;
@property (retain, nonatomic) UIViewController *settingsController;
@property (retain, nonatomic) UIViewController *leftController;
@property (retain, nonatomic) UIViewController *imageController;
@property (strong, nonatomic) PullViewController *pullViewController;
@property (nonatomic, retain) UIPopoverController* popoverController;
@property (strong, nonatomic) TableScrollViewController *tableScrollController;

//@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) ScrollViewViewController *scrollController;


- (UIViewController*)controllerForIndex:(int)index;

@end
