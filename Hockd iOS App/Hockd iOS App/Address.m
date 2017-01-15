//
//  Address.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 8/31/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "Address.h"
#import "User.h"

@implementation Address

- (instancetype) initWithDictionary:(NSDictionary *)addressDictionary {
    self = [super init];
    
    if (self) {
        self.id_number = addressDictionary[@"id"];
        self.state = addressDictionary[@"state"];
        self.city = addressDictionary[@"city"];
        self.zip = addressDictionary[@"zip"];
        self.address_one = addressDictionary[@"address_one"];
        self.address_two = addressDictionary[@"address_two"];
    
    }
    
    return self;
}


@end
