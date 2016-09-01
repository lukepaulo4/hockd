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

//Does it make sense to separate out the address? OR shoulld this just be included with the user class?
@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) User *user;

@property (nonatomic, strong) NSString *addressLineOne;
@property (nonatomic, strong) NSString *addressLineTwo;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *zip;

@end
