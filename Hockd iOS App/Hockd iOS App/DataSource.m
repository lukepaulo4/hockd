//
//  DataSource.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 8/31/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "DataSource.h"
#import "User.h"
#import "Item.h"
#import "Address.h"


@interface DataSource ()



@end

@implementation DataSource


    //create a method POST ing data

+ (NSString *)postCallToSegue:(NSString *)api msgCode:(NSString *)msgCode userInput:(NSString *)userInput {
    
    __block NSString *msgCodeValueKey;
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];

    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:api]];
    request.HTTPBody = [userInput dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        //NSData *responseData = [NSKeyedArchiver archivedDataWithRootObject:jsonDict];
        NSString *resSrt = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
        //This is for Response
        NSLog(@"got response==%@", resSrt);
    
        //Extract the "msg_code" key's value.
        NSString *msgCodeValue = [jsonDict objectForKey:@"msg_code"];
        
        //Check what that value is!
        NSLog(@"message code ==%@", msgCodeValue);
        msgCodeValueKey = msgCodeValue;
        
        NSLog(@"msgCodeValue key == %@", msgCodeValueKey);
        
        //Now, if the message code reads "Successfully logged in" then segue to Home. Otherwise have them retry.
        if ([msgCodeValue  isEqual:msgCode]) {
            NSLog(@"got correct response");
            
            
            //Do this in the view controller since this is a NSObject class
            //[self performSegueWithIdentifier:segue sender:self];
        
        } else /*if ((![msgCodeValue  isEqual: @"Successfully signup"])) */ {
            NSLog(@"failed to connect");
            
            //Do this in the view controller since this is a NSObject class
            //NSString *message3 = [[NSString alloc] initWithFormat:@"Sorry"];
            //UIAlertController *alert3 = [UIAlertController alertControllerWithTitle:message3 message:@"Email Already Exists On File" preferredStyle:UIAlertControllerStyleAlert];
            //UIAlertAction* defaultAction3 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
            //                                                   handler:^(UIAlertAction * action) {}];
        
            //[alert3 addAction:defaultAction3];
            //[self presentViewController:alert3 animated:YES completion:nil];
        }
        
       
    }];

    [postDataTask resume];

    NSLog(@"what will be returned ==%@", msgCodeValueKey);
    return msgCodeValueKey;
    
}

@end







