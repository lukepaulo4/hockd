//
//  Login.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 11/2/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "Login.h"

@implementation Login

- (instancetype) initWithDictionary:(NSDictionary *)loginDictionary {
    self = [super init];
    
    if (self) {
        self.messageCode = loginDictionary[@"msg_code"];
        
    }
    
    return self;
}

@end
