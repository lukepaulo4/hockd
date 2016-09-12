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

@interface KeychainWrapper : NSObject

//Generic exposed method to search the keychain for a given value. Limit one result per search
+ (NSData *)searchKeychainCopyMatchingIdentifier:(NSString *)identifier;

//Calls searchKeychainCopyMatchingIdentifier: and converts to a string value
+ (NSString *)keychainStringFromMatchingIdentifier:(NSString *)identifier;

//Simple method to compare a passed in hash value with what is stored in the keychain. Optionally, we could adjust this method to take in the keychain key to look up the value.
+ (BOOL)compareKeychainValueForMatchingPIN:(NSUInteger)pinHASH;

//Default initializer to store a value in the keychain.
//Associated properties are handled for you - setting Data Protection Access, Company Identifier (to uniquely identify string, etc)
+ (BOOL)createKeychainValue:(NSString *)value forIdentifier:(NSString *)identifier;

//Update a value in the keychain. If you try to set the value with createKeychainValue: and it already exists, this method is called instead to update the value in place
+ (BOOL)updateKeychainValue:(NSString *)value forIdentifier:(NSString *)identifier;

//Delete a value in the keychain
+ (void)deleteItemFromKeychainWithIdentifier:(NSString *)identifier;

//Generates an SHA256 (much more secure than MD5) hash
+ (NSString *)securedSHA256DigestHashForPIN:(NSUInteger)pinHash;
+ (NSString *)computeSHA256DigestForString:(NSString *)input;


@end



