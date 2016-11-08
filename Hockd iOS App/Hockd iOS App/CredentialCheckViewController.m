//
//  CredentialCheckViewController.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 11/7/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "CredentialCheckViewController.h"


//This View controller should determine if a pin has been created. If it has, then we can segue to the search/home view controller. If not, we will segue to the LoginViewController so that they can create
@interface CredentialCheckViewController ()

@end

@implementation CredentialCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //Then eval if we have this BOOL or not. If we do, that means the user has launched this app before and gone through the login process. In which case we send they ass to the SearchViewController. If not, we send them to the LoginViewController.
    //if () {
    [self performSegueWithIdentifier:@"GoToLoginViewController" sender:self];
    //    } else {
    //        //Segue to Login view controller
    //        [self performSegueWithIdentifier:@"GoToSearchViewController" sender:self];
    //    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
