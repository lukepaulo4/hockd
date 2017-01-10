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

@end

@implementation MyItemsTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        //create the empty array for the images
        self.images = [NSMutableArray array];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //add the images to the array
    for (int i = 1; i <= 10; i++) {
        NSString *imageName = [NSString stringWithFormat:@"%d.jpg", i];
        UIImage *image = [UIImage imageNamed:imageName];
        if (image) {
            [self.images addObject:image];
        }
    }
    
    NSLog(@"array from table vc view did load is %@", self.images);
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"imageCell"];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//Need to present all of our images as rows in this table.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //return [DataSource sharedInstance].items.count;
    
    return self.images.count;
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
    
    UIImage *image = self.images[indexPath.row];
    imageView.image = image;
    
    
    
    /*
    ItemTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemTableCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[ItemTVCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"itemTableCell"];
    }
    
    //Now configure the cell
    cell.loanDesiredLabel.text =  objectAtIndex:[indexPath row]];
    cell.itemDescriptionLabel.text = [self.item.itemDescription objectAtIndex:[indexPath row]];
    
    cell.item = [DataSource sharedInstance].items[indexPath.row];
    */
    
    
    return cell;
}




//None of this is right. Copied from blocstagram. Need to redo.
/*
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [DataSource sharedInstance].items.count;
}


//cellage
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ItemTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCell" forIndexPath:indexPath];
    cell.item = [DataSource sharedInstance].items[indexPath.row];
    return cell;
}


//height of cells when we scroll
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Item *item = [DataSource sharedInstance].items[indexPath.row];
    UIImage *image = item.imageOne;
    return 300 + (image.size.height / image.size.width * CGRectGetWidth(self.view.frame));
}

//estimated height of cells when we scroll
- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Item *item = [DataSource sharedInstance].items[indexPath.row];
    UIImage *image = item.imageOne;
    return 300 + (image.size.height / image.size.width * CGRectGetWidth(self.view.frame));
}
*/


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
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
