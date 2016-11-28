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

- (void) requestJsonResponseWithCompletionHandler:(NewItemCompletionBlock)completionHandler {
    
    /*  [self getJsonResponse:apiStr input:userUpdate success:^(NSDictionary *responseDict) {
        NSLog(@"%@", responseDict);
    } failure:^(NSError *error) {
    
    }];  */
}


@end







