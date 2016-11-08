//
//  DataSource.h
//  Hockd iOS App
//
//  Created by Luke Paulo on 8/31/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSource : NSObject

+(instancetype) sharedInstance;
@property (nonatomic, strong, readonly) NSArray *items;



@end
