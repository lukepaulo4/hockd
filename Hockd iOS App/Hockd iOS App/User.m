//
//  User.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 8/31/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype) initWithDictionary:(NSDictionary *)userDictionary {
    self = [super init];
    
    if (self) {
        self.user_id = userDictionary[@"id"];
        self.user_type = userDictionary[@"userType"];
        self.username = userDictionary[@"username"];
        self.email = userDictionary[@"email"];
        self.interests = userDictionary[@"interests"];
        self.state = userDictionary[@"state"];
        self.city = userDictionary[@"city"];
        self.zip = userDictionary[@"zip"];
        self.address_one = userDictionary[@"addressOne"];
        self.address_two = userDictionary[@"addressTwo"];
        
        NSString *profile_picture_URL = userDictionary[@"profileImage"];
        NSURL *profileURL = [NSURL URLWithString:profile_picture_URL];
        
        if (profileURL) {
            self.profile_picture_URL = profileURL;
        }
        
    }
    
    return self;
}


@end
















