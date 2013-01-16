//
//  SimpleTableCell.h
//  HIED
//
//  Created by Kevin Kelly on 1/10/13.
//  Copyright (c) 2013 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableCell : UITableViewCell

@property (nonatomic, copy) NSDictionary *newsArticle;
- (IBAction)goToSource:(id)sender;
- (IBAction)goToAuthor:(id)sender;
- (IBAction)gotoComments:(id)sender;
- (IBAction)gotoSponsor:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *articleLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *urlLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UILabel *topicLabel;
@property (strong, nonatomic) IBOutlet UILabel *starCSLabel;
@property (strong, nonatomic) IBOutlet UILabel *sponsorLabel;
@property (strong, nonatomic) IBOutlet UILabel *sponsoredBy;
//@property (strong, nonatomic) IBOutlet UILabel *starCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *starLabel;
//@property (strong, nonatomic) IBOutlet UILabel *commentCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *smallCommentLabel;
@property (strong, nonatomic) IBOutlet UIButton *smallStarButton;
@property (strong, nonatomic) IBOutlet UIButton *smallCommentButton;
@property (strong, nonatomic) IBOutlet UIButton *comments;
@property (strong, nonatomic) IBOutlet UIButton *sponsor;
@property (strong, nonatomic) IBOutlet UIButton *star;
@property (strong, nonatomic) IBOutlet UIButton *smallComment;

@end