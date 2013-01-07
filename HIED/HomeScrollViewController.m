//
//  HomeScrollViewController.m
//  Hied
//
//  Created by Kevin Kelly on 12/30/12.
//  Copyright (c) 2012 KK. All rights reserved.
//

#import "HomeScrollViewController.h"
#import "TableScrollViewController.h"
#import "IIViewDeckController.h"
#import "ArticleViewController.h"
#import "DejalActivityView.h"
#import "ViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "ScrollViewViewController.h"

@interface HomeScrollViewController ()

@end

@implementation HomeScrollViewController


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
        bgImage = [UIImage imageNamed:@"background_paper@2x.png"];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MainCell"];
    }
    cell.textLabel.text = [[news objectAtIndex:indexPath.row] objectForKey:@"title"];
//    cell.detailTextLabel.text = [[news objectAtIndex:indexPath.row] objectForKey:@"published_on"];
    
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
    
    cell.detailTextLabel.text = [joined componentsJoinedByString:@"\n\n"];
    cell.detailTextLabel.font = [UIFont fontWithName:@"palatino" size:14];
    
//    cell.detailTextLabel.text = [[news objectAtIndex:indexPath.row] objectForKey:@"published_on"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSString *devStateString = [defaults objectForKey:@"devState"];
    //    NSLog(@"devstate = %@", devStateString);
    
    //    NSLog(@"should show the scrollView");
    ScrollViewViewController *scrollController = [[ScrollViewViewController alloc] initWithNibName:@"ScrollViewViewController" bundle:nil];
    scrollController.title = [[news objectAtIndex:indexPath.row] objectForKey:@"title"];
    scrollController.newsArticle = [news objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:scrollController animated:YES];
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
