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
        
        //HOW IS THE DAMN PROFILE_IMAGE STORED!!!!?!?!?!?!?!?!!?
        NSString *profilePictureURL = userDictionary[@"profile_image"];
        NSURL *profileURL = [NSURL URLWithString:profilePictureURL];
        
        if (profileURL) {
            self.profilePictureURL = profileURL;
        }
        
    }
   
    return self;
}



# pragma mark - NSCoding

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    if (self) {
        self.ID = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(ID))];
        self.username = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(username))];
        self.addressOne = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(addressOne))];
        self.addressTwo = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(addressTwo))];
        self.state = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(state))];
        self.city = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(city))];
        self.zip = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(zip))];
        self.email = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(email))];
    }
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.ID forKey:NSStringFromSelector(@selector(ID))];
    [aCoder encodeObject:self.username forKey:NSStringFromSelector(@selector(username))];
    [aCoder encodeObject:self.addressOne forKey:NSStringFromSelector(@selector(addressOne))];
    [aCoder encodeObject:self.addressTwo forKey:NSStringFromSelector(@selector(addressTwo))];
    [aCoder encodeObject:self.state forKey:NSStringFromSelector(@selector(state))];
    [aCoder encodeObject:self.city forKey:NSStringFromSelector(@selector(city))];
    [aCoder encodeObject:self.zip forKey:NSStringFromSelector(@selector(zip))];
    [aCoder encodeObject:self.email forKey:NSStringFromSelector(@selector(email))];
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
















