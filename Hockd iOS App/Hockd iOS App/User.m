//
//  User.m
//  Hokd iOS App
//
//  Created by Luke Paulo on 8/31/16.
//  Copyright © 2016 HOKD. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype) initWithDictionary:(NSDictionary *)userDictionary {
    self = [super init];
    
    if (self) {
        self.idNumber = userDictionary[@"id"];
        self.username = userDictionary[@"username"];
        self.email = userDictionary[@"email"];
        self.interests = userDictionary[@"interests"];
        
        NSString *profileURLString = userDictionary[@"profilePic"];
        NSURL *profileURL = [NSURL URLWithString:profileURLString];
        
        if (profileURL) {
            self.profilePictureURL = profileURL;
        }
        
    }
    
    return self;
}


@end
