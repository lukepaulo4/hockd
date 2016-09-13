//
//  Item.m
//  Hokd iOS App
//
//  Created by Luke Paulo on 8/31/16.
//  Copyright © 2016 HOKD. All rights reserved.
//

#import "Item.h"
#import "User.h"

@implementation Item


- (id)initWithJSONFromFile:(NSString *)jsonFileName {
    self = [super init];
    if (self) {
        self.myItems = [self dataFromJSONFile:jsonFileName];
        [self writeDefaultImageToDocuments];
    }
    return self;
}


//Helper method to get data from JSON file
- (NSMutableArray *)dataFromJSONFile:(NSString *)jsonFileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains((NSDocumentDirectory), NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *jsonPath = [documentsDirectory stringByAppendingPathComponent:jsonFileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:jsonPath]) {
        NSError *error = nil;
        NSData *responseData = [NSData dataWithContentsOfFile:jsonPath];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        
        //What is my object key?
        return [[NSMutableArray alloc] initWithArray:[json objectForKey:@"items"]];
    }
    
    //set up a default
    return [[NSMutableArray alloc] initWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"Jewelery", @"Diamond Ring", @"Tiffany & Co", "2011", @"Stunning Stunnage", @"Like New", @"24k diamond with 14K band", @"3000", nil], nil];
}

//Helper method to save the JSON file
//Here we are write-protecting the file, then we are setting the file itself to use File Protection (Data At Rest).
- (void)saveMyItems {
    NSError *error = nil;
    
    //Wrap our myItems array  inside of a dictionary to foloow the standard JSON format
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObject:self.myItems forKey:@"items"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDictionary
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *jsonPath = [documentsDirectory stringByAppendingPathComponent:@"myItems.json"];
    [jsonData writeToFile:jsonPath options:NSDataWritingFileProtectionComplete error:&error];
    [[NSFileManager defaultManager] setAttributes:[NSDictionary dictionaryWithObject:NSFileProtectionComplete forKey:NSFileProtectionKey] ofItemAtPath:jsonPath error:&error];
}

//method that ensures a default pic for users who don't specify a new pic. Good for sim testing as we can't access camera but will take out once running on an actual device.
- (void)writeDefaultImageToDocuments {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:@"default_image.png"];
    // If the file does NOT exist, then save it
    if (![[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
        UIImage *editedImage = [UIImage imageNamed:@"default.png"];
        NSData *webData = UIImagePNGRepresentation(editedImage);
        [webData writeToFile:imagePath atomically:YES];
    }
}

//Accessor method to retrieve the saved category for a given item
- (NSString *)categoryForItemAtIndex:(NSIndexPath *)indexPath {
    return [[self.myItems objectAtIndex:indexPath.row] objectForKey:@"category"];
}

//Accessor method to retrieve the saved description for a given item
- (NSString *)itemDescriptionForItemAtIndex:(NSIndexPath *)indexPath {
    return [[self.myItems objectAtIndex:indexPath.row] objectForKey:@"itemDescription"];
}

//Accessor method to retrieve the saved manufacturer for a given item
- (NSString *)manufacturerForItemAtIndex:(NSIndexPath *)indexPath {
    return [[self.myItems objectAtIndex:indexPath.row] objectForKey:@"manufacturer"];
}

//Accessor method to retrieve the saved manufacture year for a given item
- (NSString *)manufactureYearForItemAtIndex:(NSIndexPath *)indexPath {
    return [[self.myItems objectAtIndex:indexPath.row] objectForKey:@"manufactureYear"];
}

//Accessor method to retrieve the saved model name for a given item
- (NSString *)modelNameForItemAtIndex:(NSIndexPath *)indexPath {
    return [[self.myItems objectAtIndex:indexPath.row] objectForKey:@"modelName"];
}

//Accessor method to retrieve the saved condition for a given item
- (NSString *)conditionForItemAtIndex:(NSIndexPath *)indexPath {
    return [[self.myItems objectAtIndex:indexPath.row] objectForKey:@"condition"];
}

//Accessor method to retrieve the saved other comments for a given item
- (NSString *)otherCommentsForItemAtIndex:(NSIndexPath *)indexPath {
    return [[self.myItems objectAtIndex:indexPath.row] objectForKey:@"otherComments"];
}

//Accessor method to retrieve the saved loan desired for a given item
- (NSString *)loanDesiredForItemAtIndex:(NSIndexPath *)indexPath {
    return [[self.myItems objectAtIndex:indexPath.row] objectForKey:@"loanDesired"];
}

//Accessor method to retrieve the saved posted loan amount for a given item
- (NSString *)postedLoanAmountForItemAtIndex:(NSIndexPath *)indexPath {
    return [[self.myItems objectAtIndex:indexPath.row] objectForKey:@"postedLoanAmount"];
}

//Accessor method to retrieve the saved agreed loan amount for a given item
- (NSString *)agreedLoanAmountForItemAtIndex:(NSIndexPath *)indexPath {
    return [[self.myItems objectAtIndex:indexPath.row] objectForKey:@"agreedLoanAmount"];
}

//Accessor method to retrieve the saved item status for a given item
- (NSString *)itemStatusForItemAtIndex:(NSIndexPath *)indexPath {
    return [[self.myItems objectAtIndex:indexPath.row] objectForKey:@"itemStatus"];
}

//Accessor method to retrieve the saved images for a given item
- (UIImage *)imageForItemAtIndex:(NSIndexPath *)indexPath {
    return [[self.myItems objectAtIndex:indexPath.row] objectForKey:@"itemPics"];
}

- (void)addItemToMyItems:(NSDictionary *)newItem {
    [self.myItems addObject:newItem];
    [self saveMyItems];
}

//Do I want to be able to give them the option to delete an item?
//- (void)removeItemAtIndexPath:(NSIndexPath *)indexPath {
//}



//Testing out the Item Status
//-(void)test {
//    self.status = loanAccepted;
//}

@end
