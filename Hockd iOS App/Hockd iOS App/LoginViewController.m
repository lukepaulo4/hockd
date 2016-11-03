//
//  ViewController.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 8/14/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "LoginViewController.h"
#import "KeychainWrapper.h"
#import "Login.h"


@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;

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
        NSString *post = [[NSString alloc] initWithFormat:@"username=%@&password=%@", [self.usernameTextField text], [self.passwordTextField text]];
        NSLog(@"PostData %@", post);
        
        NSURL *url = [NSURL URLWithString:@"http://hockd.co/hockd/public/api/v1/auth/login"];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setHTTPBody:postData];
        
        //Send our request and read the reply by creating a new NSURLSession
        NSError *err;
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            NSLog(@"requestReply: %@", requestReply);
        }] resume];
        
        //Now that we have the data, let's do this. Write an if statement, so that if  "msg_code": "Successfully logged in" we then segue to the home page. Else if "msg_code": "Incorrect credentials" then error message displays and doesn't segue
        
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        NSString *messageCode = [jsonDict objectForKey:@"msg_code"];
        
        if ([messageCode isEqualToString:@"Incorrect credentials"]) {
            NSString *message2 = [[NSString alloc] initWithFormat:@"Sorry"];
            UIAlertController *alert2 = [UIAlertController alertControllerWithTitle:message2 message:@"Username and/or Password Are Incorrect" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* defaultAction2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert2 addAction:defaultAction2];
            [self presentViewController:alert2 animated:YES completion:nil];
            
        } else if ([messageCode isEqualToString:@"Successfully logged in"]) {
            [self performSegueWithIdentifier:@"login_successful" sender:self];
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
