//
//  MyItemsTableViewController.h
//  Hockd iOS App
//
//  Created by Luke Paulo on 8/24/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyItem;

@interface MyItemsTableViewController : UITableViewController

@property (nonatomic, strong) MyItem *item;

@property (nonatomic, strong) NSArray *itemImages;
@property (nonatomic, strong) NSArray *itemLoans;
@property (nonatomic, strong) NSArray *itemDescriptions;

@end
