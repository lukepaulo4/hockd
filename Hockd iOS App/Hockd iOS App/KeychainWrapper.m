//
//  KeychainWrapper.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 9/11/16.
//  Copyright © 2016 HOCKD. All rights reserved.


#import "KeychainWrapper.h"
#import "PinConstants.h"


@implementation KeychainWrapper
//**This class is ARC compliant - any references to CF classes must be paired with a "__bride" statement to cast between Obj-C and Core Foundation Classes. WWDC 2011 Video "Introduction to Automatic Reference Counting" explains this.

//this sets up all the default parameters needed to easily reach keychain
+ (NSMutableDictionary *)setupSearchDirectoryForIdentifier:(NSString *)identifier {
    //setup dictionary to access keychain
    NSMutableDictionary *searchDictionary = [[NSMutableDictionary alloc] init];
    //specify we are using a password (rather than a certificate, internet password, etc)
    [searchDictionary setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    //Uniquely identify this keychain accessor.
    [searchDictionary setObject:@"co.hokd.iOSSecurityFTW" forKey:(__bridge id)kSecAttrService];
    
    //Uniquely identify the account who will be accessing the keychain
    NSData *encodedIdentifier = [identifier dataUsingEncoding:NSUTF8StringEncoding];
    [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrGeneric];
    [searchDictionary setObject:encodedIdentifier forKey:(__bridge id)kSecAttrAccount];
    
    return searchDictionary;
}

//Raw data method. Searches keychain for the value we're requesting, but it returns it as an NSData object
+ (NSData *)searchKeychainCopyMatchingIdentifier:(NSString *)identifier {
    
    NSMutableDictionary *searchDictionary = [self setupSearchDirectoryForIdentifier:identifier];
    //Limit search results to one.
    [searchDictionary setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    
    //specify we want NSData/CFData returned
    [searchDictionary setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    
    //search
    NSData *result = nil;
    CFTypeRef foundDict = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)searchDictionary, (CFTypeRef *)&foundDict);
    
    if (status == noErr) {
        result = (__bridge_transfer NSData *)foundDict;
    } else {
        result = nil;
    }
    
    return result;
    
}

//Really the method want to use for searching keychain, because it returns the value found as an NSString, which is much easier to compare against another input value (such as the password entered by user)
+ (NSString *)keychainStringFromMatchingIdentifier:(NSString *)identifier {
    NSData *valueData = [self searchKeychainCopyMatchingIdentifier:identifier];
    if (valueData) {
        NSString *value = [[NSString alloc] initWithData:valueData
                                                encoding:NSUTF8StringEncoding];
        return value;
    } else {
        return nil;
    }
}

//This will write to the keychain. SecItemAdd physically writes to the keychain
+ (BOOL)createKeychainValue:(NSString *)value forIdentifier:(NSString *)identifier {
    NSMutableDictionary *dictionary = [self setupSearchDirectoryForIdentifier:identifier];
    NSData *valueData = [value dataUsingEncoding:NSUTF8StringEncoding];
    
    //This is the actual data we are saving, which, in our case, is the hashed password from the user
    [dictionary setObject:valueData forKey:(__bridge id)kSecValueData];
    
    //Protect the keychain entry so it's only valid when the device is unlocked
    [dictionary setObject:(__bridge id)kSecAttrAccessibleWhenUnlocked forKey:(__bridge id)kSecAttrAccessible];
    
    //Add
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)dictionary, NULL);
    
    //If the addition was successful, return. Otherwise, attempt to update exisitng key or quit (return NO)
    if (status == errSecSuccess) {
        return YES;
    } else if (status == errSecDuplicateItem) {
        return [self updateKeychainValue:value forIdentifier:identifier];
    } else {
        return NO;
    }
}

