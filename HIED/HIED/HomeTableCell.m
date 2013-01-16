//
//  SimpleTableCell.m
//  HIED
//
//  Created by Kevin Kelly on 1/10/13.
//  Copyright (c) 2013 KK. All rights reserved.
//

#import "HomeTableCell.h"
#import "WebViewController.h"

@implementation HomeTableCell

//@synthesize nameLabel = _nameLabel;
//@synthesize prepTimeLabel = _prepTimeLabel;
//@synthesize thumbnailImageView = _thumbnailImageView;
@synthesize newsArticle, titleLabel, articleLabel, timeLabel, urlLabel, authorLabel, topicLabel, starCSLabel, sponsorLabel, starLabel, smallCommentLabel, smallStarButton, smallCommentButton, comments, sponsor, star, smallComment, sponsoredBy;//starCountLabel, commentCountLabel, smallStarButton, smallCommentButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
//        titleLabel.text = @"Title";
//        articleLabel.text = @"article";
//        timeLabel.text = @"time";
//        urlLabel.text = @"url.com";
//        authorLabel.text = @"chompsky";
//        topicLabel.text = @"BEES KNEES";
//        starCSLabel.text = @"blah blah shit";
//        sponsorLabel.text = @"Ben Affleck";
//        commentCountLabel.text = @"6";
//        starCountLabel.text = @"66";
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)goToSource:(id)sender {
//    WebViewController *webController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
//    webController.webURL = [newsArticle objectForKey:@"original_url"];
//    [self.navigationController pushViewController:webController animated:YES];
}

- (IBAction)goToAuthor:(id)sender {
//    NSString *googlePrefix = @"https://www.google.com/search?client=safari&rls=en&q=";
//    NSString *googleSuffix = @"&ie=UTF-8&oe=UTF-8";
//    NSString *authorPlus = @"";
//    if ([[newsArticle objectForKey:@"author"] isEqualToString:@"N/A"]){
//    }else
//    {
//        authorPlus = [newsArticle objectForKey:@"author"];
//        authorPlus = [authorPlus stringByReplacingOccurrencesOfString:@" "
//                                                           withString:@"+"];
//    };
//    NSString *topicPlus = [newsArticle objectForKey:@"topic"];
//    topicPlus = [topicPlus stringByReplacingOccurrencesOfString:@" "
//                                                     withString:@"+"];
//    
//    NSString *appendedAuthor = [googlePrefix stringByAppendingString:authorPlus];
//    if ([authorPlus isEqualToString:@""]){
//    }else
//        appendedAuthor = [appendedAuthor stringByAppendingString:@"+"];
//    appendedAuthor = [appendedAuthor stringByAppendingString:topicPlus];
//    appendedAuthor = [appendedAuthor stringByAppendingString:googleSuffix];
//    
//    WebViewController *webController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
//    webController.webURL = appendedAuthor;
//    [self.navigationController pushViewController:webController animated:YES];
}

- (IBAction)gotoComments:(id)sender{
//    NSLog(@"commment for the lulz!");
}

- (IBAction)gotoSponsor:(id)sender{
//    WebViewController *webController = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
//    webController.webURL = @"http://bearrabbit.com";
//    [self.navigationController pushViewController:webController animated:YES];
}


@end
