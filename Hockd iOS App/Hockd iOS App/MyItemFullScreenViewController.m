//
//  MyItemFullScreenViewController.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 1/23/17.
//  Copyright © 2017 HOCKD. All rights reserved.
//

#import "MyItemFullScreenViewController.h"
#import "MyItem.h"

@interface MyItemFullScreenViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) MyItem *item;

@end

@implementation MyItemFullScreenViewController

- (instancetype) initWithMyItem:(MyItem *)item {
    self = [super init];
    
    if (self) {
        self.item = item;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //#1 scroll view already created and configured in storyboard. and made as a subview of view. image view should be a subview of the scroll view.
    //self.scrollView.delegate = self;
    
    //#2 create image view
    self.imageView.image = self.item.imageOne;
    self.itemDescriptionLabel.text = self.item.itemDescription;
    self.loanAmountLabel.text = self.item.loanDesired;
    self.conditionLabel.text = self.item.condition;
    self.manufacturerLabel.text = self.item.manufacturer;
    self.yearMadeLabel.text = self.item.manufactureYear;
    self.modelLabel.text = self.item.modelName;
    self.categoryLabel.text = self.item.category;
    self.otherCommentsLabel.text = self.item.otherComments;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