//Similar to above but updates instead
+ (BOOL)updateKeychainValue:(NSString *)value forIdentifier:(NSString *)identifier {
    NSMutableDictionary *searchDictionary = [self setupSearchDirectoryForIdentifier:identifier];
    NSMutableDictionary *updateDictionary = [[NSMutableDictionary alloc] init];
    NSData *valueData = [value dataUsingEncoding:NSUTF8StringEncoding];
    [updateDictionary setObject:valueData forKey:(__bridge id)kSecValueData];
    
    //Update
    OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)searchDictionary,
                                    (__bridge CFDictionaryRef)updateDictionary);
    
    if (status == errSecSuccess) {
        return YES;
    } else {
        return NO;
    }
}

//simple delete method
+ (void)deleteItemFromKeychainWithIdentifier:(NSString *)identifier {
    NSMutableDictionary *searchDictionary = [self setupSearchDirectoryForIdentifier:identifier];
    CFDictionaryRef dictionary = (__bridge CFDictionaryRef)searchDictionary;
    
    //Delete
    SecItemDelete(dictionary);
}

//Compares the input value in SHA256 encrypted format to the view in the keychain
+(BOOL)compareKeychainValueForMatchingPIN:(NSUInteger)pinHash {
    if ([[self keychainStringFromMatchingIdentifier:PIN_SAVED] isEqualToString:[self securedSHA256DigestHashForPIN:pinHash]]) {
        return YES;
    } else {
        return NO;
    }
}

//This is where most of the magic happens (the rest happens in computeSHA256 method below
//Here we are passing in the hash of the PIN that the user entered so that we can avoid manually handling the PIN itself.
//Then we are extracting the username that the user supplied during setup, so that we can add another unique element to the hash
//From there we mash the user name, the passed-in PIN hash, and the secret key (from PinConstants.h) together to create one long, unique string.
//Then we send that entire hash mashup into the SHA256 method below to create a "Digital Digest," which is considered a one-way encryption algorithm. "one-way" means that it can never be reversed-engineered, only brute-force attacked.
//The algorithm we are using is Hash = SHA256(Name + Salt + (Hash(PIN))). This is called "Digest Authentication"

//This creates the value we are going to store in the keychain
+ (NSString *)securedSHA256DigestHashForPIN:(NSUInteger)pinHash {
    
    //1 - Get the name the user has entered. This is going to be paired with other values to uniquely create our key and add some extra security to it. Then we Percent Encode the name to avoid any attempted attacks with special characters, etc. The iOS Keychain is UTF8 compliant (only), so we baseline everything to that.
    NSString *name = [[NSUserDefaults standardUserDefaults] stringForKey:USERNAME];
    NSCharacterSet *set = [NSCharacterSet URLFragmentAllowedCharacterSet];
    name = [name stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    //2 - We piece together the user's name, the hash of the value they entered for their password, and the SALT_HASH string from our PinConstants class. A "salt hash is just an additional hash (remember, a hash is a fixed-length number based on a number or string) that can be used to augment and enhance the security of the password. Will need to go back and add a random generator for this later.
    NSString *computedHashString = [NSString stringWithFormat:@"%@%lu%@", name, (unsigned long)pinHash, SALT_HASH];
    
    //3 - Pass it over to our computeSHA256Digest method so that we can harden our password even more before storing it.
    NSString *finalHash = [self computeSHA256DigestForString:computedHashString];
    NSLog(@"** Computed hash: %@ for SHA256 Digest: %@", computedHashString, finalHash);
    return finalHash;
}

//Here we are taking in our string hash, placing that inside of a C Char Array, then aprsing it through the SHA256 encryption method
+ (NSString *)computeSHA256DigestForString:(NSString *)input {
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    //This is an iOS5-specified method
    //It takes in the data, how much data, and then output format, which in this case is an int array
    CC_SHA256(data.bytes, (unsigned int)data.length, digest);
    
    //Setup our Objective-C output
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    //Parse through the CC_SHA256 results (stored inside of digest[])
    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
    
}

@end


