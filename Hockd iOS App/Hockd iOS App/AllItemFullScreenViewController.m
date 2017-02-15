//
//  AllItemFullScreenViewController.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 2/12/17.
//  Copyright © 2017 HOCKD. All rights reserved.
//

#import "AllItemFullScreenViewController.h"
#import "AllItem.h"

@interface AllItemFullScreenViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) AllItem *item;

@end

@implementation AllItemFullScreenViewController


- (instancetype) initWithAllItem:(AllItem *)item {
    self = [super init];
    
    if (self) {
        self.item = item;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    /* set the image to the item's image... CAN CHECK THIS ONCE HAVE DATA FOR ITEMS
    self.imageView.image = self.item.imageOne;
     
     //and the rest
    self.itemDescriptionLabel.text = self.item.itemDescription;
    self.loanAmountLabel.text = self.item.loanDesired;
    self.modelLabel.text = self.item.modelName;
    self.manufacturerLabel.text = self.item.manufacturer;
    self.yearMadeLabel.text = self.item.manufactureYear;
    self.conditionLabel.text = self.item.condition;
    self.categoryLabel.text = self.item.category;

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
    self.modelLabel.text = model;
    self.manufacturerLabel.text = manu;
    self.yearMadeLabel.text = manY;
    self.conditionLabel.text = cond;
    self.categoryLabel.text = cat;
    //end the bullshit here. hopefully stuff fills out correctly :(
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)offerLoanButtonPressed:(UIButton *)sender {
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
