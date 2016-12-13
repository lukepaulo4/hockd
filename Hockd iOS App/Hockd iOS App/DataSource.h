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

@property (nonatomic, strong, readonly) NSArray *items;


- (void) loginWithUsername:(NSString*)username password:(NSString*)password completionHandler:(NewItemCompletionBlock)completionHandler;

- (void) createAccountWithUsername:(NSString*)username password:(NSString*)password email:(NSString*)email userType:(NSString*)userType addressOne:(NSString*)addressOne addressTwo:(NSString*)addressTwo city:(NSString*)city state:(NSString*)state zip:(NSString*)zip interests:(NSString*)interests completionHandler:(NewItemCompletionBlock)completionHandler;

- (void) forgotPasswordWithEmail:(NSString*)email completionHandler:(NewItemCompletionBlock)completionHandler;

- (void) updateUserDetailsWithToken:(NSString *)token addressOne:(NSString*)addressOne addressTwo:(NSString*)addressTwo city:(NSString*)city state:(NSString*)state zip:(NSString*)zip interests:(NSString*)interests completionHandler:(NewItemCompletionBlock)completionHandler;

- (void) updateUserPasswordWithToken:(NSString *)token userId:(NSString*)userId oldPassword:(NSString*)oldPassword newPassword:(NSString*)newPassword completionHandler:(NewItemCompletionBlock)completionHandler;

- (void) myProfileWithUserId:(NSString*)userId token:(NSString*)token completionHandler:(NewItemCompletionBlock)completionHandler;



@end
