//
//  TempPassLoginViewController.h
//  Hockd iOS App
//
//  Created by Luke Paulo on 2/11/17.
//  Copyright © 2017 HOCKD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TempPassLoginViewController : UIViewController <UITextFieldDelegate>

extern NSString *const LoginViewControllerDidGetAccessTokenNotifications;

@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *userID;

@end
