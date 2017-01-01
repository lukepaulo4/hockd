//
//  UpdatePasswordViewController.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 12/7/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "UpdatePasswordViewController.h"
#import "SAMKeychain.h"
#import "Login.h"
#import "AESCrypt.h"
#import "DataSource.h"
#import <UICKeyChainStore.h>

@interface UpdatePasswordViewController ()

@property (weak, nonatomic) IBOutlet UILabel *updatePasswordLabel;
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (strong, nonatomic) IBOutlet UITextField *updatedPasswordTextField;



@end

@implementation UpdatePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.oldPasswordTextField.delegate = self;
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



- (IBAction)updatePasswordButton:(UIButton *)sender {
    
    if ([[self.oldPasswordTextField text] isEqualToString:@""] || [[self.updatedPasswordTextField text] isEqualToString:@""]) {
        
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
        
        NSString *oldPassword = [AESCrypt encrypt:username password:[self.oldPasswordTextField text]];
        NSLog(@"old password going into this = %@", oldPassword);
        
        NSString *encryptedNewPass = [AESCrypt encrypt:username password:[self.updatedPasswordTextField text]];
       
        NSLog(@"authorization token = %@ and user ID = %@ and old password = %@ and new password = %@", authValue, userID, oldPassword, encryptedNewPass);
        
        
        [[DataSource sharedInstance] updateUserPasswordWithToken:authValue userId:userID oldPassword:oldPassword newPassword:encryptedNewPass completionHandler:^(NSError *error, NSDictionary *returnedDict) {
            
            NSLog(@"DataSource Shared Instance got response==%@", returnedDict);
            
            [self updatePasswordCompletedWithDict:returnedDict];
            
            //Extract the "msg_code" key's value.
            NSString *msgCodeValue = [returnedDict objectForKey:@"msg_code"];
            
            //Check what that value is!
            NSLog(@"message code in required area ==%@", msgCodeValue);
            
            //Now, if the message code reads "Successfully logged in" then segue to Home. Otherwise have them retry.
            if ([msgCodeValue  isEqual:@"Password changed successfully"]) {
                NSLog(@"got correct response");
                
                
                //add a dispatch async to get rid of bug message
                dispatch_async(dispatch_get_main_queue(),   ^{
                    
                    [self performSegueWithIdentifier:@"updatePasswordCompleteSegue" sender:self];
                    
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




- (void)updatePasswordCompletedWithDict:(NSDictionary*)dict {
    NSLog(@"got response in method==%@", dict);
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
