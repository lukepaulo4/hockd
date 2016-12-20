//
//  User.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 8/31/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "User.h"
#import "DataSource.h"

@implementation User


- (instancetype) initWithDictionary:(NSDictionary *)userDictionary {
    self = [super init];
    
    if (self) {
        self.token = userDictionary[@"token"];
        self.ID = userDictionary[@"id"];
        self.userType = userDictionary[@"user_type"];
        self.username = userDictionary[@"username"];
        self.email = userDictionary[@"email"];
        self.interests = userDictionary[@"interests"];
        self.state = userDictionary[@"state"];
        self.city = userDictionary[@"city"];
        self.zip = userDictionary[@"zip"];
        self.addressOne = userDictionary[@"address_one"];
        self.addressTwo = userDictionary[@"address_two"];
        
        NSString *profilePictureURL = userDictionary[@"profileImage"];
        NSURL *profileURL = [NSURL URLWithString:profilePictureURL];
        
        if (profileURL) {
            self.profilePictureURL = profileURL;
        }
        
    }
   
    return self;
}

/*these were if you make User a delegate
- (void)addIdItem:(LoginViewController *)controller didFinishEnteringItem:(NSString *)userId {
    NSLog(@"Returned user ID from LoginVC is = %@", userId);
}

- (void)addTokenItem:(LoginViewController *)controller didFinishEnteringItem:(NSString *)token {
    NSLog(@"Returned token from LoginVC is = %@", token);
}
*/




@end
















