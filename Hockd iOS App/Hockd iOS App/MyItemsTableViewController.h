//
//  MyItemsTableViewController.h
//  Hockd iOS App
//
//  Created by Luke Paulo on 8/24/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Item;

@interface MyItemsTableViewController : UITableViewController

@property (nonatomic, strong) Item *item;

@property (nonatomic, strong) NSArray *itemImages;
@property (nonatomic, strong) NSArray *itemLoans;
@property (nonatomic, strong) NSArray *itemDescriptions;

@end
