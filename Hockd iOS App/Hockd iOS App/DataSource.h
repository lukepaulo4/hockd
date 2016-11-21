//
//  DataSource.h
//  Hockd iOS App
//
//  Created by Luke Paulo on 8/31/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DataSource : NSObject

+(instancetype) sharedInstance;
@property (nonatomic, strong, readonly) NSArray *items;

+ (NSString *)postCallToSegue:(NSString *)api msgCode:(NSString *)msgCode userInput:(NSString *)userInput;

@end
