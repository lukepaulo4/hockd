//
//  MyItemFullScreenViewController.h
//  Hockd iOS App
//
//  Created by Luke Paulo on 1/23/17.
//  Copyright © 2017 HOCKD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyItem;

@interface MyItemFullScreenViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

//taking this out for now. can come back and re enter if feel it is necessary
//@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutlet UILabel *itemDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *loanAmountLabel;
@property (strong, nonatomic) IBOutlet UILabel *conditionLabel;
@property (strong, nonatomic) IBOutlet UILabel *manufacturerLabel;
@property (strong, nonatomic) IBOutlet UILabel *yearMadeLabel;
@property (strong, nonatomic) IBOutlet UILabel *modelLabel;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@property (strong, nonatomic) IBOutlet UILabel *otherCommentsLabel;



- (instancetype) initWithMyItem:(MyItem *)item;

//- (void) centerScrollView;

@end
