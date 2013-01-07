//
//  ScrollViewViewController.m
//  ScrollView
//
//  Created by Neelam Roy on 4/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "ScrollViewViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "PullViewController.h"
#import "IIViewDeckController.h"
#import "DejalActivityView.h"
#import "ViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "WebViewController.h"


@implementation ScrollViewViewController
@synthesize mscrollview, newsArticle;
//webView;

// To load the Scroll View
- (void)viewWillAppear:(BOOL)animated {
   	[super viewWillAppear:animated];
//	
//	[[NSNotificationCenter defaultCenter] addObserver: self 
//											 selector: @selector(keyboardWasShown:)
//												 name: UIKeyboardDidShowNotification 
//											   object: nil];
//	
//    [[NSNotificationCenter defaultCenter] addObserver: self
//											 selector: @selector(keyboardWasHidden:)
//												 name: UIKeyboardDidHideNotification 
//											   object: nil];
}

- (void)viewDidLoad
{    
    [super viewDidLoad];
    self.title = @" ";
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    UIImage *settingsImage = [UIImage imageNamed:@"back_button@2x.png"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(280.0, 10.0, 51.0, 32.0);
    [backButton setBackgroundImage:settingsImage forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 0, 51, 32);
    [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = customBarItem;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideShowNavigation)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];

    timeLabel.text = [newsArticle objectForKey:@"published_on"];
    NSString *authorString = [[NSString alloc] initWithFormat:@"by: %@", [newsArticle objectForKey:@"author"]];
//    NSLog(@"%@", authorString);
    NSString *nAString = @"by: N/A";
    if ([authorString isEqualToString:nAString])
        authorLabel.text = @"by: unavailable";
    else
        authorLabel.text = authorString;
    urlLabel.text = [newsArticle objectForKey:@"display_url"];
    topicLabel.text = [newsArticle objectForKey:@"topic"];
    topicLabel.layer.cornerRadius = 3;
    
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

    titleLabel.text = [newsArticle objectForKey:@"title"];
    titleLabel.font = [UIFont fontWithName:@"palatino" size:22];

    articleLabel.text = [joined componentsJoinedByString:@"\n\n"];
    articleLabel.font = [UIFont fontWithName:@"palatino" size:14];

    starCSLabel.text = @"Star • Comment • Share";
    starCSLabel.font = [UIFont fontWithName:@"palatino" size:10];
    
    sponsorLabel.text = @"Sponsored by: BearRabbit";
    sponsorLabel.font = [UIFont fontWithName:@"palatino" size:10];
    
    starLabel.text = @"99999";
    starLabel.font = [UIFont fontWithName:@"palatino" size:10];
    
    smallCommentLabel.text = @"88888";
    smallCommentLabel.font = [UIFont fontWithName:@"palatino" size:10];
    
    CGSize size = [titleLabel.text sizeWithFont:titleLabel.font constrainedToSize:CGSizeMake(titleLabel.frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
    titleLabel.frame =   CGRectMake(titleLabel.frame.origin.x,titleLabel.frame.origin.y,titleLabel.frame.size.width,size.height);
    
    size = [articleLabel.text sizeWithFont:articleLabel.font constrainedToSize:CGSizeMake(articleLabel.frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
    articleLabel.frame =   CGRectMake(articleLabel.frame.origin.x,titleLabel.frame.origin.y+titleLabel.frame.size.height+10,articleLabel.frame.size.width,size.height);

    size = [starCSLabel.text sizeWithFont:starCSLabel.font constrainedToSize:CGSizeMake(starCSLabel.frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
    starCSLabel.frame =   CGRectMake(starCSLabel.frame.origin.x,articleLabel.frame.origin.y+articleLabel.frame.size.height+20,starCSLabel.frame.size.width,size.height);
    
    size = [starLabel.text sizeWithFont:starLabel.font constrainedToSize:CGSizeMake(starLabel.frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
    starLabel.frame =   CGRectMake(starLabel.frame.origin.x,articleLabel.frame.origin.y+articleLabel.frame.size.height+20,starLabel.frame.size.width,size.height);
    
    size = [smallCommentLabel.text sizeWithFont:smallCommentLabel.font constrainedToSize:CGSizeMake(smallCommentLabel.frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
    smallCommentLabel.frame =   CGRectMake(smallCommentLabel.frame.origin.x,articleLabel.frame.origin.y+articleLabel.frame.size.height+20,smallCommentLabel.frame.size.width,size.height);
    
    size = [sponsorLabel.text sizeWithFont:sponsorLabel.font constrainedToSize:CGSizeMake(sponsorLabel.frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
    sponsorLabel.frame =   CGRectMake(sponsorLabel.frame.origin.x,starCSLabel.frame.origin.y+starCSLabel.frame.size.height+30,sponsorLabel.frame.size.width,size.height);
    
    comments.frame = CGRectMake(comments.frame.origin.x,articleLabel.frame.origin.y+articleLabel.frame.size.height+10,31,31);

    star.frame = CGRectMake(star.frame.origin.x,articleLabel.frame.origin.y+articleLabel.frame.size.height+18,15,13);

    smallComment.frame = CGRectMake(smallComment.frame.origin.x,articleLabel.frame.origin.y+articleLabel.frame.size.height+18,15,13);
    
    sponsor.frame = CGRectMake(sponsor.frame.origin.x,comments.frame.origin.y+comments.frame.size.height+10,31,31);
    
    CGFloat scrollViewHeight = 0.0f;
    for (UIView* view in mscrollview.subviews)
        scrollViewHeight += view.frame.size.height;
    
    scrollViewHeight -= 30.0;
    
    [mscrollview setContentSize:(CGSizeMake(320, scrollViewHeight))];
}

- (void)goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) hideShowNavigation
{
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];

    if (!self.navigationController.navigationBarHidden){
        topicLabel.backgroundColor = [UIColor colorWithRed:61.0 green:43.0 blue:36.0 alpha:0.0];
//        topicLabel.hidden = NO;4r fv4c//        topicLabel2.hidden = NO;
//        [topicLabel setBackgroundColor:[UIColor ]]
    }else{
        topicLabel.backgroundColor = [UIColor colorWithRed:61.0 green:43.0 blue:36.0 alpha:1.0f];
//        topicLabel.hidden = YES;
//        topicLabel2.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    comments = nil;
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (IBAction)goToSource:(id)sender {
    WebViewController *webController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    webController.webURL = [newsArticle objectForKey:@"original_url"];
    [self.navigationController pushViewController:webController animated:YES];
}

- (IBAction)goToAuthor:(id)sender {
    NSString *googlePrefix = @"https://www.google.com/search?client=safari&rls=en&q=";
    NSString *googleSuffix = @"&ie=UTF-8&oe=UTF-8";
    NSString *authorPlus = @"";
    if ([[newsArticle objectForKey:@"author"] isEqualToString:@"N/A"]){
    }else
    {
        authorPlus = [newsArticle objectForKey:@"author"];
        authorPlus = [authorPlus stringByReplacingOccurrencesOfString:@" "
                                                           withString:@"+"];
    };
    NSString *topicPlus = [newsArticle objectForKey:@"topic"];
    topicPlus = [topicPlus stringByReplacingOccurrencesOfString:@" "
                                                       withString:@"+"];

    NSString *appendedAuthor = [googlePrefix stringByAppendingString:authorPlus];
    if ([authorPlus isEqualToString:@""]){
    }else
        appendedAuthor = [appendedAuthor stringByAppendingString:@"+"];
    appendedAuthor = [appendedAuthor stringByAppendingString:topicPlus];
    appendedAuthor = [appendedAuthor stringByAppendingString:googleSuffix];
    
    WebViewController *webController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    webController.webURL = appendedAuthor;
    [self.navigationController pushViewController:webController animated:YES];
}

- (IBAction)gotoComments:(id)sender{
    NSLog(@"commment for the lulz!");
}

- (IBAction)gotoSponsor:(id)sender{
    WebViewController *webController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    webController.webURL = @"http://bearrabbit.com";
    [self.navigationController pushViewController:webController animated:YES];
}

@end
