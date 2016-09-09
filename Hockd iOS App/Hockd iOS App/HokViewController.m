//
//  HokViewController.m
//  Hokd iOS App
//
//  Created by Luke Paulo on 8/24/16.
//  Copyright © 2016 HOKD. All rights reserved.
//

#import "HokViewController.h"

@interface HokViewController ()

@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;

//How do I make this a drop down choice???????
@property (strong, nonatomic) IBOutlet UITextField *categoryTextField;
@property (strong, nonatomic) IBOutlet UILabel *itemDescriptionLabel;
@property (strong, nonatomic) IBOutlet UITextField *itemDescriptionTextField;
@property (strong, nonatomic) IBOutlet UILabel *manufactureLabel;
@property (strong, nonatomic) IBOutlet UITextField *manufactureTextField;
@property (strong, nonatomic) IBOutlet UILabel *manufactureYearLabel;
@property (strong, nonatomic) IBOutlet UITextField *manufactureYearTextField;
@property (strong, nonatomic) IBOutlet UILabel *modelNameLabel;
@property (strong, nonatomic) IBOutlet UITextField *modelNameTextField;
@property (strong, nonatomic) IBOutlet UILabel *conditionLabel;

//How do I make this a drop down choice???????
@property (strong, nonatomic) IBOutlet UITextField *conditionTextField;
@property (strong, nonatomic) IBOutlet UILabel *otherCommentsLabel;
@property (strong, nonatomic) IBOutlet UITextField *otherCommentsTextField;
@property (strong, nonatomic) IBOutlet UILabel *loanDesiredLabel;
@property (strong, nonatomic) IBOutlet UITextField *loanDesiredTextField;
@property (strong, nonatomic) IBOutlet UILabel *completeInfoLabel;



@end

@implementation HokViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Add the keyboards for each text field. **NOTE** I added keyboards for the category and condition text fields. However, I fully intend to make them drop downs!
    self.categoryTextField.delegate = self;
    self.itemDescriptionTextField.delegate = self;
    self.manufactureTextField.delegate = self;
    self.manufactureYearTextField.delegate = self;
    self.modelNameTextField.delegate = self;
    self.conditionTextField.delegate = self;
    self.otherCommentsTextField.delegate = self;
    self.loanDesiredTextField.delegate = self;
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

- (IBAction)addPhotoButton:(UIButton *)sender {
}

- (IBAction)categoryTextFieldDidChange:(UITextField *)sender {
}

- (IBAction)itemDescriptionTextFieldDidChange:(UITextField *)sender {
}

- (IBAction)manufactureTextFieldDidChange:(UITextField *)sender {
}

- (IBAction)manufactureYearTextFieldDidChange:(UITextField *)sender {
}

- (IBAction)modelNameTextFieldDidChange:(UITextField *)sender {
}

- (IBAction)conditionTextFieldDidChange:(UITextField *)sender {
}

- (IBAction)otherCommentsTextFieldDidChange:(UITextField *)sender {
}

- (IBAction)loanDesiredTextFieldDidChange:(UITextField *)sender {
}

- (IBAction)submitButton:(UIButton *)sender {
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
