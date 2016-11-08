//
//  DataSource.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 8/31/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "DataSource.h"
#import "User.h"
#import "Item.h"
#import "Address.h"


@interface DataSource ()

@property (nonatomic, strong) NSArray *items;

@end

@implementation DataSource

+ (instancetype) sharedInstance {
    
    //Make sure you only create a single instance of this class. Should take code and run it only the first time it's called.
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype) init {
    self = [super init];
    
    if (self) {
        [self loginUserDefaultPopulated];
    }
    
    return self;
}


- (void) loginUserDefaultPopulated {
    //if ()
        [self populateDataWithParameters:nil];
}


//write a method to request the info for My Items and turn the response from the API into a dictionary. Keys should be id_number and item_status
- (void) populateDataWithParameters:(NSDictionary *)parameters {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"logged_in"]) {
        
        //Only try to get data if the user is logged in
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            //Do the network request in the background, so the UI doesn't lock up
            
            NSMutableString *urlString = [NSMutableString stringWithFormat:@"http://private-6d370-newpawnitem1.apiary-mock.com/"];
            
            for (NSString *parameterName in parameters) {
                //for example, if dictionary contains {count: 50}, append '&count=50' to the URL
                [urlString appendFormat:@"&%@=%@", parameterName, parameters[parameterName]];
                
            }
            
            NSURL *url = [NSURL URLWithString:urlString];
            
            if (url) {
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                
                NSURLResponse *response;
                NSError *webError;
                NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&webError];
                
                if (responseData) {
                    NSError *jsonError;
                    NSDictionary *itemDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&jsonError];
                    
                    if (itemDictionary) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            //done networking, go back on the main thread
                            [self parseDataFromFeedDictionary:itemDictionary fromRequestWithParameters:parameters];
            
//Non Deprecated*****
//            NSURL *url = [NSURL URLWithString:urlString];
//            
//            if (url) {
//                NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//                NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request
//                                                                                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//                                                                                     if (data == nil) {
//                                                                                         completion(nil, error);
//                                                                                         return;
//                                                                                     }
//                                                                                     NSError *jsonError;
//                                                                                     NSDictionary *feedDictionary = [[NSDictionary alloc]initWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError]];
//                                                                                     completion(feedDictionary, jsonError);
//                                                                                     
//                                                                                     if (feedDictionary) {
//                                                                                         dispatch_async(dispatch_get_main_queue(), ^{
//                                                                                             //done networking, go back on the main thread
//                                                                                             [self parseDataFromFeedDictionary:feedDictionary fromRequestWithParameters:parameters];
//                                                                                 }
//                                                  ];
//                [dataTask resume];
//            }
            
            
            
                        });
                    }
                }
            }
        });
        
        
    }
}



- (void) parseDataFromFeedDictionary:(NSDictionary *) feedDictionary fromRequestWithParameters:(NSDictionary *)parameters {
    
    //I think use "my_items" based on apiary.io shit. Yee. If crashes, come investigate
    NSArray *itemArray = feedDictionary[@"myItems"];
    
    NSMutableArray *tmpItems = [NSMutableArray array];
    
    for (NSDictionary *itemDictionary in itemArray) {
        Item *item = [[Item alloc] initWithDictionary:itemDictionary];
        
        if (item) {
            [tmpItems addObject:item];
            //This download images as they arrive. If the logic was setup in the image view cell. Which it isn't yet.
            [self downloadImageForItem:item];
        }
    }
    
    //let the key-value observation system that self.items is about to be replaced doe, and then that it has been replaced. This will trigger a notification to the table view to reload all of the data!!! Did I set that up yet? Hmmm
    [self willChangeValueForKey:@"items"];
    self.items = tmpItems;
    [self didChangeValueForKey:@"items"];
}

//When we receive a new ITEM we want to download the associated image to display it.
- (void) downloadImageForItem:(Item *)item {
    if (item.imageOneURL && !item.imageOne) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
            NSURLRequest *request = [NSURLRequest requestWithURL:item.imageOneURL];
            
            NSURLResponse *response;
            NSError *error;
            NSData *imageData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            if (imageData) {
                UIImage *image = [UIImage imageWithData:imageData];
                
                if (image) {
                    item.imageOne = image;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSMutableArray *mutableArrayWithKVO = [self mutableArrayValueForKey:@"items"];
                        NSUInteger index = [mutableArrayWithKVO indexOfObject:item];
                        [mutableArrayWithKVO replaceObjectAtIndex:index withObject:item];
                    });
                }
            } else {
                NSLog(@"Error downloading image: %@", error);
            }
        });
    }
}






//OK let's do two things. First - POST so that the sign up data gets parsed and uploaded to the server via the API.


@end







