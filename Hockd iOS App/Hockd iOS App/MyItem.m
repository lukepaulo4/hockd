//
//  Item.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 8/31/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "MyItem.h"
#import "User.h"


@implementation MyItem

- (instancetype) initWithDictionary:(NSDictionary *)itemDictionary {
    self = [super init];
    
    if (self) {
        self.idNumber = itemDictionary[@"itemId"];
        self.user = [[User alloc] initWithDictionary:itemDictionary[@"user"]];
        self.itemDescription = itemDictionary[@"itemDescription"];
        self.manufacturer = itemDictionary[@"manufacturer"];
        self.manufactureYear = itemDictionary[@"manufactureYear"];
        self.modelName = itemDictionary[@"modelName"];
        self.condition = itemDictionary[@"condition"];
        self.loanDesired = itemDictionary[@"loanDesired"];
        self.itemStatus = itemDictionary[@"itemStatus"];
        
        //These next three nil values when first posted.. Need special stuff for?
        self.otherComments = itemDictionary[@"otherComments"];
        self.postedLoanAmount = itemDictionary[@"postedLoanAmount"];
        
        NSString *standardResolutionImageURLString = itemDictionary[@"images"][@"standard_resolution"][@"url"];
        NSURL *standardResolutionImageURL = [NSURL URLWithString:standardResolutionImageURLString];
        
        if (standardResolutionImageURL) {
            self.imageOneURL = standardResolutionImageURL;
        }
    }
    
        return self;
        
}



@end





//Testing out the Item Status
//-(void)test {
//    self.status = loanAccepted;
//}

//@end
