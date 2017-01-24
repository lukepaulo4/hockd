//
//  MyItemTVCell.h
//  Hockd iOS App
//
//  Created by Luke Paulo on 9/14/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyItem, MyItemTVCell;

@protocol MyItemTVCellDelegate <NSObject>

- (void) cell:(MyItemTVCell *)cell didTapImageView:(UIImageView *)imageView;

@end

@interface MyItemTVCell : UITableViewCell

@property (nonatomic, strong) MyItem *item;
@property (nonatomic, weak) id <MyItemTVCellDelegate> delegate;

//since doesn't belong to an instance of this object, we use +. Namaste
+ (CGFloat) heightForItem:(MyItem *)item width:(CGFloat)width;


@end
