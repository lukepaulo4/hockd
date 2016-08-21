//
//  ViewController.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 8/14/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "LoginViewController.h"

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
    NSString *usernameText = sender.text;
}

- (IBAction)passwordTextFieldDidChange:(UITextField *)sender {
    NSString *passwordText = sender.text;
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
