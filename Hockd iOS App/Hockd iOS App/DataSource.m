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


+(instancetype) sharedInstance {
    static dispatch_once_t once;     //dispatch_once ensures we only create a single instance of this class
    static id sharedInstance;        //holds our shared instance
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
    
}


//create a method POST ing data
- (void)getJsonResponse:(NSString *)apiStr input:(NSString *)userInput success:(void (^)(NSDictionary *responseDict))success failure:(void(^)(NSError* error))failure {
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];

    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:apiStr]];
    request.HTTPBody = [userInput dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSLog(@"%@", data);
            
            if (error) {
                failure(error);
                NSLog(@"Error parsing JSON: %@", error);
            } else {
                NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                NSString *msgCodeValue = [jsonDict objectForKey:@"msg_code"];
                NSLog(@"message code ==%@", msgCodeValue);
                success(jsonDict);
            }
                //NSString *resSrt = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    }];
    [postDataTask resume];
}

- (void) loginWithUsername:(NSString*)username password:(NSString*)password completionHandler:(NewItemCompletionBlock)completionHandler {
    
    NSString *apiStr = @"http://hockd.co/hockd/public/api/v1/auth/login";
    NSString *userInput = [NSString stringWithFormat:@"username=%@&password=%@", username, password, nil];
    
    [self getJsonResponse:apiStr input:userInput success:^(NSDictionary *responseDict) {
        NSLog(@"loginWithUsername in DS dict = %@", responseDict);
        completionHandler(nil,responseDict);
    } failure:^(NSError *error) {
    
    }];
}

- (void) createAccountWithUsername:(NSString*)username password:(NSString*)password email:(NSString*)email userType:(NSString*)userType addressOne:(NSString*)addressOne addressTwo:(NSString*)addressTwo city:(NSString*)city state:(NSString*)state zip:(NSString*)zip interests:(NSString*)interests completionHandler:(NewItemCompletionBlock)completionHandler {
    
    NSString *apiStr = @"http://hockd.co/hockd/public/api/v1/auth/signup";
    NSString *userInput = [NSString stringWithFormat:@"username=%@&password=%@&email=%@&user_type=%@&address_one=%@&address_two=%@&city=%@&state=%@&zip=%@&interests=%@", username, password, email, userType, addressOne, addressTwo, city, state, zip, interests, nil];
    
    [self getJsonResponse:apiStr input:userInput success:^(NSDictionary *responseDict) {
        NSLog(@"createAccountWithUsername in DS dict = %@", responseDict);
        completionHandler(nil,responseDict);
    } failure:^(NSError *error) {
        
    }];
}

- (void) forgotPasswordWithEmail:(NSString*)email completionHandler:(NewItemCompletionBlock)completionHandler {
    
    NSString *apiStr = @"http://hockd.co/hockd/public/api/v1/auth/forgotpassword";
    NSString *userInput = [NSString stringWithFormat:@"username=%@", email, nil];
    
    [self getJsonResponse:apiStr input:userInput success:^(NSDictionary *responseDict) {
        NSLog(@"forgotPasswordWithEmail in DS dict = %@", responseDict);
        completionHandler(nil,responseDict);
    } failure:^(NSError *error) {
        
    }];
}

@end







