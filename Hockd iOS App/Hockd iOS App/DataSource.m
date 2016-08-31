//
//  DataSource.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 8/31/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "DataSource.h"
#import "User.h"
#import "Item.h"
#import "Address.h"


@interface DataSource ()

@property (nonatomic, strong) NSArray *items;

@end

@implementation DataSource

+ (instancetype) sharedInstance {
    
    //Make sure you only create a single instance of this class. Should take code and run it only the first time it's called.
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
    
}

@end
