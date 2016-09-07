//
//  User.h
//  Hokd iOS App
//
//  Created by Luke Paulo on 8/31/16.
//  Copyright © 2016 HOKD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface User : NSObject

//List all of the data this class should store about the user. When doing the Blocstagram, we used NSString for idNumber. However, many data models I saw used 'int' for the id type? Receive as string.... 
@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *email;

//See 'category' property in Item.h for list of drop down options for 'interests'
@property (nonatomic, strong) NSString *interests;

@property (nonatomic, strong) NSURL *profilePictureURL;
@property (nonatomic, strong) UIImage *profilePicture;

@end
