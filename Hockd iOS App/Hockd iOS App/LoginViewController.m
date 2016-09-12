//
//  ViewController.m
//  Hokd iOS App
//
//  Created by Luke Paulo on 8/14/16.
//  Copyright © 2016 HOKD. All rights reserved.
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
        [[NSUserDefaults standardUserDefaults] setValue:self.usernameTextField.text forKey:USERNAME];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (IBAction)passwordTextFieldDidChange:(UITextField *)sender {
    if ([self.passwordTextField.text length] > 0) {
        NSUInteger fieldHash = [self.passwordTextField.text hash];
        NSString *fieldString = [KeychainWrapper securedSHA256DigestHashForPIN:fieldHash];
        NSLog(@"** Password Hash - %@", fieldString);
    //Save PIN hash to the keychain NEVER store the direct PIN
    if ([KeychainWrapper createKeychainValue:fieldString forIdentifier:PIN_SAVED]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:PIN_SAVED];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSLog(@"** Key saved successfully to Keychain!!");
        }
    }
}


- (IBAction)submitButtonPressed:(UIButton *)sender {
}

- (IBAction)createAccountButtonPressed:(UIButton *)sender {
}

- (IBAction)forgotPasswordButtonPressed:(UIButton *)sender {
}

- (IBAction)tapGestureDidFire:(UITapGestureRecognizer *)sender {
}

@end
