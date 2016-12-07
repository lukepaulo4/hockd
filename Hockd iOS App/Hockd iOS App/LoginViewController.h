//
//  ViewController.h
//  Hockd iOS App
//
//  Created by Luke Paulo on 8/14/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import <UIKit/UIKit.h>


//Make sure conforming to the view delegate
@interface LoginViewController : UIViewController <UITextFieldDelegate>


//Add an access string. Any object that needs to be notified when an access token is obtained will use this string.
extern NSString *const LoginViewControllerDidGetAccessTokenNotifications;



@end

