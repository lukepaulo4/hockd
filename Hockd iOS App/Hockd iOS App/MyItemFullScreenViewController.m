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
    
    //#2 create image view THIS IS WHAT YOU ACTUALLY USE. UNCOMMENT WHEN THE API IS WORKING AND CAN ACTUALLY TEST
    /*
    self.imageView.image = self.item.imageOne;
    self.itemDescriptionLabel.text = self.item.itemDescription;
    self.loanAmountLabel.text = self.item.loanDesired;
    self.conditionLabel.text = self.item.condition;
    self.manufacturerLabel.text = self.item.manufacturer;
    self.yearMadeLabel.text = self.item.manufactureYear;
    self.modelLabel.text = self.item.modelName;
    self.categoryLabel.text = self.item.category;
    self.otherCommentsLabel.text = self.item.otherComments;
     */
    
    //JUST FILLER STUFF UNTIL WE GET THE API FUNCTIONING!!!!
    NSString *itemD = @"Macbook Pro with very little wear and tear. Has 800 RAM and a big ass apple dong";
    NSString *loanA = @"$1200";
    NSString *cond = @"almost new";
    NSString *manu = @"apple";
    NSString *manY = @"2013";
    NSString *model = @"macbook pro";
    NSString *cat = @"electronics";
    NSString *other = @"suck me long time";
    NSString *imageName = [NSString  stringWithFormat:@"4.jpg"];
    UIImage *image = [UIImage imageNamed:imageName];
    
    
    self.imageView.image = image;
    self.itemDescriptionLabel.text = itemD;
    self.loanAmountLabel.text = loanA;
    self.conditionLabel.text = cond;
    self.manufacturerLabel.text = manu;
    self.yearMadeLabel.text = manY;
    self.modelLabel.text = model;
    self.categoryLabel.text = cat;
    self.otherCommentsLabel.text = other;
    //end the bullshit here
    
    
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
