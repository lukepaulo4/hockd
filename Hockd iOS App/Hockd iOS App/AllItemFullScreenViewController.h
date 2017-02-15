//
//  AllItemFullScreenViewController.h
//  Hockd iOS App
//
//  Created by Luke Paulo on 2/12/17.
//  Copyright © 2017 HOCKD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AllItem;

@interface AllItemFullScreenViewController : UIViewController

//Add all the properties from the storyboard here

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *itemDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *loanAmountLabel;
@property (strong, nonatomic) IBOutlet UILabel *modelLabel;
@property (strong, nonatomic) IBOutlet UILabel *manufacturerLabel;
@property (strong, nonatomic) IBOutlet UILabel *yearMadeLabel;
@property (strong, nonatomic) IBOutlet UILabel *conditionLabel;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;


- (instancetype) initWithAllItem:(AllItem *)item;

@end
