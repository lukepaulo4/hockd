//
//  UpdateAccountViewController.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 12/7/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "UpdateAccountViewController.h"
#import "DataSource.h"
#import "TGCameraViewController.h"
#import <UICKeyChainStore.h>

@interface UpdateAccountViewController () <TGCameraDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *updateAccountLabel;
@property (strong, nonatomic) IBOutlet UIImageView *photoView;

@property (weak, nonatomic) IBOutlet UITextField *addressOneTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTwoTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (weak, nonatomic) IBOutlet UITextField *zipTextField;
@property (weak, nonatomic) IBOutlet UITextField *interestsTextField;


- (void)clearTapped;

@end

@implementation UpdateAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    
    NSString *tokenUploadedFromKC = [UICKeyChainStore stringForKey:@"access token"];
    NSLog(@"access token from keychain is = %@", tokenUploadedFromKC);
    
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
    
    /*
    NSData *imageData = UIImageJPEGRepresentation(_photoView.image, 1.0);
    NSString *encodedImageString = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSLog(@"Image Picker string is = %@", encodedImageString);
     */
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    NSLog(@"Image picker cancelled");
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (IBAction)updateProfilePicButtonPressed:(UIButton *)sender {
}

- (IBAction)chooseProfilePicButtonPressed:(UIButton *)sender {
}

- (IBAction)updateAccountButtonPressed:(UIButton *)sender {
    if ([[self.addressOneTextField text] isEqualToString:@""] && [[self.addressTwoTextField text] isEqualToString:@""] &&
        [[self.cityTextField text] isEqualToString:@""] && [[self.stateTextField text] isEqualToString:@""] && [[self.zipTextField text] isEqualToString:@""] && [[self.interestsTextField text] isEqualToString:@""]) {
        
        //add an alert stating the need to fill in the data
        NSString *message = [[NSString alloc] initWithFormat:@"Sorry:"];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:message message:@"At Least One Data Change Is Required" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    } else {
        
        //Need to do 2 things: First, get the values that these are currently at. If the text boxes aren't changed, then the values submitted should equal the existing values... Second, see below for the token access.
        
        //In here, extract the token value from the keychain
        NSString *token = [UICKeyChainStore stringForKey:@"access token"];
        NSString *userID = [UICKeyChainStore stringForKey:@"user id"];
        NSLog(@"access token from keychain is = %@", token);
        NSLog(@"user id from keychain is = %@", userID);
        
        [[DataSource sharedInstance] updateUserDetailsWithToken:token userId:(NSString*)userID addressOne:self.addressOneTextField.text addressTwo:self.addressTwoTextField.text city:self.cityTextField.text state:self.stateTextField.text zip:self.zipTextField.text interests:self.interestsTextField.text completionHandler:^(NSError *error, NSDictionary *returnedDict) {
            
            NSLog(@"DataSource Shared Instance got response==%@", returnedDict);
            
            [self updateAccountCompletedWithDict:returnedDict];
            
            //Extract the "msg_code" key's value.
            NSString *msgCodeValue = [returnedDict objectForKey:@"msg_code"];
            
            //Check what that value is!
            NSLog(@"message code in required area ==%@", msgCodeValue);
            
            //Now, if the message code reads "Successfully logged in" then segue to Home. Otherwise have them retry.
            if ([msgCodeValue  isEqual:@"successfully updated"]) {
                NSLog(@"got correct response");
                
                //add a dispatch async to get rid of bug message
                dispatch_async(dispatch_get_main_queue(),   ^{
                    
                    
                    //After an account updates, probably just needs to stay on the page. No real need to go anywhere else?
                    //[self performSegueWithIdentifier:@"createAccountSegue" sender:self];
                    
                });
                
            } else {
                
                dispatch_async(dispatch_get_main_queue(),   ^{
                    
                    NSLog(@"failed to connect");
                    
                    NSString *message3 = [[NSString alloc] initWithFormat:@"Sorry"];
                    UIAlertController *alert3 = [UIAlertController alertControllerWithTitle:message3 message:@"Error Occurred" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction* defaultAction3 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                           handler:^(UIAlertAction * action) {}];
                    
                    [alert3 addAction:defaultAction3];
                    [self presentViewController:alert3 animated:YES completion:nil];
                    
                });
            }
        }];
        
        
        
    }
    
}

- (void)updateAccountCompletedWithDict:(NSDictionary*)dict {
    NSLog(@"got response in method==%@", dict);
}


- (IBAction)updatePasswordButtonPressed:(UIButton *)sender {
}

- (IBAction)backButtonPressed:(UIButton *)sender {
}


- (IBAction)tapGestureRecognizer:(UITapGestureRecognizer *)sender {
}

@end
