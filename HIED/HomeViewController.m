//  HomeScrollViewController.m
//  Hied
//
//  Created by Kevin Kelly on 12/30/12.
//  Copyright (c) 2012 KK. All rights reserved.
//

#import "HomeViewController.h"
#import "LibraryViewController.h"
#import "IIViewDeckController.h"
//#import "ArticleViewController.h"
#import "DejalActivityView.h"
#import "ViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "ScrollViewViewController.h"
#import "HomeTableCell.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

//@synthesize numRows;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @" ";
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
//    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"papered_bg@2x.png"]];
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:
                                     [UIImage imageNamed:@"papered_bg@2x.png"]];
    
    UIImage *settingsImage = [UIImage imageNamed:@"menu_button@2x.png"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(280.0, 10.0, 51.0, 32.0);
    [backButton setBackgroundImage:settingsImage forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 0, 51, 32);
    [backButton addTarget:self.viewDeckController action:@selector(toggleLeftView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = customBarItem;
	
	if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
		view.delegate = self;
		[self.tableView addSubview:view];
		_refreshHeaderView = view;
	}
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Loading"];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURL *url = [NSURL URLWithString:@"http://hied.herokuapp.com/articles/published.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSString *devStateString = [defaults objectForKey:@"devState"];
    //    NSLog(@"devstate = %@", devStateString);
}

-(void)  tableView:(UITableView*)tableView
   willDisplayCell:(UITableViewCell*)cell
 forRowAtIndexPath:(NSIndexPath*)indexPath;
{
    static UIImage* bgImage = nil;
    if (bgImage == nil) {
        bgImage = [UIImage imageNamed:@"background_light_grey_noline@2x.png"];
    }
//    cell.backgroundColor = [UIColor clearColor];
//    cell.textLabel.backgroundColor = [UIColor clearColor];
//    cell.textLabel.backgroundColor = [UIColor whiteColor];
//    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
//    cell.detailTextLabel.backgroundColor = [UIColor whiteColor];
//    cell.backgroundView = [[UIImageView alloc] initWithImage:bgImage];
//    cell.backgroundView = [[UIColor]]
    
    //    static UIImage* bgImage = nil;
    //    if (bgImage == nil) {
    //        bgImage = [UIImage imageNamed:@"menu_bg@2x.png"];
    //    }
    ////    cell.backgroundView = [[UIImageView alloc] initWithImage:bgImage];
    ////    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:bgImage]];
    
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    static UIImage* sbgImage = nil;
    if (sbgImage == nil) {
        sbgImage = [UIImage imageNamed:@"button_selected_bg@2x.png"];
    }
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:bgImage];
//    cell.selectedBackgroundView = [[]
    
//    cell.selectedBackgroundView = [UIColor clearColor];
    //    cell.textLabel.backgroundColor = [UIColor clearColor];
    //    cell.textLabel.textColor = [UIColor lightGrayColor];
    //    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)theData{
    [data appendData:theData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    news = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    [self.tableView reloadData];
    
    //activity animation
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [DejalBezelActivityView removeViewAnimated:YES];
    
    
    
    
//    [news enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
//        
//    }
    
    
    
    
    
//    int occurrences = 0;
//    for(NSString *string in topicToSection){
//        occurrences += ([string isEqualToString:@"Ernest Hemingway"]?1:0); //certain object is @"Apple"
//    }
//    NSLog(@"ernest hemingway =  %d", occurrences);
//
//    occurrences = 0;
//    for(NSString *string in topicToSection){
//        occurrences += ([string isEqualToString:@"Easter Island"]?1:0); //certain object is @"Apple"
//    }
//    NSLog(@"easter island =  %d", occurrences);
//
//    occurrences = 0;
//    for(NSString *string in topicToSection){
//        occurrences += ([string isEqualToString:@"Founding Fathers"]?1:0); //certain object is @"Apple"
//    }
//    NSLog(@"founding fathers =  %d", occurrences);

    
    
    
//    int counter = 0;
//    for (int i = 0; i < topicToSection.count; i++){
//        if ([topicToSection objectAtIndex:i] isEqualToString:<#(NSString *)#>)
//    }
    
    //    topicToSection = [[NSMutableArray alloc] init];
    //    for (int i = 0; i < 3; i++)
    //    {
    //        [topicToSection insertObject:[NSNumber numberWithUnsignedInt:i] atIndex:i];
    ////        NSLog(@"%i",i);
    //    }
    //
    //    NSLog(@"%@",[topicToSection objectAtIndex:1]);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [DejalBezelActivityView removeViewAnimated:YES];
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The download could not complete -- please make sure you have Internets" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [errorView show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (int)numberOfSectionsInTableView:(UITableView *)tableView{
//    lastTempTopic = @"";
//    numTopics = 0;
//    topicList = [[NSMutableArray alloc] init];
////    topicToSection = [[NSMutableArray alloc] init];
//    for (int i=0; i<news.count; i++) {
//        newsArticle = [news objectAtIndex:i];
//        tempTopic = [newsArticle objectForKey:@"topic"];
//        if ([tempTopic isEqualToString:lastTempTopic])
//        {
//        }
//        else{
////            [topicToSection addObject:[NSNumber numberWithUnsignedInt:numTopics]];
////            [topicToSection insertObject:tempTopic atIndex:numTopics];
//            numTopics++;
//    }
//        lastTempTopic = tempTopic;
//    }
////    [topicToSection insertObject:@"nil" atIndex:3];
////    NSLog(@"numtopics = %i",numTopics);
////    NSLog(@"topicToSection = %@",[topicToSection description]);
////    NSLog(@"blah = %@", [[topicToSection objectAtIndex:numTopics] description]);
//////    [[myArray objectAtIndex:0] objectAtIndex:0];
//////    NSString *myString = [topicToSection objectAtIndex:0];
////    NSString *myString = [topicToSection description];
//////    myString = [myString stringByReplacingOccurrencesOfString:@"(\n" withString:@""];
//////    myString = [myString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
//////    myString = [myString stringByReplacingOccurrencesOfString:@" " withString:@""];
////    NSArray *stringComponents = [myString componentsSeparatedByString:@","];
////    NSString *myFinalString = [stringComponents objectAtIndex:2];
////    NSLog(@"%@", myFinalString);
//    
//
//    
//    return numTopics;
    return 1;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
////    NSLog(@"%i", [newsArticle count]);
////    return [newsArticle count];
////    return [news count];
//    
////    NSLog(@"***%@",[numRowsPerm description]);
////    return 1;
//    
//    
//    lastTempTopic = @"";
//    numTopics = 0;
//    topicList = [[NSMutableArray alloc] init];
//    topicToSection = [[NSMutableArray alloc] init];
//    numRows = [[NSMutableArray alloc] init];
//    //    int j = 0;
//    for (int i=0; i<news.count; i++) {
//        //        j++;
//        newsArticle = [news objectAtIndex:i];
//        tempTopic = [newsArticle objectForKey:@"topic"];
//        //        NSLog(@"===%@", tempTopic);
//        //        NSLog(@"%@ x %i", tempTopic, j);
//        
//        if ([tempTopic isEqualToString:lastTempTopic])
//        {
//            //            j++;
//        }
//        else{
//            numTopics++;
//            //            j = 0;
//            //            [topicToSection addObject:[NSNumber numberWithUnsignedInt:numTopics]];
//            //            NSLog(@"%@, %i", tempTopic, i);
//            //            [topicToSection insertObject:tempTopic atIndex:i];
//            //            [topicToSection addObject:tempTopic];
//        }
//        lastTempTopic = tempTopic;
//        //        [topicToSection insertObject:[NSNumber numberWithUnsignedInt:i] atIndex:i];
//        [topicToSection insertObject:tempTopic atIndex:i];
//    }
//    
//    int j = 0;
//    for (int i = 0; i < topicToSection.count; i++){
//        if (i > 0 && [[topicToSection objectAtIndex:i] isEqualToString:[topicToSection objectAtIndex:(i-1)]]) {
//        }
//        else{
//            //            NSLog(@"%@, %i", [topicToSection objectAtIndex:i], i);
//            int occurrences = 0;
//            for(NSString *string in topicToSection){
//                occurrences += ([string isEqualToString:[topicToSection objectAtIndex:i]]?1:0); //certain object is @"Apple"
//            }
//            NSLog(@"topic occurs %d times", occurrences);
//            [numRows insertObject:[NSNumber numberWithInt:occurrences] atIndex:j];
//            j++;
//        }
//    }
//    NSLog(@"%@", [numRows objectAtIndex:section]);
////    numRowsPerm = [numRows mutableCopy];
//    
//    int secNum = [[numRows objectAtIndex:section] intValue];
//    
//    if (secNum == 2)
//        return 29;
//    if (secNum == 0)
//        return 31;
//    else
//        return 17;
////    return secNum;//[numRows objectAtIndex:0];
//    
//    //    NSLog(@"numtopics = %i, numArticles = %i",numTopics, [news count]);
//    //    NSLog(@"%@",[topicToSection description]);
    return [news count];
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
////    return [[news objectAtIndex:section] objectForKey:@"topic"];
//    
//    return [newsArticle objectForKey:@"topic"];
//    
////    NSString *myString = [topicToSection description];
////    myString = [myString stringByReplacingOccurrencesOfString:@"(\n" withString:@""];
////    myString = [myString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
////    myString = [myString stringByReplacingOccurrencesOfString:@" " withString:@""];
////    NSArray *stringComponents = [myString componentsSeparatedByString:@","];
////    NSString *myFinalString = [stringComponents objectAtIndex:section];
////    NSLog(@"%@", myFinalString);
////    
////    return myFinalString;
//}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *sectionTitle = [[newsArticle objectForKey:@"topic"] uppercaseString];//[self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return nil;
    }
    
    // Create label with section title
    UILabel *label = [[UILabel alloc] init];
//    label.frame = CGRectMake(20, 6, 300, 30);
    label.frame = CGRectMake(0, 0, 320, 43);
//    label.backgroundColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"topic_bg.png"]];
//    label.textColor = [UIColor colorWithHue:(136.0/360.0)  // Slightly bluish green
//                                 saturation:1.0
//                                 brightness:0.60
//                                      alpha:1.0];
//    label.textColor = [UIColor colorWithRed:21 green:21 blue:21 alpha:0];
    label.textColor = [UIColor lightGrayColor];
//    label.shadowColor = [UIColor whiteColor];
//    label.shadowOffset = CGSizeMake(0.0, 1.0);
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = UITextAlignmentCenter;
    
    
    label.text = sectionTitle;
    
    // Create header view and add label as a subview
    
    // you could also just return the label (instead of making a new view and adding the label as subview. With the view you have more flexibility to make a background color or different paddings
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 430/*SectionHeaderHeight*/)];
//    [view autorelease];
    
    [view addSubview:label];
    
    return view;
