//
//  ScrollViewViewController.h
//  ScrollView
//
//  Created by Neelam Roy on 4/8/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollViewViewController : UIViewController {
    
    NSDictionary *newsArticle;
	
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *timeLabel;
    IBOutlet UILabel *urlLabel;
    IBOutlet UILabel *authorLabel;
    IBOutlet UILabel *topicLabel;
    IBOutlet UILabel *topicLabel2;
    IBOutlet UILabel *articleLabel;
    IBOutlet UILabel *starCSLabel;
    IBOutlet UILabel *sponsorLabel;
    IBOutlet UILabel *starLabel;
    IBOutlet UILabel *smallCommentLabel;
    IBOutlet UIButton *comments;
    IBOutlet UIButton *sponsor;
    IBOutlet UIButton *star;
    IBOutlet UIButton *smallComment;
	IBOutlet UIScrollView *mscrollview;
}

@property(nonatomic, retain)IBOutlet UIScrollView *mscrollview;
@property (nonatomic, copy) NSDictionary *newsArticle;
- (IBAction)goToSource:(id)sender;
- (IBAction)goToAuthor:(id)sender;
- (IBAction)gotoComments:(id)sender;
- (IBAction)gotoSponsor:(id)sender;

@end
