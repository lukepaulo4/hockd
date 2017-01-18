//
//  AllItem.h
//  Hockd iOS App
//
//  Created by Luke Paulo on 1/17/17.
//  Copyright © 2017 HOCKD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;


@interface AllItem : NSObject

//Declare the initializer
- (instancetype) initWithDictionary:(NSDictionary *)allItemDictionary;

//List all the data this class should store about an 'item'
@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) User *user;

//For the media, should there be multiple media NSURLs or can it hold arrays of multiple NSURLs?
@property (nonatomic, strong) NSURL *imageOneURL;
@property (nonatomic, strong) UIImage *imageOne;
@property (nonatomic, strong) NSString *itemDescription;
@property (nonatomic, strong) NSString *manufacturer;
@property (nonatomic, strong) NSString *manufactureYear;
@property (nonatomic, strong) NSString *modelName;

/*Condition will be a dropdown menu of
 {
 Brand New/Unopened,
 Like New,
 Good,
 Fair,
 Poor/Inoperable,
 }
 It must be one of these. These will be the same options for Interests in the user profile.
 */
@property (nonatomic, strong) NSString *condition;

/*Category will be a dropdown menu of
 {
 Jewelery,
 Gold
 Electronics,
 Metal,
 Other
 }
 It must be one of these. These will be the same options for Interests in the user profile.
 */
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *otherComments;

//Should be NSString?
@property (nonatomic, strong) NSString *loanDesired;

//There should be 2 loan properties, as if the desired loan amount ends up changing, the amount will change. This make sense to have all 3 in this class? Then depending on the situation, only 1 will ever show? Squad
@property (nonatomic, strong) NSString *postedLoanAmount;
@property (nonatomic, strong) NSString *itemStatus;


@end
