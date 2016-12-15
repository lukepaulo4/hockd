//
//  ViewController.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 8/14/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

//Some general notes:
//Logo Color = 3abb93 (looks to be a little off on the launch screen?)
//Logo Font = SF Orson Casual Heavy
//Fonts are added. Now run the following code to get the names of all the fonts and it should show what the name of the Orson Casual is
/*
 for (NSString* family in [UIFont familyNames]) {
    NSLog(@"%@", family);
    
    for (NSString* name in [UIFont fontNamesForFamilyName: family]) {
        NSLog(@" %@", name);
    }
}
*/

 
#import "LoginViewController.h"
#import <UICKeyChainStore.h>
#import "Login.h"
#import "AESCrypt.h"
#import "DataSource.h"
#import "User.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;


@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    
    //tell LoginViewController that User is its delegate, otherwise get an error
    /*
    LoginViewController *loginVC = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    loginVC.delegate = self;
    [[self navigationController] pushViewController:loginVC animated:YES];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Implement the UITextFieldDelegate protocol method.
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder]; //dismisses the keyboard
    return YES;
}

- (IBAction)usernameTextFieldDidChange:(UITextField *)sender {
    if ([self.usernameTextField.text length] > 0) {
        
    }
}

- (IBAction)passwordTextFieldDidChange:(UITextField *)sender {
    if ([self.passwordTextField.text length] > 0) {
        
    }
}


//set accessibility type
+ (void)setAccessibilityType:kSecAttrAccessibleWhenUnlocked {
    
}


//Press this button. If the username and password are found on the call, segue to next view. Otherwise, let them know to retry.
- (IBAction)submitButtonPressed:(UIButton *)sender {
    
    //Below is the login api address and the PULL return
//http://hockd.co/hockd/public/api/v1/auth/login
    
//POST returns
//    "token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHA6XC9cL2hvY2tkLmNvXC9ob2NrZFwvcHVibGljXC9hcGlcL3YxXC9hdXRoXC9sb2dpbiIsImlhdCI6MTQ3ODExOTUwMiwiZXhwIjoxNDc4MTIzMTAyLCJuYmYiOjE0NzgxMTk1MDIsImp0aSI6ImJjZmQxZDA4YzY2NWIxODU2MWRiNDM4MTIwZTExZGI0In0.MkhzSKDqsE70XLyyEDC_VDv5yUSAPZpzgnY6k1swWyc",
//    "user_details": {
//        "id": 1,
//        "username": "rahulsompura1",
//        "email": "rahulsompura1@gmail.com",
//        "token": null,
//        "profile_image": null,
//        "interests": "test1",
//        "address_one": "test data",
//        "address_two": "test data 2",
//        "city": "ahmedabad",
//        "state": "gujrat",
//        "zip": "380015",
//        "created_by": null,
//        "updated_by": null,
//        "created_at": null,
//        "updated_at": null,
//        "deleted_at": null,
//        "random_password": "1"
//    },
//    "msg_code": "Successfully logged in",
//    "status": true
//}
    
    
    
    //If there is nothing for username and password text fields when hit login...
    if ([[self.usernameTextField text] isEqualToString:@""] || [[self.passwordTextField text] isEqualToString:@""]) {
        
    //add an alert stating the need to add a username and password
        NSString *message = [[NSString alloc] initWithFormat:@"Sorry"];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:@"Username and Password Required" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    //Let's add some code so that when we POST we see what comes out on the other end...
    } else {
        
        NSString *encryptedPass = [AESCrypt encrypt:[self.usernameTextField text] password:[self.passwordTextField text]];
        NSString *protectedPass = encryptedPass;
        NSLog(@"Pass = %@", protectedPass);
        NSLog(@"Username = %@", self.usernameTextField);
        
        //NSDictionary *outputDict = @{};
        [[DataSource sharedInstance] loginWithUsername:self.usernameTextField.text password:protectedPass completionHandler:^(NSError *error, NSDictionary *returnedDict) {
            NSLog(@"DataSource Shared Instance got response==%@", returnedDict);

            [self loginCompletedWithDict:returnedDict];
            
            //
        
        //Extract the "msg_code" key's value.
        NSString *msgCodeValue = [returnedDict objectForKey:@"msg_code"];
        
        //Check what that value is!
        NSLog(@"message code in required area ==%@", msgCodeValue);
        
            //Now, if the message code reads "Successfully logged in" then segue to Home. Otherwise have them retry.
            if ([msgCodeValue  isEqual:@"Successfully logged in"]) {
                NSLog(@"got correct response");
                
                
                //add a dispatch async to get rid of bug message
                dispatch_async(dispatch_get_main_queue(),   ^{
                
                    [self performSegueWithIdentifier:@"loginSegue" sender:self];
                
                });
                
                
            } else {
                NSLog(@"failed to connect");
                
                dispatch_async(dispatch_get_main_queue(),   ^{
                
                NSString *message3 = [[NSString alloc] initWithFormat:@"Sorry"];
                UIAlertController *alert3 = [UIAlertController alertControllerWithTitle:message3 message:@"Incorrect username or password" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* defaultAction3 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                       handler:^(UIAlertAction * action) {}];
                
                [alert3 addAction:defaultAction3];
                [self presentViewController:alert3 animated:YES completion:nil];
                    
                });
            }
        }];
    }
}



- (void)loginCompletedWithDict:(NSDictionary*)dict {
    NSLog(@"got response in method==%@", dict);
    
    
    /* This is a way to pass data back to other view controllers
    self.token = [dict objectForKey:@"token"];
    self.userID = [dict objectForKey:@"id"];
    
    NSString *tokenToPassBack = self.token;
    [self.delegate addTokenItem:self didFinishEnteringItem:tokenToPassBack];
    
    NSString *idToPassBack = self.userID;
    [self.delegate addIdItem:self didFinishEnteringItem:idToPassBack];
     */
    
    NSString *token = [dict objectForKey:@"token"];
    NSLog(@"token =%@", token);
    
    NSNumber *userIDNum = dict[@"user_details"][@"id"];
    NSString *userID = [userIDNum stringValue];
    NSLog(@"user id =%@", userID);
    
    //Add the info to the keychain...
    [UICKeyChainStore setString:token forKey:@"access token"];
    [UICKeyChainStore setString:userID forKey:@"user id"];
     
     NSString *tokenKC = [UICKeyChainStore stringForKey:@"access token"];
     NSLog(@"access token from keychain is = %@", tokenKC);
     NSString *userIdKC = [UICKeyChainStore stringForKey:@"user id"];
     NSLog(@"user id from keychain is = %@", userIdKC);
     
    
    /*
    //Try instantiating the store object
    UICKeyChainStore *store = [UICKeyChainStore keyChainStoreWithService:@"com.hockd"];
    
    //Now add the items
    [store setString:token forKey:@"access token"];
    [store setString:userID forKey:@"user id"];
    
    UICKeyChainStore *storeData = [UICKeyChainStore keyChainStoreWithService:@"com.hockd"];
    NSLog(@"store print = %@", store);
    NSLog(@"storeData print = %@", storeData);
    */
   
}


- (IBAction)createAccountButtonPressed:(UIButton *)sender {
}

- (IBAction)forgotPasswordButtonPressed:(UIButton *)sender {
}

- (IBAction)tapGestureDidFire:(UITapGestureRecognizer *)sender {
}

@end


