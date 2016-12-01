//
//  CreateAccountViewController.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 11/7/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "CreateAccountViewController.h"
#import "DataSource.h"
#import "AESCrypt.h"
#import "TGCameraViewController.h"

//Create below class then implement here
//#import "CreateAccount.h"

@interface CreateAccountViewController () <TGCameraDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *retypePasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *userTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressOneTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTwoTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (weak, nonatomic) IBOutlet UITextField *zipTextField;
@property (weak, nonatomic) IBOutlet UITextField *interestsTextField;

@property (weak, nonatomic) IBOutlet UILabel *createAccountLabel;

@property (strong, nonatomic) IBOutlet UIImageView *photoView;


- (void)clearTapped;

@end

@implementation CreateAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.retypePasswordTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.userTypeTextField.delegate = self;
    self.addressOneTextField.delegate = self;
    self.addressTwoTextField.delegate = self;
    self.cityTextField.delegate = self;
    self.stateTextField.delegate = self;
    self.zipTextField.delegate = self;
    self.interestsTextField.delegate = self;
    
    // set custom tint color
    //[TGCameraColor setTintColor: [UIColor greenColor]];
    
    // save image to album
    [TGCamera setOption:kTGCameraOptionSaveImageToAlbum value:[NSNumber numberWithBool:YES]];
    
    // hide switch camera button
    //[TGCamera setOption:kTGCameraOptionHiddenToggleButton value:[NSNumber numberWithBool:YES]];
    
    // hide album button
    //[TGCamera setOption:kTGCameraOptionHiddenAlbumButton value:[NSNumber numberWithBool:YES]];
    
    // hide filter button
    [TGCamera setOption:kTGCameraOptionHiddenFilterButton value:[NSNumber numberWithBool:YES]];
    
    _photoView.clipsToBounds = YES;
    
    UIBarButtonItem *clearButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                 target:self
                                                                                 action:@selector(clearTapped)];
    
    self.navigationItem.rightBarButtonItem = clearButton;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark - TGCameraDelegate required

