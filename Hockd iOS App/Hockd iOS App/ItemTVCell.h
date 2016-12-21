//
//  ItemTVCell.h
//  Hockd iOS App
//
//  Created by Luke Paulo on 9/14/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Item;

@interface ItemTVCell : UITableViewCell

@property (nonatomic, strong) Item *item;

@property (strong, nonatomic) IBOutlet UIImageView *itemImage;
@property (strong, nonatomic) IBOutlet UILabel *loanDesiredLabel;
@property (strong, nonatomic) IBOutlet UILabel *itemDescriptionLabel;


@end
