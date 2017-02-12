//
//  TempPassUpdatePasswordViewController.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 2/11/17.
//  Copyright © 2017 HOCKD. All rights reserved.
//

#import "TempPassUpdatePasswordViewController.h"
#import "DataSource.h"
#import "User.h"
#import "AESCrypt.h"
#import <UICKeyChainStore.h>

@interface TempPassUpdatePasswordViewController ()

//4 properties
@property (strong, nonatomic) IBOutlet UITextField *tempPasswordTextField;
@property (strong, nonatomic) IBOutlet UITextField *updatedPasswordTextField;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *directionLabel;


@end

@implementation TempPassUpdatePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tempPasswordTextField.delegate = self;
    self.updatedPasswordTextField.delegate = self;
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

- (IBAction)tempPasswordTextFieldDidChange:(UITextField *)sender {
    if ([self.tempPasswordTextField.text length] > 0) {
    }
}

- (IBAction)newPasswordTextFieldDidChange:(UITextField *)sender {
    if ([self.updatedPasswordTextField.text length] > 0) {
    }
}


//updatePasswordButton
- (IBAction)submitButtonPressed:(UIButton *)sender {
    
    if ([[self.tempPasswordTextField text] isEqualToString:@""] || [[self.updatedPasswordTextField text] isEqualToString:@""]) {
        
        //add an alert stating the need to add a username and password
        NSString *message = [[NSString alloc] initWithFormat:@"Sorry"];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:@"Both Fields Required" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    
    
    } else {
        
        //In here, extract the token value from the keychain
        NSString *token = [UICKeyChainStore stringForKey:@"access token"];
        NSString *userID = [UICKeyChainStore stringForKey:@"user id"];
        NSString *username = [UICKeyChainStore stringForKey:@"username"];
        NSLog(@"username from keychain is = %@", username);
        NSLog(@"access token from keychain is = %@", token);
        NSLog(@"user id from keychain is = %@", userID);
        
        NSString *authValue = [NSString stringWithFormat:@"Bearer %@", token];
        
        //[[AESCrypt encrypt:username password:[self.tempPasswordTextField text]]; took this out because the temp pass won't be encrypted
        NSString *tempPassword = [self.tempPasswordTextField text];
        NSLog(@"temp password going into this = %@", tempPassword);
        
        NSString *encryptedNewPass = [AESCrypt encrypt:username password:[self.updatedPasswordTextField text]];
        
        NSLog(@"authorization token = %@ and user ID = %@ and old password = %@ and new password = %@", authValue, userID, tempPassword, encryptedNewPass);
        
        
        [[DataSource sharedInstance] updateUserPasswordWithToken:authValue userId:userID oldPassword:tempPassword newPassword:encryptedNewPass completionHandler:^(NSError *error, NSDictionary *returnedDict) {
            
            NSLog(@"DataSource Shared Instance got response==%@", returnedDict);
            
            [self tempPassUpdatePasswordCompletedWithDict:returnedDict];
            
            //Extract the "msg_code" key's value.
            NSString *msgCodeValue = [returnedDict objectForKey:@"msg_code"];
            
            //Check what that value is!
            NSLog(@"message code in required area ==%@", msgCodeValue);
            
            //Now, if the message code reads "Successfully logged in" then segue to Home. Otherwise have them retry.
            if ([msgCodeValue  isEqual:@"Password changed successfully"]) {
                NSLog(@"got correct response");
                
                
                //add a dispatch async to get rid of bug message
                dispatch_async(dispatch_get_main_queue(),   ^{
                    
                    
                    [self performSegueWithIdentifier:@"tempUpdateCompleteSegue" sender:self];
                     
                    
                    
                });
                
                
            } else {
                NSLog(@"failed to connect");
                
                dispatch_async(dispatch_get_main_queue(),   ^{
                    
                    NSString *message3 = [[NSString alloc] initWithFormat:@"Sorry"];
                    UIAlertController *alert3 = [UIAlertController alertControllerWithTitle:message3 message:@"Incorrect password" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* defaultAction3 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                           handler:^(UIAlertAction * action) {}];
                    
                    [alert3 addAction:defaultAction3];
                    [self presentViewController:alert3 animated:YES completion:nil];
                    
                });
            }
        }];
        
        
    }
    
}





- (void)tempPassUpdatePasswordCompletedWithDict:(NSDictionary*)dict {
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
