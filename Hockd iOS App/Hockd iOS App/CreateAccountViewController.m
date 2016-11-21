//
//  CreateAccountViewController.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 11/7/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "CreateAccountViewController.h"
#import "DataSource.h"
#import "AESCrypt.h"

//Create below class then implement here
//#import "CreateAccount.h"

@interface CreateAccountViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *retypePasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *userTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressOneTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTwoTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (weak, nonatomic) IBOutlet UITextField *zipTextField;
@property (weak, nonatomic) IBOutlet UITextField *interestsTextField;

@property (weak, nonatomic) IBOutlet UILabel *createAccountLabel;

@end

@implementation CreateAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.retypePasswordTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.userTypeTextField.delegate = self;
    self.addressOneTextField.delegate = self;
    self.addressTwoTextField.delegate = self;
    self.cityTextField.delegate = self;
    self.stateTextField.delegate = self;
    self.zipTextField.delegate = self;
    self.interestsTextField.delegate = self;
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

- (IBAction)retypePasswordTextFieldDidChange:(UITextField *)sender {
    if ([self.retypePasswordTextField.text length] > 0) {
    }
}

- (IBAction)emailTextFieldDidChange:(UITextField *)sender {
    if ([self.emailTextField.text length] > 0) {
    }
}

- (IBAction)userTypeTextFieldDidChange:(UITextField *)sender {
    if ([self.userTypeTextField.text length] > 0) {
    }
}

- (IBAction)addressOneTextFieldDidChange:(UITextField *)sender {
    if ([self.addressOneTextField.text length] > 0) {
    }
}

- (IBAction)addressTwoTextFieldDidChange:(UITextField *)sender {
    if ([self.addressTwoTextField.text length] > 0) {
    }
}

- (IBAction)cityTextFieldDidChange:(UITextField *)sender {
    if ([self.cityTextField.text length] > 0) {
    }
}

- (IBAction)stateTextFieldDidChange:(UITextField *)sender {
    if ([self.stateTextField.text length] > 0) {
    }
}

- (IBAction)zipTextFieldDidChange:(UITextField *)sender {
    if ([self.zipTextField.text length] > 0) {
    }
}

- (IBAction)interestsTextFieldDidChange:(UITextField *)sender {
    if ([self.interestsTextField.text length] > 0) {
    }
}


 
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addPhotoButton:(UIButton *)sender {
}

- (IBAction)createAccountButton:(UIButton *)sender {
    
    //let's salt and hash that password text box
    //NSString *salt = [AESCrypt genRandStringLength:25];
    NSString *encryptedPass = [AESCrypt encrypt:[self.usernameTextField text] password:[self.passwordTextField text]];
    NSString *protectedPass = encryptedPass;
    
    NSString *encryptedRetypePass = [AESCrypt encrypt:[self.usernameTextField text] password:[self.retypePasswordTextField text]];
    NSString *protectedRetypePass = encryptedRetypePass;
    
    NSLog(@"Pass = %@", protectedPass);
    NSLog(@"Pas2 = %@", protectedRetypePass);
    
    //First, if any of the text fields aren't filled in, don't let them pass. Except address line 2. Don't need that one.
    if ([[self.usernameTextField text] isEqualToString:@""]  || [[self.passwordTextField text] isEqualToString:@""] || [[self.retypePasswordTextField text] isEqualToString:@""] || [[self.emailTextField text] isEqualToString:@""] || [[self.userTypeTextField text] isEqualToString:@""] || [[self.addressOneTextField text] isEqualToString:@""] || [[self.cityTextField text] isEqualToString:@""] || [[self.stateTextField text] isEqualToString:@""] || [[self.zipTextField text] isEqualToString:@""] || [[self.interestsTextField text] isEqualToString:@""]) {
        
        //add an alert stating the need to fill in the data
        NSString *message = [[NSString alloc] initWithFormat:@"ATTN:"];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:@"All Data Fields Required Except Address 2" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        
        //Let's add some code so that when we POST we see what comes out on the other end...
    } else if (![protectedPass isEqualToString:(protectedRetypePass)]) {
        
        //password retype doesn't equal password, let them know passwords don't match.  Look into a method later so that instead of a pop up, there is an indicator that shows a green check when the password in the retype box matches.
        NSString *message2 = [[NSString alloc] initWithFormat:@"Try Again:"];
        UIAlertController *alert2 = [UIAlertController alertControllerWithTitle:message2 message:@"Passwords Did Not Match" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert2 addAction:defaultAction2];
        [self presentViewController:alert2 animated:YES completion:nil];
        
    } else {
    
        
        // *****************************Try the NSURLSession
        NSString *userUpdate = [NSString stringWithFormat:@"username=%@&password=%@&email=%@&user_type=%@&address_one=%@&address_two=%@&city=%@&state=%@&zip=%@&interests=%@", [self.usernameTextField text], protectedPass, [self.emailTextField text], [self.userTypeTextField text], [self.addressOneTextField text], [self.addressTwoTextField text], [self.cityTextField text], [self.stateTextField text], [self.zipTextField text], [self.interestsTextField text], nil];
        
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://hockd.co/hockd/public/api/v1/auth/signup"]];
        request.HTTPBody = [userUpdate dataUsingEncoding:NSUTF8StringEncoding];
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
            if ([msgCodeValue  isEqual:@"Successfully signup"]) {
                NSLog(@"got correct response");
                [self performSegueWithIdentifier:@"createAccountSegue" sender:self];
                
            } else /*if ((![msgCodeValue  isEqual: @"Successfully signup"])) */ {
                NSLog(@"failed to connect");
                
                NSString *message3 = [[NSString alloc] initWithFormat:@"Sorry"];
                UIAlertController *alert3 = [UIAlertController alertControllerWithTitle:message3 message:@"Email Already Exists On File" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* defaultAction3 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                       handler:^(UIAlertAction * action) {}];
                
                [alert3 addAction:defaultAction3];
                [self presentViewController:alert3 animated:YES completion:nil];
            }
        }];
        
        [postDataTask resume];
    }
}


- (IBAction)backButton:(UIButton *)sender {
}

- (IBAction)tapGestureRecognizer:(UITapGestureRecognizer *)sender {
}


@end
