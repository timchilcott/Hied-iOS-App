//
//  SettingsViewController.m
//  Hied
//
//  Created by Kevin Kelly on 12/6/12.
//  Copyright (c) 2012 KK. All rights reserved.
//

#import "SettingsViewController.h"
#import "ViewController.h"
#import "IIViewDeckController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *devStateString = [defaults objectForKey:@"devState"];
    NSLog(@"devstate = %@", devStateString);
    
    if ([[defaults objectForKey:@"devState"] intValue] == 1){
        [toggleDevMode setOn:YES animated:NO];
    }else{
        [toggleDevMode setOn:NO animated:NO];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImage *settingsImage = [UIImage imageNamed:@"menu_button@2x.png"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(280.0, 10.0, 29.0, 29.0);//////////
    [backButton setBackgroundImage:settingsImage forState:UIControlStateNormal];//////
    //    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 0, 50, 30);
    [backButton addTarget:self.viewDeckController action:@selector(toggleLeftView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = customBarItem;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (IBAction)toggleButtonPress:(id)sender {
    if(toggleDevMode.on){
        NSLog(@"on!");
//        NSString *devStateString = @"on";
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"devState"];
    }
    else{
        NSLog(@"off");
//        NSString *devStateString = @"off";
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"devState"];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
//    [defaults setObject:toggleDevMode forKey:@"devStateString"];
//    [defaults synchronize];
//    NSLog(@"Data saved");
}

@end
