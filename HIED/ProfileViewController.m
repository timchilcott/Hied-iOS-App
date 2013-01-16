//
//  ProfileViewController.m
//  Hied
//
//  Created by Kevin Kelly on 12/6/12.
//  Copyright (c) 2012 KK. All rights reserved.
//

#import "ProfileViewController.h"
#import "ViewController.h"
#import "IIViewDeckController.h"
#import "WebViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//    UIImage *settingsImage = [UIImage imageNamed:@"menu_button@2x.png"];
//    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    backButton.frame = CGRectMake(280.0, 10.0, 29.0, 29.0);//////////
//    [backButton setBackgroundImage:settingsImage forState:UIControlStateNormal];//////
//    //    [backButton setTitle:@"Back" forState:UIControlStateNormal];
//    backButton.frame = CGRectMake(0, 0, 50, 30);
//    [backButton addTarget:self.viewDeckController action:@selector(toggleLeftView) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//    self.navigationItem.leftBarButtonItem = customBarItem;
    
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    WebViewController *webController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
//    webController.webURL = @"http://www.google.com";
    webController.webURL = @"http://hied.io/f/161";
    [self.navigationController pushViewController:webController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