//    return label;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

#pragma mark -
#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"HomeTableCell";
    
    HomeTableCell *cell = (HomeTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"HomeTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    newsArticle = [news objectAtIndex:indexPath.row];
    
//    cell.backgroundColor = [UIColor blueColor];
    
//    cell.timeLabel.text = [newsArticle objectForKey:@"published_on"];
//    cell.timeLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"date_bg@2x.png"]];
    NSString *authorString = [[NSString alloc] initWithFormat:@"by: %@", [newsArticle objectForKey:@"author"]];
    //    NSLog(@"%@", authorString);
    NSString *nAString = @"by: N/A";
    if ([authorString isEqualToString:nAString])
        cell.authorLabel.text = @"by: unavailable";
    else
        cell.authorLabel.text = authorString;
    cell.urlLabel.text = [newsArticle objectForKey:@"display_url"];
//    cell.topicLabel.text = [newsArticle objectForKey:@"topic"];
//    cell.topicLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"topic_bg@2x.png"]];
//    cell.topicLabel.layer.cornerRadius = 3;
    
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
    
//    cell.articleBG.frame = CGRectMake(0,0,300,800);
    
    cell.timeLabel.text = [newsArticle objectForKey:@"published_on"];
    cell.timeLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"date_bg@2x.png"]];

    cell.titleLabel.text = [newsArticle objectForKey:@"title"];
    cell.titleLabel.font = [UIFont fontWithName:@"Palatino-Bold" size:22];

    cell.articleLabel.text = [joined componentsJoinedByString:@"\n\n"];
