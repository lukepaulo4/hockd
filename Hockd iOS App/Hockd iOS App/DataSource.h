//
//  DataSource.h
//  Hockd iOS App
//
//  Created by Luke Paulo on 8/31/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^NewItemCompletionBlock)(NSError *error, NSDictionary *returnDict);

@interface DataSource : NSObject

+(instancetype) sharedInstance;

//Create array to store our array of items
@property (nonatomic, strong, readonly) NSArray *items;

@property (nonatomic, strong, readonly) NSArray *userData;


- (void) loginWithUsername:(NSString*)username password:(NSString*)password completionHandler:(NewItemCompletionBlock)completionHandler;

- (void) createAccountWithUsername:(NSString*)username password:(NSString*)password email:(NSString*)email userType:(NSString*)userType addressOne:(NSString*)addressOne addressTwo:(NSString*)addressTwo city:(NSString*)city state:(NSString*)state zip:(NSString*)zip interests:(NSString*)interests imageURL:(NSURL*)imageURL completionHandler:(NewItemCompletionBlock)completionHandler;

- (void) forgotPasswordWithEmail:(NSString*)email completionHandler:(NewItemCompletionBlock)completionHandler;

- (void) updateUserDetailsWithToken:(NSString *)authValue userId:(NSString*)userId addressOne:(NSString*)addressOne addressTwo:(NSString*)addressTwo city:(NSString*)city state:(NSString*)state zip:(NSString*)zip interests:(NSString*)interests completionHandler:(NewItemCompletionBlock)completionHandler;

- (void) updateUserPasswordWithToken:(NSString *)authValue userId:(NSString*)userId oldPassword:(NSString*)oldPassword newPassword:(NSString*)newPassword completionHandler:(NewItemCompletionBlock)completionHandler;

- (void) hockItemWithToken:(NSString *)authValue userId:(NSString*)userId itemPic:(NSData*)itemPic category:(NSString*)category itemDescription:(NSString*)itemDescription manufacturer:(NSString*)manufacturer manufactureYear:(NSString*)manufactureYear modelName:(NSString*)modelName condition:(NSString*)condition otherComments:(NSString*)otherComments loanDesired:(NSString*)loanDesired completionHandler:(NewItemCompletionBlock)completionHandler;

- (void) myProfileWithUserId:(NSString*)userId token:(NSString*)token completionHandler:(NewItemCompletionBlock)completionHandler;




@end
