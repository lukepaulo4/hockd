//
//  DataSource.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 8/31/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "DataSource.h"
#import "User.h"
#import "MyItem.h"



@interface DataSource () {
    NSMutableArray *_myItems;
    NSMutableArray *_userData;
}


@property (nonatomic, strong) NSArray *myItems;
@property (nonatomic, strong) NSArray *userData;


//track whether refresh is already in progress. don't want to fetch multiple times while waiting for a result from the server
@property (nonatomic, assign) BOOL isRefreshing;
@property (nonatomic, assign) BOOL isLoadingOlderItems;

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


#pragma mark - Add required KVC accessor methods 

//The array must be accessible
- (NSUInteger) countOfItems {
    return self.myItems.count;
}

- (id) objectInItemsAtIndex:(NSUInteger)index {
    return [self.myItems objectAtIndex:index];
}

- (NSArray *) itemsAtIndexes:(NSIndexSet *)indexes {
    return [self.myItems objectsAtIndexes:indexes];
}

//add mutable accessor methods. These are KVC methods that allow insertion and deletion of elements from MyItems. Need to be _myItems not self.myItems because in header file myItems is declared as readonly
- (void) insertObject:(MyItem *)object inMyItemsAtIndex:(NSUInteger)index {
    [_myItems insertObject:object atIndex:index];
}

- (void) removeObjectFromMyItemsAtIndex:(NSUInteger)index {
    [_myItems removeObjectAtIndex:index];
}

- (void) replaceObjectInMyItemsAtIndex:(NSUInteger)index withObject:(id)object {
    [_myItems replaceObjectAtIndex:index withObject:object];
}




#pragma mark - Random Data Add To Test Table View

//Add some placeholder data to store.
- (instancetype) init {
    self = [super init];
    
    if (self) {
        [self addRandomData];
    }
    
    return self;
}

- (void) addRandomData {
    NSMutableArray *randomItems = [NSMutableArray array];
    
    for (int i = 1; i <= 10; i++) {
        NSString *imageName = [NSString  stringWithFormat:@"%d.jpg", i];
        UIImage *image = [UIImage imageNamed:imageName];
        
        if (image) {
            MyItem *item = [[MyItem alloc] init];
            item.user = [self randomUser];
            item.imageOne = image;
            item.itemDescription = [self randomSentence];
            item.loanDesired = [self randomValue];
            
            [randomItems addObject:item];
        }
    }
    
    self.myItems = randomItems;
}

- (User *) randomUser {
    User *user = [[User alloc] init];
    
    user.username = [self randomStringOfLength:arc4random_uniform(10) + 2];
    
    return user;
}

- (NSString *) randomSentence {
    NSUInteger wordCount = arc4random_uniform(20) + 2;
    
    NSMutableString *randomSentence = [[NSMutableString alloc] init];
    
    for (int i = 0; i <= wordCount; i++) {
        NSString *randomWord = [self randomStringOfLength:arc4random_uniform(12) + 2];
        [randomSentence appendFormat:@"Item Description: %@ ", randomWord];
    }
    
    return randomSentence;
}

- (NSString *) randomValue {
    
    NSMutableString *randomValue = [[NSMutableString alloc] init];
    
    for (int i = 0; i < 1; i++) {
        NSString *randomNumber = [self randomNumOfLength:arc4random_uniform(10)];
        [randomValue appendFormat:@"Loan Desired: $%@ ", randomNumber];
    }
    
    return randomValue;
}

- (NSString *) randomNumOfLength:(NSUInteger) len {
    NSString *numbers = @"0123456789";
    
    NSMutableString *s = [NSMutableString string];
    for (NSUInteger i = 0U; i < len; i++) {
        u_int32_t r = arc4random_uniform((u_int32_t)[numbers length]);
        unichar c = [numbers characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    
    return [NSString stringWithString:s];
}

- (NSString *) randomStringOfLength:(NSUInteger) len {
    NSString *alphabet = @"abcdefghijklmnopqrstuvwxyz";
    
    NSMutableString *s = [NSMutableString string];
    for (NSUInteger i = 0U; i < len; i++) {
        u_int32_t r = arc4random_uniform((u_int32_t)[alphabet length]);
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    
    return [NSString stringWithString:s];
}




//implement the pull to refresh completion handler
- (void) requestNewItemsWithCompletionHandler:(NewItemCompletionBlockPTR)completionHandler {
    
    // #1 check if request for recovering new item is already in progress. If so, return immedidately, otherwise set to YES.
    if (self.isRefreshing == NO) {
        self.isRefreshing = YES;
        
        // #2 create a new random media object and append it to the front of the KVC array. Place at top-most table cell.
        MyItem *item = [[MyItem alloc] init];
        item.user = [self randomUser];
        item.imageOne = [UIImage imageNamed:@"10.jpg"];
        item.itemDescription = [self randomSentence];
        
        NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"myItems"];
        [mutableArrayWithKVO insertObject:item atIndex:0];
        
        self.isRefreshing = NO;
        
        if (completionHandler) {
            completionHandler(nil);
        }
    }
}

//implement the infinite scroll method/completion handler
- (void) requestOldItemsWithCompletionHandler:(NewItemCompletionBlockPTR)completionHandler {
    if (self.isLoadingOlderItems == NO) {
        self.isLoadingOlderItems = YES;
        MyItem *item = [[MyItem alloc] init];
        item.user = [self randomUser];
        item.imageOne = [UIImage imageNamed:@"1.jpg"];
        item.itemDescription = [self randomSentence];
        
        NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"myItems"];
        [mutableArrayWithKVO addObject:item];
        
        self.isLoadingOlderItems = NO;
        
        if (completionHandler) {
            completionHandler(nil);
        }
    }
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


//POST with authorization
- (void)getJsonResponseWithAuthorization:(NSString *)apiStr authorization:(NSString *)authValue input:(NSString *)userInput success:(void (^)(NSDictionary *responseDict))success failure:(void(^)(NSError* error))failure {
  
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.HTTPAdditionalHeaders = @{@"Authorization": authValue};
    
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
        completionHandler(nil, responseDict);
    } failure:^(NSError *error) {
    
    }];
}




