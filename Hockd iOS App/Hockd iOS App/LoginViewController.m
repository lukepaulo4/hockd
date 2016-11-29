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
#import "KeychainWrapper.h"
#import "Login.h"
#import "AESCrypt.h"
#import "DataSource.h"

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
    
    
    //lets encrypt the password with the following:     NSString *encryptedData = [AESCrypt encrypt:message password:password];
    //and decrypt with the following:                   NSString *message = [AESCrypt decrypt:encryptedData password:password];
    //plus you've added salt. blah dah dah
    //NSString *salt = [AESCrypt genRandStringLength:25];
    //NSString *encryptedPass = [AESCrypt encrypt:salt password:[self.passwordTextField text]];
    
    
    
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
        
        NSString *userInput = [NSString stringWithFormat:@"username=%@&password=%@", [self.usernameTextField text], protectedPass, nil];
        NSLog(@"Username = %@", self.usernameTextField);
        
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://hockd.co/hockd/public/api/v1/auth/login"]];
        request.HTTPBody = [userInput dataUsingEncoding:NSUTF8StringEncoding];
        request.HTTPMethod = @"POST";
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            //NSData *responseData = [NSKeyedArchiver archivedDataWithRootObject:jsonDict];
            NSString *resSrt = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            
            //This is for Response
            NSLog(@"got response==%@", resSrt);
            
            //Extract the "msg_code" key's value.
            NSString *msgCodeValue = [jsonDict objectForKey:@"msg_code"];
            
            //Check what that value is!
            NSLog(@"message code ==%@", msgCodeValue);
            
            //Now, if the message code reads "Successfully logged in" then segue to Home. Otherwise have them retry.
            if ([msgCodeValue  isEqual:@"Successfully logged in"]) {
                NSLog(@"got correct response");
                [self performSegueWithIdentifier:@"loginSegue" sender:self];
                
            } else /*if ((![msgCodeValue  isEqual: @"Successfully signup"])) */ {
                NSLog(@"failed to connect");
                
                NSString *message3 = [[NSString alloc] initWithFormat:@"Sorry"];
                UIAlertController *alert3 = [UIAlertController alertControllerWithTitle:message3 message:@"Incorrect username or password" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* defaultAction3 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                       handler:^(UIAlertAction * action) {}];
                
                [alert3 addAction:defaultAction3];
                [self presentViewController:alert3 animated:YES completion:nil];
            }
        }];
        
        [postDataTask resume];
    }
}

        /* The below is for use when the global method comes online.
        
        
        //implement the segue here until can figure out how to connect and make the right code work
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
        
        //NSLog(@"This call msg_code = %@", loginSuccess);
        
        
        //encryptedPass should be loginSuccess. Just changed so it isn't red. Need to change back when ready to do method
        if ([encryptedPass isEqual:@"Successfully logged in"]) {
            NSLog(@"got correct response");
            [self performSegueWithIdentifier:@"loginSegue" sender:self];
            
        } else {
            NSLog(@"failed to connect");
            
            NSString *message2 = [[NSString alloc] initWithFormat:@"Sorry"];
            UIAlertController *alert2 = [UIAlertController alertControllerWithTitle:message2 message:@"Username and/or Password Incorrect" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert2 addAction:defaultAction2];
            [self presentViewController:alert2 animated:YES completion:nil];
        }
    }
    
}

*/

- (IBAction)createAccountButtonPressed:(UIButton *)sender {
}

- (IBAction)forgotPasswordButtonPressed:(UIButton *)sender {
}

- (IBAction)tapGestureDidFire:(UITapGestureRecognizer *)sender {
}

@end


