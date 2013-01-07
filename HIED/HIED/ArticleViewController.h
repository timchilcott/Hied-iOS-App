//
//  ArticleViewController.h
//  Hied_alpha
//
//  Created by Kevin Kelly on 11/11/12.
//  Copyright (c) 2012 KK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleViewController : UIViewController{
    NSDictionary *newsArticle;
    
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *timeLabel;
    IBOutlet UILabel *urlLabel;
    IBOutlet UILabel *authorLabel;
    IBOutlet UILabel *topicLabel;
    
    IBOutlet UITextView *descTextView;
}

@property (nonatomic, copy) NSDictionary *newsArticle;
- (IBAction)goToSource:(id)sender;
- (IBAction)goToAuthor:(id)sender;

@end
