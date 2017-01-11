//
//  MyItemsTableViewController.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 8/24/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "MyItemsTableViewController.h"
#import "DataSource.h"
#import "Item.h"
#import "User.h"
#import "ItemTVCell.h"

@interface MyItemsTableViewController ()

@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, strong) NSMutableArray *testArray;

@end

@implementation MyItemsTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        
        /*removing per Lesson 28
        //create the empty array for the images
        self.images = [NSMutableArray array];
        self.testArray = [NSMutableArray array];
         */
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    /*removing per Lesson 28
    
    //USING THIS IN THE TESTARRAY ARRAY BECAUSE MY LOOP AIN'T WORKING :(
    UIImage *imageOne = [UIImage imageNamed:@"1.jpg"];
    UIImage *imageTwo = [UIImage imageNamed:@"2.jpg"];
    UIImage *imageThree = [UIImage imageNamed:@"3.jpg"];
    UIImage *imageFour = [UIImage imageNamed:@"4.jpg"];
    UIImage *imageFive = [UIImage imageNamed:@"5.jpg"];
    UIImage *imageSix = [UIImage imageNamed:@"6.jpg"];
    UIImage *imageSeven = [UIImage imageNamed:@"7.jpg"];
    UIImage *imageEight = [UIImage imageNamed:@"8.jpg"];
    UIImage *imageNine = [UIImage imageNamed:@"9.jpg"];
    UIImage *imageTen = [UIImage imageNamed:@"10.jpg"];
    self.testArray = [NSMutableArray arrayWithObjects:imageOne, imageTwo, imageThree, imageFour, imageFive, imageSix, imageSeven, imageEight, imageNine, imageTen, nil];
    
    
    
    //add the images to the array. THIS IS ADDING NOTHING. NOTHING!!!!!!!!
    for (int i = 1; i <= 10; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%d.jpg", i];
        UIImage *image = [UIImage imageNamed:imageName];
        if (image) {
            [self.images addObject:image];
        }
    }
    
    NSLog(@"test array from table vc view did load is %@", self.testArray);
    NSLog(@"array from table vc view did load is %@", self.images);
     */
    
    NSLog(@"array from DataSource view did load is %@", [DataSource sharedInstance].items);
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"imageCell"];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Need to present all of our images as rows in this table.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //added this per 28
    return [DataSource sharedInstance].items.count;
    
    /*removing per Lesson 28
    return self.testArray.count;
     */
}


//Required method and most important. Returns a prepped and ready UITableViewCell instance to the table view to display at a given location. This method is called every time a new row is about to appear on screen whether scrolling up or down.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //1
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell" forIndexPath:indexPath];
    
    //2
    static NSInteger imageViewTag = 1234;
    UIImageView *imageView = (UIImageView*)[cell.contentView viewWithTag:imageViewTag];
    
    //3
    if (!imageView) {
        //This is a new cell, it doesn't have an image yet
        imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleToFill;
        
        imageView.frame = cell.contentView.bounds;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        imageView.tag = imageViewTag;
        [cell.contentView addSubview:imageView];
    }
    
    /*removing per Lesson 28
    UIImage *image = self.testArray[indexPath.row];
    imageView.image = image;
    */
    
    //adding this per 28
    Item *item = [DataSource sharedInstance].items[indexPath.row];
    imageView.image = item.image;
    
    
    return cell;
}







//height of cells when we scroll
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Added per 28
    Item *item = [DataSource sharedInstance].items[indexPath.row];
    UIImage *image = item.image;
    
    /*removing per Lesson 28
    UIImage *image = self.testArray[indexPath.row];
     */
     
     /*removing per Lesson 28
    return (CGRectGetWidth(self.view.frame) / image.size.width) * image.size.height;
      */
    
    //added per 28
    return image.size.height / image.size.width * CGRectGetWidth(self.view.frame);
}



/*
//estimated height of cells when we scroll
- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Item *item = [DataSource sharedInstance].items[indexPath.row];
    UIImage *image = item.imageOne;
    return 300 + (image.size.height / image.size.width * CGRectGetWidth(self.view.frame));
}
*/




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
