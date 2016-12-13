//
//  User.h
//  Hokd iOS App
//
//  Created by Luke Paulo on 8/31/16.
//  Copyright © 2016 HOKD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface User : NSObject


- (instancetype) initWithDictionary:(NSDictionary *)userDictionary;



//List all of the data this class should store about the user.
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *user_type;


//See 'category' property in Item.h for list of drop down options for 'interests'
@property (nonatomic, strong) NSString *interests;

@property (nonatomic, strong) NSURL *profile_picture_URL;
@property (nonatomic, strong) UIImage *profile_image;



//Not sure if supposed to keep address in keychain? Make it all part of this dictionary now, if need to change you already set up the address class.
@property (nonatomic, strong) NSString *address_one;
@property (nonatomic, strong) NSString *address_two;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *zip;

@end
