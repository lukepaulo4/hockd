//
//  AllItem.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 1/17/17.
//  Copyright © 2017 HOCKD. All rights reserved.
//

#import "AllItem.h"
#import "User.h"

@implementation AllItem

- (instancetype) initWithDictionary:(NSDictionary *)allItemDictionary {
    self = [super init];
    
    if (self) {
        self.idNumber = allItemDictionary[@"id"];
        self.user = [[User alloc] initWithDictionary:allItemDictionary[@"user"]];
        self.itemDescription = allItemDictionary[@"item_description"];
        self.manufacturer = allItemDictionary[@"manufacturer"];
        self.manufactureYear = allItemDictionary[@"manufacture_year"];
        self.modelName = allItemDictionary[@"model_name"];
        self.condition = allItemDictionary[@"condition"];
        self.loanDesired = allItemDictionary[@"loan_desired"];
        self.itemStatus = allItemDictionary[@"item_status"];
        
        //These next three nil values when first posted.. Need special stuff for?
        self.otherComments = allItemDictionary[@"other_comments"];
        self.postedLoanAmount = allItemDictionary[@"loan_amount"];
        
        NSString *standardResolutionImageURLString = allItemDictionary[@"images"][@"standard_resolution"][@"url"];
        NSURL *standardResolutionImageURL = [NSURL URLWithString:standardResolutionImageURLString];
        
        if (standardResolutionImageURL) {
            self.imageOneURL = standardResolutionImageURL;
        }
    }
    
    return self;
    
}


@end
