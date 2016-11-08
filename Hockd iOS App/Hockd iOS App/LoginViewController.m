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
        
        //Create the request
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://hockd.co/hockd/public/api/v1/auth/login"]];
        
        [request setHTTPMethod:@"POST"];
        
        //Pass the string to the server
        NSString *userUpdate = [NSString stringWithFormat:@"username=%@&password=%@", [self.usernameTextField text], [self.passwordTextField text], nil];
        
        //Check the value that was passed
        NSLog(@"Data Details are =%@", userUpdate);
        
        //Conver to data
        NSData *data = [userUpdate dataUsingEncoding:NSUTF8StringEncoding];
        
        //Apply the data to the body
        [request setHTTPBody:data];
        
        //Create the response and error
        NSError *err;
        NSURLResponse *response;
        
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
        
        NSString *resSrt = [[NSString alloc] initWithData:responseData encoding:NSASCIIStringEncoding];
        
        //This is for Response
        NSLog(@"got response==%@", resSrt);
        
        //Now turn the data into a dictionary so we can check the key/value pairs
        NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&err];
        
        //Extract the "msg_code" key's value.
        NSString *msgCodeValue = [jsonDict objectForKey:@"msg_code"];
        
        //Check what that value is!
        NSLog(@"message code ==%@", msgCodeValue);
        
        //Now, if the message code reads "Successfully logged in" then segue to Home. Otherwise have them retry.
        if ([msgCodeValue  isEqual:@"Successfully logged in"]) {
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



- (IBAction)createAccountButtonPressed:(UIButton *)sender {
}

- (IBAction)forgotPasswordButtonPressed:(UIButton *)sender {
}

- (IBAction)tapGestureDidFire:(UITapGestureRecognizer *)sender {
}

@end
