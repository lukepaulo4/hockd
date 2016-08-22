//
//  ForgotPasswordViewController.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 8/21/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "ForgotPasswordViewController.h"

@interface ForgotPasswordViewController ()
@property (weak, nonatomic) IBOutlet UILabel *forgotPasswordLabel;
@property (weak, nonatomic) IBOutlet UILabel *securityQuestionLabel;
@property (weak, nonatomic) IBOutlet UILabel *enterEmailLabel;
@property (weak, nonatomic) IBOutlet UITextField *securityQuestionTextField;
@property (weak, nonatomic) IBOutlet UITextField *enterEmailTextField;

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.securityQuestionTextField.delegate = self;
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

- (IBAction)securityQuestionTextDidChange:(UITextField *)sender {
}

- (IBAction)enterEmailTextDidChange:(UITextField *)sender {
}

- (IBAction)sendTempPassButton:(UIButton *)sender {
}

- (IBAction)backButton:(UIButton *)sender {
}

- (IBAction)tapGestureDidFire:(UITapGestureRecognizer *)sender {
}

@end
