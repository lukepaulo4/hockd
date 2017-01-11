//
//  User.h
//  Hokd iOS App
//
//  Created by Luke Paulo on 8/31/16.
//  Copyright © 2016 HOKD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataSource.h"

@interface User : NSObject 

- (instancetype) initWithDictionary:(NSDictionary *)userDictionary;

//List all of the data this class should store about the user.
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *userType;


//See 'category' property in Item.h for list of drop down options for 'interests'
@property (nonatomic, strong) NSString *interests;

@property (nonatomic, strong) NSURL *profilePictureURL;
@property (nonatomic, strong) UIImage *profileImage;


@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *addressOne;
@property (nonatomic, strong) NSString *addressTwo;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *zip;

@end
