//
//  Item.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 8/31/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "MyItem.h"
#import "User.h"
#import "DataSource.h"


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

//Testing out the Item Status
//-(void)test {
//    self.status = loanAccepted;
//}

//@end
