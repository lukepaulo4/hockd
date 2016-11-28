//
//  ForgotPasswordViewController.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 8/21/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "ForgotPasswordViewController.h"

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
}

- (IBAction)backButton:(UIButton *)sender {
}

@end
