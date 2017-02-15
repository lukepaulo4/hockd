//
//  AllItem.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 1/17/17.
//  Copyright © 2017 HOCKD. All rights reserved.
//

#import "AllItem.h"
#import "User.h"
#import "DataSource.h"

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

# pragma mark - NSCoding

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    
    self = [super init];
    
    if (self) {
        self.idNumber = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(idNumber))];
        self.itemDescription = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(itemDescription))];
        self.manufacturer = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(manufacturer))];
        self.manufactureYear = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(manufactureYear))];
        self.loanDesired = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(loanDesired))];
        self.itemStatus = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(itemStatus))];
        self.modelName = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(modelName))];
        self.category = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(category))];
        self.condition = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(condition))];
    }
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.idNumber forKey:NSStringFromSelector(@selector(idNumber))];
    [aCoder encodeObject:self.itemDescription forKey:NSStringFromSelector(@selector(itemDescription))];
    [aCoder encodeObject:self.manufacturer forKey:NSStringFromSelector(@selector(manufacturer))];
    [aCoder encodeObject:self.manufactureYear forKey:NSStringFromSelector(@selector(manufactureYear))];
    [aCoder encodeObject:self.loanDesired forKey:NSStringFromSelector(@selector(loanDesired))];
    [aCoder encodeObject:self.itemStatus forKey:NSStringFromSelector(@selector(itemStatus))];
    [aCoder encodeObject:self.modelName forKey:NSStringFromSelector(@selector(modelName))];
    [aCoder encodeObject:self.category forKey:NSStringFromSelector(@selector(category))];
    [aCoder encodeObject:self.condition forKey:NSStringFromSelector(@selector(condition))];
}


@end
