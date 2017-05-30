//
//  CredentialCheckViewController.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 11/7/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "CredentialCheckViewController.h"
#import "DataSource.h"
#import "LoginViewController.h"

//This View controller should determine if a pin has been created. If it has, then we can segue to the search/home view controller. If not, we will segue to the LoginViewController so that they can create
@interface CredentialCheckViewController ()

@end

@implementation CredentialCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    /*
    //create a data source so it can receive the access token notification
    if ([DataSource sharedInstance].accessToken) {
        
        dispatch_async(dispatch_get_main_queue(),   ^{
            [self performSegueWithIdentifier:@"GoToSearchViewController" sender:self];
        });
        
    } else if (![DataSource sharedInstance].accessToken) {
    
    //if have the access token, segue to Search VC
    [[NSNotificationCenter defaultCenter] addObserverForName:LoginViewControllerDidGetAccessTokenNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        dispatch_async(dispatch_get_main_queue(),   ^{
        [self performSegueWithIdentifier:@"GoToSearchViewController" sender:self];
        });
    }];
    

    dispatch_async(dispatch_get_main_queue(),   ^{
    [self performSegueWithIdentifier:@"GoToLoginViewController" sender:self];
    });
    }
    */
    
    [self performSegueWithIdentifier:@"GoToLoginViewController" sender:self];
    
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
