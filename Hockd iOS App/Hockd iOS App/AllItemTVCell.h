//
//  AllItemTVCell.h
//  Hockd iOS App
//
//  Created by Luke Paulo on 1/17/17.
//  Copyright © 2017 HOCKD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AllItem;

@interface AllItemTVCell : UITableViewCell

@property (nonatomic, strong) AllItem *item;

//since doesn't belong to an instance of this object, we use +. Namaste
+ (CGFloat) heightForItem:(AllItem *)item width:(CGFloat)width;

@end
