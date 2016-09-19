//
//  KeychainWrapper.h
//  Hockd iOS App
//
//  Created by Luke Paulo on 9/11/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

//This class is going to do 2 things: 1 - Handle read/writes to/from the keychain. 2 - Manage our encryption generation methods.

#import <Foundation/Foundation.h>
#import <Security/Security.h>
#import <CommonCrypto/CommonHMAC.h>

//Define an Obj-C wrapper class to hold Keychain Services Code
@interface KeychainWrapper : NSObject {
    NSMutableDictionary *keychainData;
    NSMutableDictionary *passwordQuery;
    NSMutableDictionary *usernameQuery;
}

@property (nonatomic, strong) NSMutableDictionary *keychainData;
@property (nonatomic, strong) NSMutableDictionary *passwordQuery;

//May need to come back and add the username to the keychain?
//@property (nonatomic, strong) NSMutableDictionary *usernameQuery;

@end



