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
        self.idNumber = itemDictionary[@"id"];
        self.user = [[User alloc] initWithDictionary:itemDictionary[@"user"]];
        self.itemDescription = itemDictionary[@"item_description"];
        self.manufacturer = itemDictionary[@"manufacturer"];
        self.manufactureYear = itemDictionary[@"manufacture_year"];
        self.modelName = itemDictionary[@"model_name"];
        self.condition = itemDictionary[@"condition"];
        self.loanDesired = itemDictionary[@"loan_desired"];
        self.itemStatus = itemDictionary[@"item_status"];
        
        //These next three nil values when first posted.. Need special stuff for?
        self.otherComments = itemDictionary[@"other_comments"];
        self.postedLoanAmount = itemDictionary[@"loan_amount"];
        
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
