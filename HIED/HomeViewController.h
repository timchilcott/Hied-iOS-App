//
//  HomeScrollViewController.h
//  Hied
//
//  Created by Kevin Kelly on 12/30/12.
//  Copyright (c) 2012 KK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"

@interface HomeViewController : UITableViewController <EGORefreshTableHeaderDelegate, UITableViewDelegate, UITableViewDataSource>{
    
    //    IBOutlet UITableView *mainTableView;
    NSDictionary *newsArticle;
    
    NSArray *news;
//    NSMutableArray *cellHeightArray;
    //    NSMutableArray *data;
    NSMutableData *data;
    
	EGORefreshTableHeaderView *_refreshHeaderView;
    
	//  Reloading var should really be your tableviews datasource
	//  Putting it here for demo purposes
	BOOL _reloading;
    CGFloat cellHeight;
}

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end


//#import <UIKit/UIKit.h>
//#import "EGORefreshTableHeaderView.h"
//
//@interface TableScrollViewController : UITableViewController <EGORefreshTableHeaderDelegate, UITableViewDelegate, UITableViewDataSource>{
//    
//    //    IBOutlet UITableView *mainTableView;
//    
//    NSArray *news;
//    //    NSMutableArray *data;
//    NSMutableData *data;
//    
//	EGORefreshTableHeaderView *_refreshHeaderView;
//    
//	//  Reloading var should really be your tableviews datasource
//	//  Putting it here for demo purposes
//	BOOL _reloading;
//}
//
//- (void)reloadTableViewDataSource;
//- (void)doneLoadingTableViewData;
//
//@end
