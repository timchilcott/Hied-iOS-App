//
//  StarredViewController.m
//  Hied
//
//  Created by Kevin Kelly on 12/6/12.
//  Copyright (c) 2012 KK. All rights reserved.
//

#import "StarredViewController.h"
#import "IIViewDeckController.h"
#import "ArticleViewController.h"
#import "DejalActivityView.h"
#import "ViewController.h"
#import "EGORefreshTableHeaderView.h"

@interface StarredViewController ()

@end

@implementation StarredViewController

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

@end
