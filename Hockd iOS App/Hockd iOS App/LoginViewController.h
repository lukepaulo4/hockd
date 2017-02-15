//
//  ViewController.h
//  Hockd iOS App
//
//  Created by Luke Paulo on 8/14/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
//Make a delegate of this class. Now can pass things to that class.
@class LoginViewController;

@protocol LoginViewControllerDelegate <NSObject>

- (void)addTokenItem:(LoginViewController *)controller didFinishEnteringItem:(NSString *)token;
- (void)addIdItem:(LoginViewController *)controller didFinishEnteringItem:(NSString *)userId;

@end
*/

//Make sure conforming to the view delegate
@interface LoginViewController : UIViewController <UITextFieldDelegate>


//Add an access string. Any object that needs to be notified when an access token is obtained will use this string.
extern NSString *const LoginViewControllerDidGetAccessTokenNotification;

/*Set up delegate property in case need to make other VC a delegate and pass data that way
//set up a delegate property to pass items to other class
@property (nonatomic, weak) id <LoginViewControllerDelegate> delegate;
*/
 
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *userID;


@end

