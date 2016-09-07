//
//  AutomatedMessages.h
//  Hokd iOS App
//
//  Created by Luke Paulo on 8/31/16.
//  Copyright © 2016 HOKD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AutomatedMessages : NSObject

//Array of automated messages that will populate the message. These will be set and just for notification/update purposes. Does this make sense? Does a User class property need to be stored in here? Or does it make more sense when building the message to just use the username/profile pic from user, then pull a string message from here?
@property (nonatomic, strong) NSString *automatedMessage;

@end


@interface NSString (automatedMessages)

//+(NSString*)messageNamed:(NSString*)name {
//    NSString *message = @"";
//    
//    if (name isEqualToString:@"wrongPassword") {
//        message = @"Sorry, you put in the wrong password";
//    }
//    
//    return message;
//}

@end