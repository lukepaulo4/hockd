//
//  CameraAccessViewController.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 9/9/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "CameraViewController.h"
#import <AVFoundation/AVFoundation.h>



@interface CameraViewController ()

@end


@implementation CameraViewController

#pragma mark - Build View Hierarchy

//Long setup. Split viewDidLoad into 4 sessions:
//1. Creating all views     2. Adding the views to the view hierarchy    3. Setting up IMage Capture      4. Creating a Cancel button in the toolbar
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

}

//Add this in case user doens't want to take a photo
- (void) createCancelButton {

}



@end
