//
//  PullViewController.m
//  Hied
//
//  Created by Kevin Kelly on 12/6/12.
//  Copyright (c) 2012 KK. All rights reserved.
//

#import "PullViewController.h"
#import "IIViewDeckController.h"
#import "ArticleViewController.h"
#import "DejalActivityView.h"
#import "ViewController.h"
#import "EGORefreshTableHeaderView.h"
#import "ScrollViewViewController.h"

@interface PullViewController ()

@end

@implementation PullViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @" ";
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    UIImage *settingsImage = [UIImage imageNamed:@"menu_button@2x.png"];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    backButton.frame = CGRectMake(280.0, 10.0, 29.0, 29.0);//////////
    backButton.frame = CGRectMake(280.0, 10.0, 51.0, 32.0);//////////
    [backButton setBackgroundImage:settingsImage forState:UIControlStateNormal];//////
//    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    backButton.frame = CGRectMake(0, 0, 51, 32);
    [backButton addTarget:self.viewDeckController action:@selector(toggleLeftView) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = customBarItem;
	
	if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
		view.delegate = self;
		[self.tableView addSubview:view];
		_refreshHeaderView = view;
//		[view release];
		
	}
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];

//////////////////////////////////////////////////////////////////////////////
//    self.title = @" ";
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Hieding!"];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURL *url = [NSURL URLWithString:@"http://hied.herokuapp.com/articles/published.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
//////////////////////////////////////////////////////////////////////////////

//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *devStateString = [defaults objectForKey:@"devState"];
//    NSLog(@"devstate = %@", devStateString);
}

//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
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
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
//    NSLog(@"- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response");
    data = [[NSMutableData alloc] init];
//    data = [[NSMutableArray alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)theData{
//    NSLog(@"- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)theData");
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
//////////////////////////////////////////////////////////////////////////////

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}


#pragma mark -
#pragma mark UITableViewDataSource

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 10;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 4;
//}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    static NSString *CellIdentifier = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//	// Configure the cell.
//    
//    return cell;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MainCell"];
    }
    cell.textLabel.text = [[news objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.detailTextLabel.text = [[news objectAtIndex:indexPath.row] objectForKey:@"published_on"];
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    ArticleViewController *articleViewController = [[ArticleViewController alloc] initWithNibName:@"ArticleViewController" bundle:nil];
//    articleViewController.title = [[news objectAtIndex:indexPath.row] objectForKey:@"title"];
//    articleViewController.newsArticle = [news objectAtIndex:indexPath.row];
//    [self.navigationController pushViewController:articleViewController animated:YES];
//    
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *devStateString = [defaults objectForKey:@"devState"];
//    NSLog(@"devstate = %@", devStateString);
    
    if ([[defaults objectForKey:@"devState"] intValue] == 0){
//        NSLog(@"should show the standard view");
        ArticleViewController *articleController = [[ArticleViewController alloc] initWithNibName:@"ArticleViewController" bundle:nil];
        articleController.title = [[news objectAtIndex:indexPath.row] objectForKey:@"title"];
        articleController.newsArticle = [news objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:articleController animated:YES];
    }
    else{
//        NSLog(@"should show the scrollView");
        ScrollViewViewController *scrollController = [[ScrollViewViewController alloc] initWithNibName:@"ScrollViewViewController" bundle:nil];
        scrollController.title = [[news objectAtIndex:indexPath.row] objectForKey:@"title"];
        scrollController.newsArticle = [news objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:scrollController animated:YES];
    }
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//	
//	return [NSString stringWithFormat:@"Section %i", section];
//	
//}


#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
//    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Hieding!"];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;

    NSURL *url = [NSURL URLWithString:@"http://hied.herokuapp.com/articles/published.json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
//    news = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//	[self.tableView reloadData];
}

- (void)doneLoadingTableViewData{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    news = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    [self.tableView reloadData];
//    [DejalBezelActivityView removeViewAnimated:YES];

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
//    news = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
//	return nil;
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
//    [super dealloc];
}


@end

