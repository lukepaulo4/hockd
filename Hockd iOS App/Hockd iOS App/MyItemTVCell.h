//
//  MyItemTVCell.h
//  Hockd iOS App
//
//  Created by Luke Paulo on 9/14/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Item;

@interface MyItemTVCell : UITableViewCell

@property (nonatomic, strong) Item *item;

//since doesn't belong to an instance of this object, we use +. Namaste
+ (CGFloat) heightForItem:(Item *)item width:(CGFloat)width;


@end
