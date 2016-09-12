//
//  PinConstants.h
//  Hockd iOS App
//
//  Created by Luke Paulo on 9/11/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

//#import <Foundation/Foundation.h>
//
//@interface PinConstants : NSObject
//
//@end


//Creating a file that will contain strings that we'll use throughout the application

//Use for saving NSUserDefaults that a PIN has been set, and is the unique identifier for the Keychain
#define PIN_SAVED @"hasSavedPIN"

//Used for saving the user's name to NSUserDefaults. Why do we need this? Come back and revist as I don't think this wil be necessary. Basically we are just going to store the PIN, I think
#define USERNAME @"username"

//Used to specify the application used in accessing the Keychain
#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]

//Used to help secure the PIN. Ideally, this will be randomly generated, but to avoid the unnecessary complexity and overhead of storing the Salt separately, we will standardize on this key. WILL COME BACK AND SEPARATE THESE TWO WITH RANDOMIZATION LATER!!!!!!!!!!!
#define SALT_HASH @"FvtaRTinFKE76243jadfTINDMVK87654768q3465kjbdasjnHNF8fhjgferwAnfgd8765HD"

//Typedefs just to make it a little easier to read in code
typedef enum {
    kAlertTypePIN = 0,
    kAlertTypeSetup
} AlertTypes;

typedef enum {
    kTextFieldPIN = 1,
    kTextFieldName,
    kTextFieldPassword
} TextFieldTypes;
