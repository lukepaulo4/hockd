//
//  Address.h
//  Hockd iOS App
//
//  Created by Luke Paulo on 8/31/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;

@interface Address : NSObject

- (instancetype) initWithDictionary:(NSDictionary *)addressDictionary;

//Does it make sense to separate out the address? OR shoulld this just be included with the user class?
@property (nonatomic, strong) NSString *id_number;
@property (nonatomic, strong) User *user;

@property (nonatomic, strong) NSString *address_one;
@property (nonatomic, strong) NSString *address_two;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *zip;

@end






















