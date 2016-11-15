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
/*
- (void) postToAPI:(NSDictionary *) feedDictionary fromRequestWithParameters:(NSDictionary *)parameters {
    
    //Create the request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://hockd.co/hockd/public/api/v1/auth/signup"]];

    [request setHTTPMethod:@"POST"];

    //Pass the string to the server
    NSString *userUpdate = [NSString stringWithFormat:@"username=%@&password=%@&email=%@&user_type=%@&address_one=%@&address_two=%@&city=%@&state=%@&zip=%@&interests=%@", [self.usernameTextField text], [self.passwordTextField text], [self.emailTextField text], [self.userTypeTextField text], [self.addressOneTextField text], [self.addressTwoTextField text], [self.cityTextField text], [self.stateTextField text], [self.zipTextField text], [self.interestsTextField text], nil];

    //Check the value that was passed
    NSLog(@"Data Details are =%@", userUpdate);

    //Conver to data
    NSData *data = [userUpdate dataUsingEncoding:NSUTF8StringEncoding];

    //Apply the data to the body
    [request setHTTPBody:data];

    //Create the response and error
    NSError *err;
    NSURLResponse *response;

    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];

    NSString *resSrt = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];

    //This is for Response
    NSLog(@"got response==%@", resSrt);

    //Now turn the data into a dictionary so we can check the key/value pairs
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];

    //Extract the "msg_code" key's value.
    NSString *msgCodeValue = [jsonDict objectForKey:@"msg_code"];

    //Check what that value is!
    NSLog(@"message code ==%@", msgCodeValue);
    
}
*/

@end







