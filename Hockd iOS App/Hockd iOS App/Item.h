//
//  Item.h
//  Hockd iOS App
//
//  Created by Luke Paulo on 8/31/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;


typedef NS_ENUM(NSUInteger, ItemStatus) {
    submittedForReview,
    postedForLoan,
    loanInitiated,
    loanRepayed,
    loanFaulted,
    postedForSale
};

@interface Item : NSObject

//Declare the initializer
- (instancetype) initWithDictionary:(NSDictionary *)itemDictionary;

//List all the data this class should store about an 'item'
@property (nonatomic, strong) NSString *idNumber;
@property (nonatomic, strong) User *user;

//For the media, should there be multiple media NSURLs or can it hold arrays of multiple NSURLs?
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) UIImage *image;
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
    Gold/Gems,
    Electronics,
    Instruments,
    Antiques,
    Sports Memorabilia,
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

//How call this from the dictionary if it's enum?
//@property (nonatomic, assign) ItemStatus status;

@end



//Used a online tutorial for the following. Switched to follow the bloc strategy...
//// API & data stuff
//@property (nonatomic, strong) NSMutableArray *myItems;
//
////Default initializer - put jsonFileName for now. We need to look it up and find later!! On github?
//- (id)initWithJSONFromFile:(NSString *)jsonFileName;
//
////helper method that ensures a default pic for users who don't specify a new pic. Good for sim testing as we can't access camera but will take out once running on an actual device.
//- (void)writeDefaultImageToDocuments;
//
////Writes JSON file to disk, using Data Protection API
//- (void)saveMyItems;
//
////Should someone delete an item, we can remove it directly, then save the new list to disk (saveMyItems). Should they be able to delete an item though is the question???
////- (void)removeItemAtIndexPath:(NSIndexPath *)indexPath;
//
////Should someone add an item, we can add it directly, then save the new list to disk (saveMyItems)
//- (void)addItemToMyItems:(NSDictionary *)newItem;
//
////Accessor method to retrieve the saved images for a given item
//- (UIImage *)imageForItemAtIndex:(NSIndexPath *)indexPath;
//
////Accessor method to retrieve the saved category for a given item
//- (NSString *)categoryForItemAtIndex:(NSIndexPath *)indexPath;
//
////Accessor method to retrieve the saved description for a given item
//- (NSString *)itemDescriptionForItemAtIndex:(NSIndexPath *)indexPath;
//
////Accessor method to retrieve the saved manufacturer for a given item
//- (NSString *)manufacturerForItemAtIndex:(NSIndexPath *)indexPath;
//
////Accessor method to retrieve the saved manufacture year for a given item
//- (NSString *)manufactureYearForItemAtIndex:(NSIndexPath *)indexPath;
//
////Accessor method to retrieve the saved model name for a given item
//- (NSString *)modelNameForItemAtIndex:(NSIndexPath *)indexPath;
//
////Accessor method to retrieve the saved condition for a given item
//- (NSString *)conditionForItemAtIndex:(NSIndexPath *)indexPath;
//
////Accessor method to retrieve the saved other comments for a given item
//- (NSString *)otherCommentsForItemAtIndex:(NSIndexPath *)indexPath;
//
////Accessor method to retrieve the saved loan desired for a given item
//- (NSString *)loanDesiredForItemAtIndex:(NSIndexPath *)indexPath;
//
////Accessor method to retrieve the saved posted loan amount for a given item
//- (NSString *)postedLoanAmountForItemAtIndex:(NSIndexPath *)indexPath;
//
////Accessor method to retrieve the saved agreed loan amount for a given item
//- (NSString *)agreedLoanAmountForItemAtIndex:(NSIndexPath *)indexPath;
//
////Accessor method to retrieve the saved item status for a given item
//- (NSString *)itemStatusForItemAtIndex:(NSIndexPath *)indexPath;
//
//@end












