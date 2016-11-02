//
//  ViewController.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 8/14/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "LoginViewController.h"
#import "KeychainWrapper.h"


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


- (IBAction)submitButtonPressed:(UIButton *)sender {
    NSInteger success = 0;
    
    @try {
    
    //If there is nothing for username and password...
    if ([[self.usernameTextField text] isEqualToString:@""] || [[self.passwordTextField text] isEqualToString:@""]) {
        
    //add an alert stating the need to add a username and password
        NSString *message = [[NSString alloc] initWithFormat:@"Sorry"];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:@"Username and Password Required" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    //Let's add some code so that what is posted is checked against what we have on the other end...
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
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        
        //NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
        
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *response = nil;
        
        //The below is deprecated. You need to figure out how to call this with the new actions!!!!
        NSData *urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
                           
        NSLog(@"Response code: %ld", (long)[response statusCode]);
        
        //We want that that 200 response range
        if ([response statusCode] >= 200 && [response statusCode] < 300) {
            NSString *responseData = [[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding];
            NSLog(@"Response ==> %@", responseData);
            
            NSError *error = nil;
            NSDictionary *jsonData = [NSJSONSerialization
                                      JSONObjectWithData:urlData
                                      options:NSJSONReadingMutableContainers
                                      error:&error];
            
            success = [jsonData[@"success"] integerValue];
            NSLog(@"Success: %ld", (long)success);
            
            if (success == 1) {
                NSLog(@"Login Success");
                
                
            } else {
                NSString *message2 = [[NSString alloc] initWithFormat:@"Sign In Failed"];
                UIAlertController *alert2 = [UIAlertController alertControllerWithTitle:message2 message:@"Try Again" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* defaultAction2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * action) {}];
                [alert2 addAction:defaultAction2];
                [self presentViewController:alert2 animated:YES completion:nil];
            }
            
            } else {
                //if (error) NSLog(@"Error: %@", error);
                NSString *message3 = [[NSString alloc] initWithFormat:@"Sorry"];
                UIAlertController *alert3 = [UIAlertController alertControllerWithTitle:message3 message:@"Try Again"  preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* defaultAction3 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
                [alert3 addAction:defaultAction3];
                [self presentViewController:alert3 animated:YES completion:nil];

            }
        }
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
        NSString *message4 = [[NSString alloc] initWithFormat:@"Sorry"];
        UIAlertController *alert4 = [UIAlertController alertControllerWithTitle:message4 message:@"Username and Password Incorrect"  preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction4 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * action) {}];
        
        [alert4 addAction:defaultAction4];
        [self presentViewController:alert4 animated:YES completion:nil];
    }
    
}



- (IBAction)createAccountButtonPressed:(UIButton *)sender {
}

- (IBAction)forgotPasswordButtonPressed:(UIButton *)sender {
}

- (IBAction)tapGestureDidFire:(UITapGestureRecognizer *)sender {
}

@end
