//
//  CameraAccessViewController.h
//  Hockd iOS App
//
//  Created by Luke Paulo on 9/9/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraAccessViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)takePhotoButton:(UIButton *)sender;
- (IBAction)selectPhotoButton:(UIButton *)sender;


@end
