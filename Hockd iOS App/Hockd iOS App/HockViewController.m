//
//  HockViewController.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 8/24/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "HockViewController.h"
#import "TGCameraViewController.h"
#import "DataSource.h"


@interface HockViewController () <TGCameraDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>



@property (strong, nonatomic) IBOutlet UITextField *categoryTextField;
@property (strong, nonatomic) IBOutlet UITextField *itemDescriptionTextField;
@property (strong, nonatomic) IBOutlet UITextField *manufactureTextField;
@property (strong, nonatomic) IBOutlet UITextField *manufactureYearTextField;
@property (strong, nonatomic) IBOutlet UITextField *modelNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *conditionTextField;
@property (strong, nonatomic) IBOutlet UITextField *otherCommentsTextField;
@property (strong, nonatomic) IBOutlet UITextField *loanDesiredTextField;
@property (strong, nonatomic) IBOutlet UILabel *completeInfoLabel;



- (void)clearTapped;

@end

@implementation HockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.categoryTextField.delegate = self;
    self.itemDescriptionTextField.delegate = self;
    self.manufactureTextField.delegate = self;
    self.manufactureYearTextField.delegate = self;
    self.modelNameTextField.delegate = self;
    self.conditionTextField.delegate = self;
    self.otherCommentsTextField.delegate = self;
    self.loanDesiredTextField.delegate = self;
    
  //****PICKER CODE TO IMPLEMENT LATER
//    //Initialize the picker data
//    categoryPickerData = @[@"Jewelery", @"Gold/Precious Metals", @"Electronics", @"Instruments", @"Sports Memorabilia", @"Other"];
//    
//    //Connect Data
//    self.categoryPicker.dataSource = self;
//    self.categoryPicker.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//**PICKER CODE TO IMPLEMENT LATER
////The number of columns of data for the picker
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
//    return 1;
//}
//
////The number of rows of data
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
//    return categoryPickerData.count;
//}
//
////The data to return for the row and component (column) that's being passed in
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    return categoryPickerData[row];
//}

//Implement the UITextFieldDelegate protocol method.
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder]; //dismisses the keyboard
    return YES;
}

- (IBAction)addPhotoButton:(UIButton *)sender {
    
    
    
}

- (IBAction)categoryTextFieldDidChange:(UITextField *)sender {
    if ([self.categoryTextField.text length] > 0) {
    }
}

- (IBAction)itemDescriptionTextFieldDidChange:(UITextField *)sender {
    if ([self.itemDescriptionTextField.text length] > 0) {
    }
}

- (IBAction)manufactureTextFieldDidChange:(UITextField *)sender {
    if ([self.manufactureTextField.text length] > 0) {
    }
}

- (IBAction)manufactureYearTextFieldDidChange:(UITextField *)sender {
    if ([self.manufactureYearTextField.text length] > 0) {
    }
}

- (IBAction)modelNameTextFieldDidChange:(UITextField *)sender {
    if ([self.modelNameTextField.text length] > 0) {
    }
}

- (IBAction)conditionTextFieldDidChange:(UITextField *)sender {
    if ([self.conditionTextField.text length] > 0) {
    }
}

- (IBAction)otherCommentsTextFieldDidChange:(UITextField *)sender {
    if ([self.otherCommentsTextField.text length] > 0) {
    }
}

- (IBAction)loanDesiredTextFieldDidChange:(UITextField *)sender {
    if ([self.loanDesiredTextField.text length] > 0) {
    }
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
