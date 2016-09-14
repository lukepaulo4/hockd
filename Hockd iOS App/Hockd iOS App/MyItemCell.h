//
//  MyItemCell.h
//  Hockd iOS App
//
//  Created by Luke Paulo on 9/7/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import <UIKit/UIKit.h>

//Changed from ItemCellViewController to ItemCell, so if when you come back to this and the buttons/labels aren't working, check this out first as why. Jumping to different section and may forget later!

@interface ItemCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *itemDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UIImageView *image1View;

@end
