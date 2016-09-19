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

@property (strong, nonatomic) IBOutlet UITextField *conditionTextField;
@property (strong, nonatomic) IBOutlet UILabel *otherCommentsLabel;
@property (strong, nonatomic) IBOutlet UITextField *otherCommentsTextField;
@property (strong, nonatomic) IBOutlet UILabel *loanDesiredLabel;
@property (strong, nonatomic) IBOutlet UITextField *loanDesiredTextField;
@property (strong, nonatomic) IBOutlet UILabel *completeInfoLabel;

//initialize the strings
@property (strong, nonatomic) NSString *categoryString;
@property (strong, nonatomic) NSString *itemDescriptionString;
@property (strong, nonatomic) NSString *manufacturerString;
@property (strong, nonatomic) NSString *manufacturerYearString;
@property (strong, nonatomic) NSString *modelNameString;
@property (strong, nonatomic) NSString *conditionString;
@property (strong, nonatomic) NSString *otherCommentsString;
@property (strong, nonatomic) NSString *loanDesiredString;
@property (strong, nonatomic) NSString *postedLoanAmountString;
@property (strong, nonatomic) NSString *agreedLoanAmountString;
@property (strong, nonatomic) NSString *itemStatusString;
@property (strong, nonatomic) NSString *jsonMsg;


@end

@implementation HokViewController

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
    self.categoryTextField.text = self.categoryString;
}

- (IBAction)itemDescriptionTextFieldDidChange:(UITextField *)sender {
    self.itemDescriptionTextField.text = self.itemDescriptionString;
}

- (IBAction)manufactureTextFieldDidChange:(UITextField *)sender {
    self.manufactureTextField.text = self.manufacturerString;
}

- (IBAction)manufactureYearTextFieldDidChange:(UITextField *)sender {
    self.manufactureYearTextField.text = self.manufacturerYearString;
}

- (IBAction)modelNameTextFieldDidChange:(UITextField *)sender {
    self.modelNameTextField.text = self.modelNameString;
}

- (IBAction)conditionTextFieldDidChange:(UITextField *)sender {
    self.conditionTextField.text = self.conditionString;
}

- (IBAction)otherCommentsTextFieldDidChange:(UITextField *)sender {
    self.otherCommentsTextField.text = self.otherCommentsString;
}

- (IBAction)loanDesiredTextFieldDidChange:(UITextField *)sender {
    self.loanDesiredTextField.text = self.loanDesiredString;
}

- (IBAction)submitButton:(UIButton *)sender {
    //creates these as nils since they won't have values yet
    NSString *postedLoanAmountString= nil;
    NSString *agreedLoanAmountString= nil;
    NSString *itemStatusString= nil;
    
    // Create the request.
    NSURL *url = [NSURL URLWithString: @"http://private-6d370-newpawnitem1.apiary-mock.com/"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // Specify that it will be a POST request
    request.HTTPMethod = @"POST";
    
    // This is how we set header fields
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    // Convert your data and set your request's HTTPBody property
    NSArray *objects = [[NSArray alloc] initWithObjects:@categoryString,@itemDescriptionString,@manufacturerString,@manufacturerYearString,@modelNameString,@conditionString, @otherCommentsString,@loanDesiredString,postedLoanAmountString, @agreedLoanAmountString, @itemStatusString, nil];
    
    NSArray *keys = [[NSArray alloc] initWithObjects:@"category",@"itemDescription",@"manufacturer",@"manufacturerYear",@"modelName",@"condition", @"otherComments",@"loanDesired",@"postedLoanAmount",@"agreedLoanAmount",@"itemStatus", nil];
    
    NSDictionary *tempJsonData = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    
    NSDictionary *finalJsonData = [[NSDictionary alloc] initWithObjectsAndKeys:tempJsonData,@"customer", nil];
    
    NSData *temp = [NSJSONSerialization dataWithJSONObject:finalJsonData options:NSJSONWritingPrettyPrinted error:nil];
    
    request.HTTPBody = temp;
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
    NSError *error = nil; NSURLResponse *response = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

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
