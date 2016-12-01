//
//  ForgotPasswordViewController.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 8/21/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "DataSource.h"

@interface ForgotPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *enterEmailTextField;
@property (weak, nonatomic) IBOutlet UILabel *forgotPasswordLabel;


@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.enterEmailTextField.delegate = self;
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

- (IBAction)enterEmailTextDidChange:(UITextField *)sender {
}

- (IBAction)sendTempPassButton:(UIButton *)sender {
    
    //If there is nothing for username and password text fields when hit login...
    if ([[self.enterEmailTextField text] isEqualToString:@""]) {
        
        //add an alert stating the need to add a username and password
        NSString *message = [[NSString alloc] initWithFormat:@"Sorry"];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:@"Email Required" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        
        //Let's add some code so that when we POST we see what comes out on the other end...
    } else {
        
        [[DataSource sharedInstance] forgotPasswordWithEmail:self.enterEmailTextField.text  completionHandler:^(NSError *error, NSDictionary *returnedDict) {
            NSLog(@"DataSource Shared Instance got response==%@", returnedDict);
            
            [self forgotPasswordCompletedWithDict:returnedDict];
            
            //Extract the "msg_code" key's value.
            NSString *msgCodeValue = [returnedDict objectForKey:@"msg_code"];
            
            //Check what that value is!
            //NOTE******** Need to get the API working so I know what it's suppsoed to say..
            NSLog(@"message code in required area ==%@", msgCodeValue);
            
            //Now, if the message code reads "Successfully logged in" then segue to Home. Otherwise have them retry.
            if ([msgCodeValue  isEqual:@"Successfully logged in"]) {
                NSLog(@"got correct response");
                
                
                //add a dispatch async to get rid of bug message
                dispatch_async(dispatch_get_main_queue(),   ^{
                    
                    //Once API working, maybe make a new login page where you can log in with the new password.
                    [self performSegueWithIdentifier:@"loginSegue" sender:self];
                    
                });
                
                
            } else {
                NSLog(@"failed to connect");
                
                dispatch_async(dispatch_get_main_queue(),   ^{
                    
                    NSString *message3 = [[NSString alloc] initWithFormat:@"Sorry"];
                    UIAlertController *alert3 = [UIAlertController alertControllerWithTitle:message3 message:@"Email not on file" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* defaultAction3 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                           handler:^(UIAlertAction * action) {}];
                    
                    [alert3 addAction:defaultAction3];
                    [self presentViewController:alert3 animated:YES completion:nil];
                    
                });
            }
        }];
    }
}

- (void)forgotPasswordCompletedWithDict:(NSDictionary*)dict {
    NSLog(@"got response in method==%@", dict);
}


- (IBAction)backButton:(UIButton *)sender {
}

@end
