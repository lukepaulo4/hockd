//
//  Item.h
//  Hokd iOS App
//
//  Created by Luke Paulo on 8/31/16.
//  Copyright © 2016 HOKD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class User;


typedef NS_ENUM(NSUInteger, ItemStatus) {
    inReview,
    posted,
    receivedOffer,
    underPawn,
    pawnRepayed,
    pawnFaulted
};

@interface Item : NSObject

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

//What should loanDesired be? Is there a class that is indicative of what this should be? When thinking of similar applications where you can insert a $$ amount, it usually only allows you to put a number then the text box says $200 or whatever you selected. So maybe there is a special textbox that will only allow a number to be put it, but then that can be read as a string?
@property (nonatomic, strong) NSString *loanDesired;

//There should be 2 loan properties, as if the desired loan amount ends up changing, the amount will change. This make sense to have all 3 in this class? Then depending on the situation, only 1 will ever show?
@property (nonatomic, strong) NSString *postedLoanAmount;
@property (nonatomic, strong) NSString *agreedLoanAmount;

/*Item status will be an array of 6 options, including
{
    itemInReview,
    itemPosted,
    itemReceivedOffer,
    itemUnderPawn,
    itemPawnRepayed,
    itemPawnFaulted
}
 Should these be represented and set equal to #s? Similar to how we did the Like status? This way can easily write if/for statements? Or probably define them as strings here, then can set to #s in the implementation?
 */
@property (nonatomic, assign) ItemStatus status;


@end
