//
//  CameraAccessViewController.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 9/9/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "CameraAccessViewController.h"

@interface CameraAccessViewController ()

@end

//This is a pretty BAB way to do it. I like the way we set up the camera in Blocstagram better. So go back through and use that as it looks way better. But this should hold for now while you upload data and check to make sure APIs work to sign in and upload a HOK item. 9/9/16
@implementation CameraAccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //If there is no camera and we don't want app to crash (like in simulator) we need this code....
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertController *cameraAlertView = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                  message:@"Device has no camera :(" preferredStyle:UIAlertControllerStyleAlert];
                                              
        UIAlertAction* cancelButton = [UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                             }];
        [cameraAlertView addAction:cancelButton];
         
        [self presentViewController:cameraAlertView animated:YES completion:nil];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Create a picker controller. Want the camera picker since we are taking a photo
- (IBAction)takePhotoButton:(UIButton *)sender {
    
    //Again, so app don't crash, give warning message if no camera available
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertController *cameraAlertView = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                 message:@"Device has no camera :(" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* cancelButton = [UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                             }];
        [cameraAlertView addAction:cancelButton];
        
        [self presentViewController:cameraAlertView animated:YES completion:nil];
        
    } else {
    
        //Then let the picker code kick!!
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    }
}

//Create a picker controller for the photo library
- (IBAction)selectPhotoButton:(UIButton *)sender {
    
    //Again, so app don't crash, give warning if no camera available on device
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertController *cameraAlertView = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                 message:@"Device has no camera :(" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* cancelButton = [UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                             }];
        [cameraAlertView addAction:cancelButton];
        
        [self presentViewController:cameraAlertView animated:YES completion:nil];
        
    } else {
    
        //Then slay with that code!!!!!!!!!!!
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
        
    }
}

//Since we allowed for image resizing (allowsEditing = YES) the didFinishPickingMediaWithInfo method is called. As the first argument we have the picker who called the method, something very useful if we have more than one image picker, but since we dont yet, we ignore it. **NOTE** if add one for profile pic, need to come back to this!!! Second argument is the NSDictionary which contains, among other things, the original image and edited image.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

//If user cancels operation by touching the 'Cancel' button of the image picker view, we have this method.
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
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
