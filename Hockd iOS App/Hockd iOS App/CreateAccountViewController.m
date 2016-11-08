//
//  CreateAccountViewController.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 11/7/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "CreateAccountViewController.h"
#import "DataSource.h"


//Create below class then implement here
//#import "CreateAccount.h"

@interface CreateAccountViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *retypePasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
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
}

- (IBAction)backButton:(UIButton *)sender {
}

- (IBAction)tapGestureRecognizer:(UITapGestureRecognizer *)sender {
}


@end
