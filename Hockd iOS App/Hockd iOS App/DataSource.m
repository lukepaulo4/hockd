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


@interface DataSource () {
    NSMutableArray *_items;
    NSMutableArray *_userData;
}

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSArray *userData;

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


#pragma mark - POST

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


#pragma mark Login Stuff

//method to extract login dictionary response
- (void) loginWithUsername:(NSString*)username password:(NSString*)password completionHandler:(NewItemCompletionBlock)completionHandler {
    
    NSString *apiStr = @"http://hockd.co/hockd/public/api/v1/auth/login";
    NSString *userInput = [NSString stringWithFormat:@"username=%@&password=%@", username, password, nil];
    
    [self getJsonResponse:apiStr input:userInput success:^(NSDictionary *responseDict) {
        NSLog(@"loginWithUsername in DS dict = %@", responseDict);
        completionHandler(nil,responseDict);
    } failure:^(NSError *error) {
    
    }];
}

//PARSE the login response dictionary into User
- (void) parseDataFromLoginDictionary:(NSDictionary *) loginDictionary fromRequestWithParameters:(NSDictionary *)parameters {
    
    NSArray *userArray = loginDictionary[@"data"];
    NSMutableArray *tmpUserData = [NSMutableArray array];
    
    for (NSDictionary *userDictionary in userArray) {
        User *userData = [[User alloc] initWithDictionary:userDictionary];
        
        if (userData) {
            [tmpUserData addObject:userData];
        }
    }
    
    [self willChangeValueForKey:@"userData"];
    self.userData = tmpUserData;
    [self didChangeValueForKey:@"userData"];
    
}


//method to extract create account dictionary response
- (void) createAccountWithUsername:(NSString*)username password:(NSString*)password email:(NSString*)email userType:(NSString*)userType addressOne:(NSString*)addressOne addressTwo:(NSString*)addressTwo city:(NSString*)city state:(NSString*)state zip:(NSString*)zip interests:(NSString*)interests completionHandler:(NewItemCompletionBlock)completionHandler {
    
    NSString *apiStr = @"http://hockd.co/hockd/public/api/v1/auth/signup";
    NSString *userInput = [NSString stringWithFormat:@"username=%@&password=%@&email=%@&user_type=%@&address_one=%@&address_two=%@&city=%@&state=%@&zip=%@&interests=%@", username, password, email, userType, addressOne, addressTwo, city, state, zip, interests, nil];
    
    [self getJsonResponse:apiStr input:userInput success:^(NSDictionary *responseDict) {
        NSLog(@"createAccountWithUsername in DS dict = %@", responseDict);
        completionHandler(nil,responseDict);
    } failure:^(NSError *error) {
        
    }];
}


//method to extract forgot password dictionay response
- (void) forgotPasswordWithEmail:(NSString*)email completionHandler:(NewItemCompletionBlock)completionHandler {
    
    NSString *apiStr = @"http://hockd.co/hockd/public/api/v1/auth/forgotpassword";
    NSString *userInput = [NSString stringWithFormat:@"email=%@", email, nil];
    
    [self getJsonResponse:apiStr input:userInput success:^(NSDictionary *responseDict) {
        NSLog(@"forgotPasswordWithEmail in DS dict = %@", responseDict);
        completionHandler(nil,responseDict);
    } failure:^(NSError *error) {
        
    }];
}

//method to extract create account dictionary response. This one is a bit funky.. I think actually it is OK to require all text boxes save for the address two and interests. *******If a text box is empty, the value for the key should not change (shouldn't become nil, or does it matter?). Look into this bitch a little more. ****THIS ALSO NEEDS THE TOKEN VALUE********
- (void) updateUserDetailsWithToken:(NSString *)token addressOne:(NSString*)addressOne addressTwo:(NSString*)addressTwo city:(NSString*)city state:(NSString*)state zip:(NSString*)zip interests:(NSString*)interests completionHandler:(NewItemCompletionBlock)completionHandler {
    
    NSString *apiStr = @"http://hockd.co/hockd/public/api/v1/updateuserdetails";
    NSString *userInput = [NSString stringWithFormat:@"token=%@&address_one=%@&address_two=%@&city=%@&state=%@&zip=%@&interests=%@", token, addressOne, addressTwo, city, state, zip, interests, nil];
    
    [self getJsonResponse:apiStr input:userInput success:^(NSDictionary *responseDict) {
        NSLog(@"updateAccountWithAddressOne dict = %@", responseDict);
        completionHandler(nil,responseDict);
    } failure:^(NSError *error) {
        
    }];
}


//method to update the user password.. Need to get the access token
- (void) updateUserPasswordWithToken:(NSString *)token userId:(NSString*)userId oldPassword:(NSString*)oldPassword newPassword:(NSString*)newPassword completionHandler:(NewItemCompletionBlock)completionHandler {
    
    NSString *apiStr = @"http://hockd.co/hockd/public/api/v1/updateuserdetails";
    NSString *userInput = [NSString stringWithFormat:@"token=%@&user_id=%@&old_password=%@&new_password=%@", token, userId, oldPassword, newPassword, nil];
    
    [self getJsonResponse:apiStr input:userInput success:^(NSDictionary *responseDict) {
        NSLog(@"updateAccountWithAddressOne dict = %@", responseDict);
        completionHandler(nil,responseDict);
    } failure:^(NSError *error) {
        
    }];
}






#pragma mark - GET

//Create a GET call method similar to the POST
- (void)getGETJsonResponse:(NSString *)apiStr input:(NSString *)userData success:(void (^)(NSDictionary *responseDict))success failure:(void(^)(NSError* error))failure {
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:apiStr]];
    request.HTTPBody = [userData dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"GET";
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

//method to extract my profile
- (void) myProfileWithUserId:(NSString*)userId token:(NSString*)token completionHandler:(NewItemCompletionBlock)completionHandler {
    
    NSString *apiStr = @"http://hockd.co/hockd/public/api/v1/my-profile";
    
    //Added user_id, but need to implement the token as well.
    NSString *userData = [NSString stringWithFormat:@"userId=%@&token=%@", userId, token, nil];
    
    [self getGETJsonResponse:apiStr input:userData success:^(NSDictionary *responseDict) {
        NSLog(@"user profile dict = %@", responseDict);
        completionHandler(nil,responseDict);
    } failure:^(NSError *error) {
        
    }];
}




@end







