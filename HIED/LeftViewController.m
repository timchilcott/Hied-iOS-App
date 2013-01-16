//
//  LeftViewController.m
//  ViewDeckExample
//


#import "LeftViewController.h"
#import "IIViewDeckController.h"
#import "AppDelegate.h"

@implementation LeftViewController

@synthesize homeController;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
//    SOPatternBGTableViewController *background = [[SOPatternBGTableViewController alloc] init];
    
    [super viewDidLoad];
    
    self.tableView.scrollsToTop = NO;
    
    static UIImage* bgImage = nil;
    if (bgImage == nil) {
        bgImage = [UIImage imageNamed:@"menu_bg@2x.png"];
    }
    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:bgImage]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    menu = [NSArray arrayWithObjects:@"Home", @"Starred", @"Library", @"Profile", @"Settings", nil];
    imageMenu = [NSArray arrayWithObjects:@"menu_icon_home@2x.png", @"menu_icon_starred@2x.png", @"menu_icon_library@2x.png", @"menu_icon_profile@2x.png", @"menu_icon_settings@2x.png", nil];
//    NSLog(@"menu: %@, %@, %@, %@, %@", [menu objectAtIndex:0], [menu objectAtIndex:1], [menu objectAtIndex:2], [menu objectAtIndex:3], [menu objectAtIndex:4]);
    // Uncomment the following line to preserve selection between presentations.
//    self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
-(void)  tableView:(UITableView*)tableView
   willDisplayCell:(UITableViewCell*)cell
 forRowAtIndexPath:(NSIndexPath*)indexPath;
{
//    static UIImage* bgImage = nil;
//    if (bgImage == nil) {
//        bgImage = [UIImage imageNamed:@"menu_bg@2x.png"];
//    }
////    cell.backgroundView = [[UIImageView alloc] initWithImage:bgImage];
////    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    [self.tableView setBackgroundView:[[UIImageView alloc] initWithImage:bgImage]];

//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    static UIImage* bgImage = nil;
    if (bgImage == nil) {
        bgImage = [UIImage imageNamed:@"button_selected_bg@2x.png"];
    }
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:bgImage];
//    cell.textLabel.backgroundColor = [UIColor clearColor];
//    cell.textLabel.textColor = [UIColor lightGrayColor];
//    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
}
//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    return 3 + arc4random() % 10;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 3 + arc4random() % 50;
    return [menu count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return [NSString stringWithFormat:@"%d", section];
    return [NSString stringWithFormat:@""];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.textLabel.text = [menu objectAtIndex:indexPath.row];
//    cell.imageView.image = [UIImage imageNamed:@"menu_icon_home@2x.png"];
    cell.imageView.image = [UIImage imageNamed:[imageMenu objectAtIndex:indexPath.row]];
//    cell.imageView.frame = CGRectMake( 100, 10, 50, 50 ); // your positioning here
//    cell.imageView.
    UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, cell.frame.size.height-1, cell.frame.size.width, 1)];
    [separatorView setBackgroundColor:[UIColor clearColor]];
    [separatorView setAlpha:0.8f];
    [cell addSubview:separatorView];
    
    return cell;
}

//- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
//{
//    static NSString* CellIdentifier = @"Cell";
//    
//    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil)
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//    
//    cell.textLabel.text = @"I'm a UITableViewCell!";
//    cell.imageView.image = [UIImage imageNamed:@"MyReallyCoolImage.png"];
//    
//    return cell;
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
//        if ([controller.centerController isKindOfClass:[UINavigationController class]]) {
//            UITableViewController* cc = (UITableViewController*)((UINavigationController*)controller.centerController).topViewController;
//            //            cc.navigationItem.title = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
//            if ([cc respondsToSelector:@selector(tableView)]) {
//                [cc.tableView deselectRowAtIndexPath:[cc.tableView indexPathForSelectedRow] animated:NO];
//            }
//        }
//        [NSThread sleepForTimeInterval:(300+arc4random()%700)/1000000.0]; // mimic delay... not really necessary
//    }];


//    [self.viewDeckController closeLeftViewBouncing:^(IIViewDeckController *controller) {
//        self.viewDeckController.centerController = [tabbed controllerForIndex:indexPath.row];
//    }];
    [self.viewDeckController closeLeftViewAnimated:YES];
    self.viewDeckController.centerController = [tabbed controllerForIndex:indexPath.row];
//     {
////        self.viewDeckController.centerController = [tabbed controllerForIndex:indexPath.row];
//        return [self closeLeftViewAnimated:animated completion:nil];
//    }];
}

@end