//    cell.articleLabel.text = @"blah";//[joined componentsJoinedByString:@"\n\n"];
    cell.articleLabel.font = [UIFont fontWithName:@"palatino" size:14];
    
    cell.starCSLabel.text = @"Star • Comment • Share";
    cell.starCSLabel.font = [UIFont fontWithName:@"Palatino-Bold" size:10];
    
    cell.sponsorLabel.text = @"BearRabbit";
    cell.sponsorLabel.font = [UIFont fontWithName:@"Palatino-Bold" size:10];
    
    cell.sponsoredBy.text = @"Sponsored by:";
    cell.sponsoredBy.font = [UIFont fontWithName:@"palatino" size:10];
    
//    cell.starLabel.text = @"15";
//    cell.starLabel.font = [UIFont fontWithName:@"Palatino-Bold" size:10];
//    
//    cell.smallCommentLabel.text = @"222";
//    cell.smallCommentLabel.font = [UIFont fontWithName:@"Palatino-Bold" size:10];
    
    // TIME
    CGSize size = [cell.timeLabel.text sizeWithFont:cell.timeLabel.font constrainedToSize:CGSizeMake(cell.timeLabel.frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
//    cell.timeLabel.frame = CGRectMake(0,3,300,30);
    cell.timeLabel.frame = CGRectMake(cell.frame.origin.x,cell.frame.origin.y+1.5,300,30);
    
    // AUTHOR
    size = [cell.authorLabel.text sizeWithFont:cell.authorLabel.font constrainedToSize:CGSizeMake(cell.authorLabel.frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
//    cell.authorLabel.frame =   CGRectMake(0,60,300,30);//CGRectMake(cell.authorLabel.frame.origin.x,cell.timeLabel.frame.origin.y+20,cell.timeLabel.frame.size.width,size.height);
    cell.authorLabel.frame =   CGRectMake(cell.authorLabel.frame.origin.x,cell.frame.origin.y+60,cell.authorLabel.frame.size.width,size.height);
    
    // URL
    size = [cell.urlLabel.text sizeWithFont:cell.urlLabel.font constrainedToSize:CGSizeMake(cell.urlLabel.frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
    cell.urlLabel.frame =   CGRectMake(cell.urlLabel.frame.origin.x,cell.authorLabel.frame.origin.y+20,cell.authorLabel.frame.size.width,size.height);
    
    // TITLE
    size = [cell.titleLabel.text sizeWithFont:cell.titleLabel.font constrainedToSize:CGSizeMake(cell.titleLabel.frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
    cell.titleLabel.frame =   CGRectMake(cell.titleLabel.frame.origin.x,cell.urlLabel.frame.origin.y+30,290/*cell.urlLabel.frame.size.width*/,size.height);
    
    // ARTICLE
    size = [cell.articleLabel.text sizeWithFont:cell.articleLabel.font constrainedToSize:CGSizeMake(cell.articleLabel.frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
    cell.articleLabel.frame =   CGRectMake(cell.articleLabel.frame.origin.x,cell.titleLabel.frame.origin.y+cell.titleLabel.frame.size.height+10,cell.articleLabel.frame.size.width,size.height);
    
    // WHITE BACKGROUND
    cell.articleBG.frame = CGRectMake(0,40,300,cell.timeLabel.frame.size.height+cell.authorLabel.frame.size.height+cell.urlLabel.frame.size.height+cell.titleLabel.frame.size.height+cell.articleLabel.frame.size.height+90);
    
    // STAR COMMENT SHARE
    size = [cell.starCSLabel.text sizeWithFont:cell.starCSLabel.font constrainedToSize:CGSizeMake(cell.starCSLabel.frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
    cell.starCSLabel.frame =   CGRectMake(cell.starCSLabel.frame.origin.x,cell.articleLabel.frame.origin.y+cell.articleLabel.frame.size.height+40,cell.starCSLabel.frame.size.width,30/*size.height*/);
    
//    // STAR LABEL
//    size = [cell.starLabel.text sizeWithFont:cell.starLabel.font constrainedToSize:CGSizeMake(cell.starLabel.frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
//    cell.starLabel.frame =   CGRectMake(cell.starLabel.frame.origin.x,cell.articleLabel.frame.origin.y+cell.articleLabel.frame.size.height+20,cell.starLabel.frame.size.width,size.height);
    
//    // COMMENT LABEL
//    size = [cell.smallCommentLabel.text sizeWithFont:cell.smallCommentLabel.font constrainedToSize:CGSizeMake(cell.smallCommentLabel.frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
//    cell.smallCommentLabel.frame =   CGRectMake(cell.smallCommentLabel.frame.origin.x,cell.articleLabel.frame.origin.y+cell.articleLabel.frame.size.height+20,cell.smallCommentLabel.frame.size.width,size.height);
    
    // Sponsor Label
    size = [cell.sponsorLabel.text sizeWithFont:cell.sponsorLabel.font constrainedToSize:CGSizeMake(cell.sponsorLabel.frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
    cell.sponsorLabel.frame =   CGRectMake(cell.sponsorLabel.frame.origin.x,cell.articleLabel.frame.origin.y+cell.articleLabel.frame.size.height+10,cell.sponsorLabel.frame.size.width,30/*size.height*//*cell.sponsorLabel.frame.origin.x,cell.starCSLabel.frame.origin.y+cell.starCSLabel.frame.size.height+10,cell.sponsorLabel.frame.size.width,size.height*/);
    
    // Sponsor Ad
    size = [cell.sponsoredBy.text sizeWithFont:cell.sponsoredBy.font constrainedToSize:CGSizeMake(cell.sponsoredBy.frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
    cell.sponsoredBy.frame =   CGRectMake(cell.sponsoredBy.frame.origin.x,cell.articleLabel.frame.origin.y+cell.articleLabel.frame.size.height+10,cell.sponsoredBy.frame.size.width,30/*cell.sponsoredBy.frame.origin.x,cell.starCSLabel.frame.origin.y+cell.starCSLabel.frame.size.height+10,cell.sponsoredBy.frame.size.width,size.height*/);
    
//    cell.comments.frame = CGRectMake(cell.comments.frame.origin.x,cell.articleLabel.frame.origin.y+cell.articleLabel.frame.size.height+10,31,31);
//
    cell.star.frame = CGRectMake(cell.star.frame.origin.x,cell.articleLabel.frame.origin.y+cell.articleLabel.frame.size.height+18,15,13);
    
    cell.smallComment.frame = CGRectMake(cell.smallComment.frame.origin.x,cell.articleLabel.frame.origin.y+cell.articleLabel.frame.size.height+18,15,13);
    
//    cell.sponsor.frame = CGRectMake(cell.sponsor.frame.origin.x,cell.comments.frame.origin.y+cell.comments.frame.size.height+10,31,31);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
}
//-(void)  tableView:(UITableView*)tableView
//   willDisplayCell:(UITableViewCell*)cell
// forRowAtIndexPath:(NSIndexPath*)indexPath;
//{
//    //    static UIImage* bgImage = nil;
//    //    if (bgImage == nil) {
//    //        bgImage = [UIImage imageNamed:@"menu_bg@2x.png"];
//    //    }
//    ////    cell.backgroundView = [[UIImageView alloc] initWithImage:bgImage];
//    ////    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    //    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:bgImage]];
//    
//    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    static UIImage* bgImage = nil;
//    if (bgImage == nil) {
//        bgImage = [UIImage imageNamed:@"button_selected_bg@2x.png"];
//    }
//    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:bgImage];
//    //    cell.textLabel.backgroundColor = [UIColor clearColor];
//    //    cell.textLabel.textColor = [UIColor lightGrayColor];
//    //    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
//}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	//  should be calling your tableviews data source model to reload
	_reloading = YES;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
//    NSURL *url = [NSURL URLWithString:@"http://hied.herokuapp.com/articles/published.json"];
    NSURL *url = [NSURL URLWithString:@"http://hied.io/articles/published.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)doneLoadingTableViewData{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    news = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
////    newsDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//    for (int i=0; i<news.count; i++) {
////        newsArticle = [news objectAtIndex:i];
////        tempTopic = [newsArticle objectForKey:@"topic"];
////        if ([tempTopic isEqualToString:lastTempTopic])
////        {
////        }
////        else
////            numTopics++;
////        lastTempTopic = tempTopic;
//    }
////    NSLog(@"%@",[newsDic objectForKey:@"topic"]);
////    NSLog(@"%@",newsDic);
    [self.tableView reloadData];

	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
	
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	return _reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	return [NSDate date]; // should return date data source was last changed
}


#pragma mark -
#pragma mark Memory Management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	_refreshHeaderView=nil;
}

- (void)dealloc {
	_refreshHeaderView = nil;
}

- (CGFloat)measureTextHeight:(NSString*)text fontName:(NSString*)fontName fontSize:(CGFloat)fontSize constrainedToSize:(CGSize)constrainedToSize {
    CGSize mTempSize = [text sizeWithFont:[UIFont fontWithName:fontName size:fontSize] constrainedToSize:constrainedToSize lineBreakMode:UILineBreakModeWordWrap];
    return mTempSize.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    newsArticle = [news objectAtIndex:indexPath.row];
    
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
    
    int tempHeight = 0;
    
    tempHeight = [self measureTextHeight:[newsArticle objectForKey:@"title"] fontName:@"Palatino-Bold" fontSize:22 constrainedToSize:CGSizeMake(278, 1000000)];
    
    tempHeight += [self measureTextHeight:[joined componentsJoinedByString:@"\n\n"] fontName:@"palatino" fontSize:14 constrainedToSize:CGSizeMake(278, 1000000)];
    
    tempHeight += 230;
    
    cellHeight = tempHeight;
    
//    NSLog(@"%f", cellHeight);
    return cellHeight;
}

@end