//method to extract create account dictionary response
- (void) createAccountWithUsername:(NSString*)username password:(NSString*)password email:(NSString*)email userType:(NSString*)userType addressOne:(NSString*)addressOne addressTwo:(NSString*)addressTwo city:(NSString*)city state:(NSString*)state zip:(NSString*)zip interests:(NSString*)interests imageURL:(NSURL*)imageURL completionHandler:(NewItemCompletionBlock)completionHandler {
    
    NSString *apiStr = @"http://hockd.co/hockd/public/api/v1/auth/signup";
    NSString *userInput = [NSString stringWithFormat:@"username=%@&password=%@&email=%@&user_type=%@&address_one=%@&address_two=%@&city=%@&state=%@&zip=%@&interests=%@&profile_image=%@", username, password, email, userType, addressOne, addressTwo, city, state, zip, interests, [imageURL absoluteURL], nil];
    
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

//method to update account info...  Add all the account info to keychain like you did with the username, token, and user id. Then if someone goes to update account and some of the textfields are empty, can populate them with the existing values so they don't become null.
- (void) updateUserDetailsWithToken:(NSString *)authValue userId:(NSString*)userId addressOne:(NSString*)addressOne addressTwo:(NSString*)addressTwo city:(NSString*)city state:(NSString*)state zip:(NSString*)zip interests:(NSString*)interests completionHandler:(NewItemCompletionBlock)completionHandler {
    
    
    NSString *apiStr = @"http://hockd.co/hockd/public/api/v1/updateuserdetails";
    NSString *userInput = [NSString stringWithFormat:@"id=%@&address_one=%@&address_two=%@&city=%@&state=%@&zip=%@&interests=%@", userId, addressOne, addressTwo, city, state, zip, interests, nil];
    
    [self getJsonResponseWithAuthorization:apiStr authorization:authValue input:userInput success:^(NSDictionary *responseDict) {
        NSLog(@"updateAccount in DataSource.m dict = %@", responseDict);
        completionHandler(nil,responseDict);
    } failure:^(NSError *error) {
        
    }];
}


//method to update the user password.. Need to get the access token
- (void) updateUserPasswordWithToken:(NSString *)authValue userId:(NSString*)userId oldPassword:(NSString*)oldPassword newPassword:(NSString*)newPassword completionHandler:(NewItemCompletionBlock)completionHandler {
    
    NSString *apiStr = @"http://hockd.co/hockd/public/api/v1/auth/updatepassword";
    NSString *userInput = [NSString stringWithFormat:@"user_id=%@&old_password=%@&new_password=%@", userId, oldPassword, newPassword, nil];
    
    [self getJsonResponseWithAuthorization:apiStr authorization:authValue input:userInput success:^(NSDictionary *responseDict) {
        NSLog(@"updatePassword in DataSource.m dict = %@", responseDict);
        completionHandler(nil,responseDict);
    } failure:^(NSError *error) {
        
    }];
}


//add new item to hock
- (void) hockItemWithToken:(NSString *)authValue userId:(NSString*)userId itemPic:(NSData*)itemPic category:(NSString*)category itemDescription:(NSString*)itemDescription manufacturer:(NSString*)manufacturer manufactureYear:(NSString*)manufactureYear modelName:(NSString*)modelName condition:(NSString*)condition otherComments:(NSString*)otherComments loanDesired:(NSString*)loanDesired completionHandler:(NewItemCompletionBlock)completionHandler {
    
    
    NSString *apiStr = @"http://hockd.co/hockd/public/api/v1/add-request-loan";
    NSString *userInput = [NSString stringWithFormat:@"user_id=%@&item_pics=%@&category=%@&item_description=%@&menufacturer=%@&menufacturer_year=%@&model_name=%@&condition=%@&other_comments=%@&loan_desired=%@", userId, itemPic, category, itemDescription, manufacturer, manufactureYear, modelName, condition, otherComments, loanDesired, nil];
    
    [self getJsonResponseWithAuthorization:apiStr authorization:authValue input:userInput success:^(NSDictionary *responseDict) {
        NSLog(@"hock item response dict in DataSource.m dict = %@", responseDict);
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