- (void)cameraDidCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cameraDidTakePhoto:(UIImage *)image
{
    _photoView.image = image;

    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    NSString *encodedImageString = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSLog(@"Taken photo string is = %@", encodedImageString);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cameraDidSelectAlbumPhoto:(UIImage *)image
{
    _photoView.image = image;
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    NSString *encodedImageString = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSLog(@"Selected photo string is = %@", encodedImageString);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark - TGCameraDelegate optional

- (void)cameraWillTakePhoto
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)cameraDidSavePhotoAtPath:(NSURL *)assetURL
{
    NSLog(@"%s album path: %@", __PRETTY_FUNCTION__, assetURL);
}

- (void)cameraDidSavePhotoWithError:(NSError *)error
{
    NSLog(@"%s error: %@", __PRETTY_FUNCTION__, error);
}

#pragma mark -
#pragma mark - Actions

- (IBAction)takePhotoTapped
{
    TGCameraNavigationController *navigationController = [TGCameraNavigationController newWithCameraDelegate:self];
    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark -
#pragma mark - Private methods

- (void)clearTapped
{
    _photoView.image = nil;
    NSLog(@"Image is nil");
}


//Choose pic stuff. Need to initialize and set the Camera Navigation Controller though... It is not in window hierarchy....
- (IBAction)chooseExistingPhotoTapped
{
    UIImagePickerController *pickerController =
    [TGAlbum imagePickerControllerWithDelegate:self];
    
    [self presentViewController:pickerController animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _photoView.image = [TGAlbum imageWithMediaInfo:info];
    
    NSData *imageData = UIImageJPEGRepresentation(_photoView.image, 1.0);
    NSString *encodedImageString = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSLog(@"Image Picker string is = %@", encodedImageString);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    NSLog(@"Image picker cancelled");
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (IBAction)userTypeTextFieldDidChange:(UITextField *)sender {
    if ([self.userTypeTextField.text length] > 0) {
    }
}

- (IBAction)addressOneTextFieldDidChange:(UITextField *)sender {
    if ([self.addressOneTextField.text length] > 0) {
    }
}

- (IBAction)addressTwoTextFieldDidChange:(UITextField *)sender {
    if ([self.addressTwoTextField.text length] > 0) {
    }
}

- (IBAction)cityTextFieldDidChange:(UITextField *)sender {
    if ([self.cityTextField.text length] > 0) {
    }
}

- (IBAction)stateTextFieldDidChange:(UITextField *)sender {
    if ([self.stateTextField.text length] > 0) {
    }
}

- (IBAction)zipTextFieldDidChange:(UITextField *)sender {
    if ([self.zipTextField.text length] > 0) {
    }
}

- (IBAction)interestsTextFieldDidChange:(UITextField *)sender {
    if ([self.interestsTextField.text length] > 0) {
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
    
    //let's salt and hash that password text box
    //NSString *salt = [AESCrypt genRandStringLength:25];
    NSString *encryptedPass = [AESCrypt encrypt:[self.usernameTextField text] password:[self.passwordTextField text]];
    NSString *protectedPass = encryptedPass;
    
    NSString *encryptedRetypePass = [AESCrypt encrypt:[self.usernameTextField text] password:[self.retypePasswordTextField text]];
    NSString *protectedRetypePass = encryptedRetypePass;
    
    NSLog(@"Pass = %@", protectedPass);
    NSLog(@"Pas2 = %@", protectedRetypePass);
    
    //First, if any of the text fields aren't filled in, don't let them pass. Except address line 2. Don't need that one.
    if ([[self.usernameTextField text] isEqualToString:@""]  || [[self.passwordTextField text] isEqualToString:@""] || [[self.retypePasswordTextField text] isEqualToString:@""] || [[self.emailTextField text] isEqualToString:@""] || [[self.userTypeTextField text] isEqualToString:@""] || [[self.addressOneTextField text] isEqualToString:@""] || [[self.cityTextField text] isEqualToString:@""] || [[self.stateTextField text] isEqualToString:@""] || [[self.zipTextField text] isEqualToString:@""] || [[self.interestsTextField text] isEqualToString:@""]) {
        
        //add an alert stating the need to fill in the data
        NSString *message = [[NSString alloc] initWithFormat:@"Sorry:"];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:@"All Data Fields Required Except Address 2" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        
        //Let's add some code so that when we POST we see what comes out on the other end...
    } else if (![protectedPass isEqualToString:(protectedRetypePass)]) {
        
        //password retype doesn't equal password, let them know passwords don't match.  Look into a method later so that instead of a pop up, there is an indicator that shows a green check when the password in the retype box matches.
        NSString *message2 = [[NSString alloc] initWithFormat:@"Try Again:"];
        UIAlertController *alert2 = [UIAlertController alertControllerWithTitle:message2 message:@"Passwords Did Not Match" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert2 addAction:defaultAction2];
        [self presentViewController:alert2 animated:YES completion:nil];
        
    } else {
        
        [[DataSource sharedInstance] createAccountWithUsername:self.usernameTextField.text password:protectedPass email:self.emailTextField.text userType:self.userTypeTextField.text addressOne:self.addressOneTextField.text addressTwo:self.addressTwoTextField.text city:self.cityTextField.text state:self.stateTextField.text zip:self.zipTextField.text interests:self.interestsTextField.text completionHandler:^(NSError *error, NSDictionary *returnedDict) {
        
            NSLog(@"DataSource Shared Instance got response==%@", returnedDict);
            
            [self createAccountCompletedWithDict:returnedDict];
            
            //Extract the "msg_code" key's value.
            NSString *msgCodeValue = [returnedDict objectForKey:@"msg_code"];
            
            //Check what that value is!
            NSLog(@"message code in required area ==%@", msgCodeValue);
            
            //Now, if the message code reads "Successfully logged in" then segue to Home. Otherwise have them retry.
            if ([msgCodeValue  isEqual:@"Successfully signup"]) {
                NSLog(@"got correct response");
                
                //add a dispatch async to get rid of bug message
                dispatch_async(dispatch_get_main_queue(),   ^{
                    
                    [self performSegueWithIdentifier:@"createAccountSegue" sender:self];
                    
                });
                
            } else {
                
                dispatch_async(dispatch_get_main_queue(),   ^{
                
                NSLog(@"failed to connect");
                
                NSString *message3 = [[NSString alloc] initWithFormat:@"Sorry"];
                UIAlertController *alert3 = [UIAlertController alertControllerWithTitle:message3 message:@"Email Already Exists On File" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* defaultAction3 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                       handler:^(UIAlertAction * action) {}];
                
                [alert3 addAction:defaultAction3];
                [self presentViewController:alert3 animated:YES completion:nil];
                    
                });
            }
        }];
    }
}


- (void)createAccountCompletedWithDict:(NSDictionary*)dict {
    NSLog(@"got response in method==%@", dict);
}


- (IBAction)backButton:(UIButton *)sender {
}

- (IBAction)tapGestureRecognizer:(UITapGestureRecognizer *)sender {
}


@end
