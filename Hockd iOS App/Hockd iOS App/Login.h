//
//  Login.h
//  Hockd iOS App
//
//  Created by Luke Paulo on 11/2/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Login : NSObject

- (instancetype) initWithDictionary:(NSDictionary *)loginDictionary;

//Only care about the msg_code. If it returns "Incorrect credentials", then the credentials were incorrect
@property (nonatomic, strong) NSString *messageCode;


@end
