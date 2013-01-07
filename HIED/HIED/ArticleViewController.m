//
//  ArticleViewController.m
//  Hied_alpha
//
//  Created by Kevin Kelly on 11/11/12.
//  Copyright (c) 2012 KK. All rights reserved.
//

#import "ArticleViewController.h"
#import <QuartzCore/QuartzCore.h>

#import "PullViewController.h"
#import "IIViewDeckController.h"
//#import "ArticleViewController.h"
#import "DejalActivityView.h"
#import "ViewController.h"
#import "EGORefreshTableHeaderView.h"


@interface ArticleViewController ()

@end

@implementation ArticleViewController
@synthesize newsArticle;

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
    self.title = @" ";
    [self.navigationController setNavigationBarHidden:NO animated:NO];

    UIImage *settingsImage = [UIImage imageNamed:@"back_button@2x.png"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    backButton.frame = CGRectMake(280.0, 10.0, 29.0, 29.0);
    backButton.frame = CGRectMake(280.0, 10.0, 51.0, 32.0);//////////
    [backButton setBackgroundImage:settingsImage forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 0, 51, 32);
    [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = customBarItem;
    
    descTextView.font = [UIFont fontWithName:@"palatino" size:14];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideShowNavigation)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    titleLabel.text = [newsArticle objectForKey:@"title"];
    timeLabel.text = [newsArticle objectForKey:@"published_on"];
    NSString *authorString = [[NSString alloc] initWithFormat:@"by: %@", [newsArticle objectForKey:@"author"]];
    NSLog(@"%@", authorString);
    NSString *nAString = @"by: N/A";
    if ([authorString isEqualToString:nAString])
        authorLabel.text = @"by: unknown";
    else
        authorLabel.text = authorString;
    urlLabel.text = [newsArticle objectForKey:@"display_url"];
    topicLabel.text = [newsArticle objectForKey:@"topic"];

    NSArray *paragraphs = [[newsArticle objectForKey:@"text_blocks"] valueForKey:@"TextBlock"];
    NSArray *quotes = [[newsArticle objectForKey:@"text_blocks"] valueForKey:@"QuoteBlock" ];

    NSMutableArray *joined = [[NSMutableArray alloc] init];
    for (int i = 0; i < paragraphs.count; i++){
        if ([paragraphs objectAtIndex:i] != [NSNull null]){
            [joined addObject:[paragraphs objectAtIndex:i]];
        }
        else if ([quotes objectAtIndex:i] != [NSNull null]){
            [joined addObject:[quotes objectAtIndex:i]];
        }
        else{
            [joined addObject:@"*****ERROR: NOTIFY KEVIN IF YOU SEE THIS"];
        }
    }
    
//    NSLog(@"%@", [joined componentsJoinedByString:@"\n\n"]);

    descTextView.text = [joined componentsJoinedByString:@"\n\n"];
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) hideShowNavigation
{
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)goToSource:(id)sender {
    NSLog(@"Source page!");
}

- (IBAction)goToAuthor:(id)sender {
    NSLog(@"Author page!");
}
@end
