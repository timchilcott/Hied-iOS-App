//
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


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @" ";
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
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
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Hieding!"];
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
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    cell.backgroundView = [[UIImageView alloc] initWithImage:bgImage];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)theData{
    [data appendData:theData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    news = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    [self.tableView reloadData];
    [DejalBezelActivityView removeViewAnimated:YES];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [DejalBezelActivityView removeViewAnimated:YES];
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The download could not complete -- please make sure you have Internets" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [errorView show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (int)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [news count];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

#pragma mark -
#pragma mark UITableViewDataSource
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 75;
//}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
//    
//    if(cell == nil){
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MainCell"];
//    }
//    cell.textLabel.text = [[news objectAtIndex:indexPath.row] objectForKey:@"title"];
////    cell.detailTextLabel.text = [[news objectAtIndex:indexPath.row] objectForKey:@"published_on"];
//    
//    NSArray *paragraphs = [[newsArticle objectForKey:@"text_blocks"] valueForKey:@"TextBlock"];
//    NSArray *quotes = [[newsArticle objectForKey:@"text_blocks"] valueForKey:@"QuoteBlock" ];
//    
//    NSMutableArray *joined = [[NSMutableArray alloc] init];
//    for (int i = 0; i < paragraphs.count; i++){
//        if ([paragraphs objectAtIndex:i] != [NSNull null]){
//            [joined addObject:[paragraphs objectAtIndex:i]];
//        }
//        else if ([quotes objectAtIndex:i] != [NSNull null]){
//            [joined addObject:[quotes objectAtIndex:i]];
//        }
//        else{
//            [joined addObject:@"*****ERROR: NOTIFY KEVIN IF YOU SEE THIS"];
//        }
//    }
//    
//    cell.detailTextLabel.text = [joined componentsJoinedByString:@"\n\n"];
//    cell.detailTextLabel.font = [UIFont fontWithName:@"palatino" size:14];
//    
////    cell.detailTextLabel.text = [[news objectAtIndex:indexPath.row] objectForKey:@"published_on"];
//    return cell;
//}

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
    
    cell.timeLabel.text = [newsArticle objectForKey:@"published_on"];
    NSString *authorString = [[NSString alloc] initWithFormat:@"by: %@", [newsArticle objectForKey:@"author"]];
    //    NSLog(@"%@", authorString);
    NSString *nAString = @"by: N/A";
    if ([authorString isEqualToString:nAString])
        cell.authorLabel.text = @"by: unavailable";
    else
        cell.authorLabel.text = authorString;
    cell.urlLabel.text = [newsArticle objectForKey:@"display_url"];
    cell.topicLabel.text = [newsArticle objectForKey:@"topic"];
    cell.topicLabel.layer.cornerRadius = 3;
    
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

    cell.titleLabel.text = [newsArticle objectForKey:@"title"];
    cell.titleLabel.font = [UIFont fontWithName:@"Palatino-Bold" size:22];

    cell.articleLabel.text = [joined componentsJoinedByString:@"\n\n"];
    cell.articleLabel.font = [UIFont fontWithName:@"palatino" size:14];
    
    cell.starCSLabel.text = @"Star • Comment • Share";
    cell.starCSLabel.font = [UIFont fontWithName:@"palatino" size:10];
    
    cell.sponsorLabel.text = @"Sponsored by: BearRabbit";
    cell.sponsorLabel.font = [UIFont fontWithName:@"palatino" size:10];
    
    cell.starCSLabel.text = @"15";
    cell.starCSLabel.font = [UIFont fontWithName:@"palatino" size:10];
    
    cell.smallCommentLabel.text = @"222";
    cell.smallCommentLabel.font = [UIFont fontWithName:@"palatino" size:10];

    CGSize size = [cell.titleLabel.text sizeWithFont:cell.titleLabel.font constrainedToSize:CGSizeMake(cell.titleLabel.frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
    cell.titleLabel.frame =   CGRectMake(cell.titleLabel.frame.origin.x,cell.titleLabel.frame.origin.y,cell.titleLabel.frame.size.width,size.height);
    
    size = [cell.articleLabel.text sizeWithFont:cell.articleLabel.font constrainedToSize:CGSizeMake(cell.articleLabel.frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
    cell.articleLabel.frame =   CGRectMake(cell.articleLabel.frame.origin.x,cell.titleLabel.frame.origin.y+cell.titleLabel.frame.size.height+10,cell.articleLabel.frame.size.width,size.height);
    
    size = [cell.starCSLabel.text sizeWithFont:cell.starCSLabel.font constrainedToSize:CGSizeMake(cell.starCSLabel.frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
    cell.starCSLabel.frame =   CGRectMake(cell.starCSLabel.frame.origin.x,cell.articleLabel.frame.origin.y+cell.articleLabel.frame.size.height+20,cell.starCSLabel.frame.size.width,size.height);
    
    size = [cell.starLabel.text sizeWithFont:cell.starLabel.font constrainedToSize:CGSizeMake(cell.starLabel.frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
    cell.starLabel.frame =   CGRectMake(cell.starLabel.frame.origin.x,cell.articleLabel.frame.origin.y+cell.articleLabel.frame.size.height+20,cell.starLabel.frame.size.width,size.height);
    
    size = [cell.smallCommentLabel.text sizeWithFont:cell.smallCommentLabel.font constrainedToSize:CGSizeMake(cell.smallCommentLabel.frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
    cell.smallCommentLabel.frame =   CGRectMake(cell.smallCommentLabel.frame.origin.x,cell.articleLabel.frame.origin.y+cell.articleLabel.frame.size.height+20,cell.smallCommentLabel.frame.size.width,size.height);
    
    size = [cell.sponsorLabel.text sizeWithFont:cell.sponsorLabel.font constrainedToSize:CGSizeMake(cell.sponsorLabel.frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
    cell.sponsorLabel.frame =   CGRectMake(cell.sponsorLabel.frame.origin.x,cell.starCSLabel.frame.origin.y+cell.starCSLabel.frame.size.height+30,cell.sponsorLabel.frame.size.width,size.height);
    
    cell.comments.frame = CGRectMake(cell.comments.frame.origin.x,cell.articleLabel.frame.origin.y+cell.articleLabel.frame.size.height+10,31,31);
    
    cell.star.frame = CGRectMake(cell.star.frame.origin.x,cell.articleLabel.frame.origin.y+cell.articleLabel.frame.size.height+18,15,13);
    
    cell.smallComment.frame = CGRectMake(cell.smallComment.frame.origin.x,cell.articleLabel.frame.origin.y+cell.articleLabel.frame.size.height+18,15,13);
    
    cell.sponsor.frame = CGRectMake(cell.sponsor.frame.origin.x,cell.comments.frame.origin.y+cell.comments.frame.size.height+10,31,31);
    
//    CGSize size = [cell.titleLabel.text sizeWithFont:cell.titleLabel.font constrainedToSize:CGSizeMake(cell.titleLabel.frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
//    cell.titleLabel.frame =   CGRectMake(cell.titleLabel.frame.origin.x,cell.titleLabel.frame.origin.y,cell.titleLabel.frame.size.width,size.height);
//    
//    size = [cell.articleLabel.text sizeWithFont:cell.articleLabel.font constrainedToSize:CGSizeMake(cell.articleLabel.frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
//    cell.articleLabel.frame =   CGRectMake(cell.articleLabel.frame.origin.x,cell.titleLabel.frame.origin.y+cell.titleLabel.frame.size.height+10,cell.articleLabel.frame.size.width,size.height);
//    
//    size = [cell.starCSLabel.text sizeWithFont:cell.starCSLabel.font constrainedToSize:CGSizeMake(cell.starCSLabel.frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
//    cell.starCSLabel.frame =   CGRectMake(cell.starCSLabel.frame.origin.x,cell.articleLabel.frame.origin.y+cell.articleLabel.frame.size.height+20,cell.starCSLabel.frame.size.width,size.height);
//    
//    size = [cell.starLabel.text sizeWithFont:cell.starLabel.font constrainedToSize:CGSizeMake(cell.starLabel.frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
//    cell.starLabel.frame =   CGRectMake(cell.starLabel.frame.origin.x,cell.articleLabel.frame.origin.y+cell.articleLabel.frame.size.height+20,cell.starLabel.frame.size.width,size.height);
//    
//    size = [cell.smallCommentLabel.text sizeWithFont:cell.smallCommentLabel.font constrainedToSize:CGSizeMake(cell.smallCommentLabel.frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
//    cell.smallCommentLabel.frame =   CGRectMake(cell.smallCommentLabel.frame.origin.x,cell.articleLabel.frame.origin.y+cell.articleLabel.frame.size.height+20,cell.smallCommentLabel.frame.size.width,size.height);
//    
//    size = [cell.sponsorLabel.text sizeWithFont:cell.sponsorLabel.font constrainedToSize:CGSizeMake(cell.sponsorLabel.frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap ];
//    cell.sponsorLabel.frame =   CGRectMake(cell.sponsorLabel.frame.origin.x,cell.starCSLabel.frame.origin.y+cell.starCSLabel.frame.size.height+30,cell.sponsorLabel.frame.size.width,size.height);
//    
//    cell.smallCommentButton.frame = CGRectMake(cell.smallCommentButton.frame.origin.x,cell.articleLabel.frame.origin.y+cell.articleLabel.frame.size.height+10,31,31);
//    
//    cell.smallStarButton.frame = CGRectMake(cell.smallStarButton.frame.origin.x,cell.articleLabel.frame.origin.y+cell.articleLabel.frame.size.height+18,15,13);
//    
//    cell.smallCommentLabel.frame = CGRectMake(cell.smallCommentLabel.frame.origin.x,cell.articleLabel.frame.origin.y+cell.articleLabel.frame.size.height+18,15,13);
//    
//    cell.sponsorLabel.frame = CGRectMake(cell.sponsorLabel.frame.origin.x,cell.smallCommentLabel.frame.origin.y+cell.smallCommentLabel.frame.size.height+10,31,31);
//
////    cellHeight = 0.0;
////    
////    for (UIView* view in cell.subviews)
////        cellHeight += view.frame.size.height;
////    
////    cellHeight -= 30.0;
////    
//////    NSLog(@"%f", cellHeight);
////
//////    [cellHeightArray addObject:cellHeight];
//////    [key release];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
    
//    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    //    NSString *devStateString = [defaults objectForKey:@"devState"];
//    //    NSLog(@"devstate = %@", devStateString);
//
//    //    NSLog(@"should show the scrollView");
//    ScrollViewViewController *scrollController = [[ScrollViewViewController alloc] initWithNibName:@"ScrollViewViewController" bundle:nil];
//    scrollController.title = [[news objectAtIndex:indexPath.row] objectForKey:@"title"];
//    [self.navigationController pushViewController:scrollController animated:YES];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	//  should be calling your tableviews data source model to reload
	_reloading = YES;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURL *url = [NSURL URLWithString:@"http://hied.herokuapp.com/articles/published.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)doneLoadingTableViewData{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    news = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
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
    
//    cell.timeLabel.text = [newsArticle objectForKey:@"published_on"];
//    NSString *authorString = [[NSString alloc] initWithFormat:@"by: %@", [newsArticle objectForKey:@"author"]];
//    NSLog(@"%@", authorString);
//    NSString *nAString = @"by: N/A";
//    if ([authorString isEqualToString:nAString])
//        cell.authorLabel.text = @"by: unavailable";
//    else
//        cell.authorLabel.text = authorString;
//    cell.urlLabel.text = [newsArticle objectForKey:@"display_url"];
//    cell.topicLabel.text = [newsArticle objectForKey:@"topic"];
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
    
//    cell.titleLabel.text = [newsArticle objectForKey:@"title"];
//    cell.titleLabel.font = [UIFont fontWithName:@"Palatino-Bold" size:22];
//    
//    cell.articleLabel.text = [joined componentsJoinedByString:@"\n\n"];
//    cell.articleLabel.font = [UIFont fontWithName:@"palatino" size:14];
//    
//    cell.starCSLabel.text = @"Star • Comment • Share";
//    cell.starCSLabel.font = [UIFont fontWithName:@"palatino" size:10];
//    
//    cell.sponsorLabel.text = @"Sponsored by: BearRabbit";
//    cell.sponsorLabel.font = [UIFont fontWithName:@"palatino" size:10];
//    
//    cell.starCountLabel.text = @"15";
//    cell.starCountLabel.font = [UIFont fontWithName:@"palatino" size:10];
//    
//    cell.commentCountLabel.text = @"222";
//    cell.commentCountLabel.font = [UIFont fontWithName:@"palatino" size:10];
    
    int tempHeight = 0;
    
    tempHeight = [self measureTextHeight:[newsArticle objectForKey:@"title"] fontName:@"Palatino-Bold" fontSize:22 constrainedToSize:CGSizeMake(295, 1000000)];
    
    tempHeight += [self measureTextHeight:[joined componentsJoinedByString:@"\n\n"] fontName:@"palatino" fontSize:14 constrainedToSize:CGSizeMake(295, 1000000)];
    
    tempHeight += 300;
    
    cellHeight = tempHeight;
    
    NSLog(@"%f", cellHeight);
    return cellHeight;
}

@end



//
//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//
//    // Uncomment the following line to preserve selection between presentations.
//    // self.clearsSelectionOnViewWillAppear = NO;
// 
//    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 100;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    // Configure the cell...
//    
//    cell.textLabel.text = [NSString stringWithFormat:@"I am cell %d", indexPath.row];
//    
//    return cell;
//}
//
///*
//// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}
//*/
//
///*
//// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }   
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
//}
//*/
//
///*
//// Override to support rearranging the table view.
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
//{
//}
//*/
//
///*
//// Override to support conditional rearranging of the table view.
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the item to be re-orderable.
//    return YES;
//}
//*/
//
//#pragma mark - Table view delegate
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Navigation logic may go here. Create and push another view controller.
//    /*
//     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
//     // ...
//     // Pass the selected object to the new view controller.
//     [self.navigationController pushViewController:detailViewController animated:YES];
//     */
//}
//
//@end
