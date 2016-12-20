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

@interface UpdatePasswordViewController ()

@property (weak, nonatomic) IBOutlet UILabel *updatePasswordLabel;
@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *updatedPasswordTextField;


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
        
        
        //Let's add some code so that when we POST we see what comes out on the other end...
    } else {
        
        
        /*
        NSString *encryptedPass = [AESCrypt encrypt:[self.usernameTextField text] password:[self.passwordTextField text]];
        NSString *protectedPass = encryptedPass;
        NSLog(@"Pass = %@", protectedPass);
        NSLog(@"Username = %@", self.usernameTextField);
        
        //NSDictionary *outputDict = @{};
        [[DataSource sharedInstance] loginWithUsername:self.usernameTextField.text password:protectedPass completionHandler:^(NSError *error, NSDictionary *returnedDict) {
            NSLog(@"DataSource Shared Instance got response==%@", returnedDict);
            
            [self loginCompletedWithDict:returnedDict];
            
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
         
         */
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

@end
