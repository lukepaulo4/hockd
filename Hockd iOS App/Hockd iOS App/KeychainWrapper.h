//
//  KeychainWrapper.h
//  Hockd iOS App
//
//  Created by Luke Paulo on 11/7/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

//Define an Obj-C wrapper class to hold Keychain Services code.
@interface KeychainWrapper : NSObject

- (void)mySetObject:(id)inObject forKey:(id)key;
- (id)myObjectForKey:(id)key;
- (void)writeToKeychain;

@end
