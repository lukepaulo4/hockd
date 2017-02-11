//
//  TempPassLoginViewController.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 2/11/17.
//  Copyright © 2017 HOCKD. All rights reserved.
//

#import "TempPassLoginViewController.h"
#import <UICKeyChainStore.h>
#import "DataSource.h"
#import "User.h"

@interface TempPassLoginViewController ()

//need properties for 2 textfields and 1 label... actually 2 labels.
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;



@end

@implementation TempPassLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
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


+ (void)setAccessibilityType:kSecAttrAccessibleWhenUnlocked {
    
}



//press the button. submitButtonPressed
- (IBAction)submitButtonPressed:(UIButton *)sender {


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

        [[DataSource sharedInstance] loginWithUsername:self.usernameTextField.text password:self.passwordTextField.text completionHandler:^(NSError *error, NSDictionary *returnedDict) {
            NSLog(@"DataSource Shared Instance got response==%@", returnedDict);
 
            [self tempLoginCompletedWithDict:returnedDict];
 
 
 
            //Extract the "msg_code" key's value.
            NSString *msgCodeValue = [returnedDict objectForKey:@"msg_code"];
 
            //Check what that value is!
            NSLog(@"message code in required area ==%@", msgCodeValue);
 
            //Now, if the message code reads "Successfully logged in" then segue to Home. Otherwise have them retry.
            if ([msgCodeValue  isEqual:@"Successfully logged in"]) {
                NSLog(@"got correct response");
 
                NSString *token = [returnedDict objectForKey:@"token"];
                NSLog(@"token =%@", token);
 
                NSString *username = returnedDict[@"user_details"][@"username"];
                NSLog(@"username = %@", username);
 
                NSNumber *userIDNum = returnedDict[@"user_details"][@"id"];
                NSString *userID = [userIDNum stringValue];
                NSLog(@"user id =%@", userID);
 
                NSString *dictAddressUno = returnedDict[@"user_details"][@"address_one"];
                NSString *dictAddressDos = returnedDict[@"user_details"][@"address_two"];
                NSString *dictCity = returnedDict[@"user_details"][@"city"];
                NSString *dictState = returnedDict[@"user_details"][@"state"];
                NSString *dictZip = returnedDict[@"user_details"][@"zip"];
                NSString *dictInterests = returnedDict[@"user_details"][@"interests"];
 
                //Add the info to the keychain...
                [UICKeyChainStore setString:token forKey:@"access token"];
                [UICKeyChainStore setString:username forKey:@"username"];
                [UICKeyChainStore setString:userID forKey:@"user id"];
 
                [UICKeyChainStore setString:dictAddressUno forKey:@"address one"];
                [UICKeyChainStore setString:dictAddressDos forKey:@"address two"];
                [UICKeyChainStore setString:dictCity forKey:@"city"];
                [UICKeyChainStore setString:dictState forKey:@"state"];
                [UICKeyChainStore setString:dictZip forKey:@"zip"];
                [UICKeyChainStore setString:dictInterests forKey:@"interests"];
 
 
                NSString *tokenKC = [UICKeyChainStore stringForKey:@"access token"];
                NSLog(@"access token from keychain is = %@", tokenKC);
                NSString *usernameKC = [UICKeyChainStore stringForKey:@"username"];
                NSLog(@"username from keychain is = %@", usernameKC);
                NSString *userIdKC = [UICKeyChainStore stringForKey:@"user id"];
                NSLog(@"user id from keychain is = %@", userIdKC);
 
                NSString *addressOneKC = [UICKeyChainStore stringForKey:@"address one"];
                NSLog(@"address one from keychain is = %@", addressOneKC);
                NSString *addressTwoKC = [UICKeyChainStore stringForKey:@"address two"];
                NSLog(@"address two from keychain is = %@", addressTwoKC);
                NSString *cityKC = [UICKeyChainStore stringForKey:@"city"];
                NSLog(@"city from keychain is = %@", cityKC);
                NSString *stateKC = [UICKeyChainStore stringForKey:@"state"];
                NSLog(@"state from keychain is = %@", stateKC);
                NSString *zipKC = [UICKeyChainStore stringForKey:@"zip"];
                NSLog(@"zip from keychain is = %@", zipKC);
                NSString *interestsKC = [UICKeyChainStore stringForKey:@"interests"];
                NSLog(@"interests from keychain is = %@", interestsKC);
 
 
 
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


- (void)tempLoginCompletedWithDict:(NSDictionary*)dict {
    NSLog(@"got response in method==%@", dict);
    
    
}



- (IBAction)tapGestureDidFire:(UITapGestureRecognizer *)sender {
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
