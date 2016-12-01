//
//  MediaFullScreenViewController.h
//  Blocstagram
//
//  Created by Luke Paulo on 7/20/16.
//  Copyright © 2016 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Media;

@interface MediaFullScreenViewController : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;

- (void) centerScrollView;

- (void) recalculateZoomScale;

@end
