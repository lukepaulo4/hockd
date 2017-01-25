//
//  SettingsViewController.m
//  Hockd iOS App
//
//  Created by Luke Paulo on 8/24/16.
//  Copyright © 2016 HOCKD. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()



@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //meh about the above to. Set your array of possible settings

    self.settingsLabels =  [NSArray arrayWithObjects:@"VIEW & EDIT PROFILE",
                                @"ASSETS ACCEPTED",
                                @"HOW IT WORKS",
                                @"FAQ",
                                @"CONTACT US",
                                nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    //Will have 1 section in our table view
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    //Make this equal to the number of array objects in the settingsLinks. Shoulnd't this create only 5 rows from the 5 objects in the array?
    return [self.settingsLabels count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Settings Cell Identifier" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Settings Cell Identifier"];
    }
    
    cell.textLabel.text = self.settingsLabels[indexPath.row];
    cell.textLabel.font =  [UIFont boldSystemFontOfSize:20];
    
     
     //Can make a NSMutableAttributedString then apply the below slayage
//    addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Bradley Hand" size:20] range:range];
//    [cell.textLabel addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:10] range: range];
//    [cell.textLabel addAttribute:NSKernAttributeName value:@1.3 range:range];
//    [cell.textLabel addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.933 green:0.933 blue:0.933 alpha:1] range:range];
    
     
     
     
    //This would be to add another sub text either below or to the sides. See if you can incorporate how to get image of arrows on side for this one
//    if (indexPath.row < self.settingsLabels.count) {
//        cell.detailTextLabel.text = @"";
//    } else {
//        cell.detailTextLabel = @""
//    }

    return cell;
}

//Use this method to indent title/info if needed
- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Sets indent for all rows less than count to 0. So none will be indented, but can easibly come back and play with numbers to edit.
    if (indexPath.row < self.settingsLabels.count) {
        return 0;
    } else {
        return 2;
    }
}

//This method will allow if you can select a row. The way it is set up now won't let you select row 0 (the first one)
//- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    if (indexPath.row == 0) {
//        return nil;
//    } else {
//        return indexPath;
//    }
//}

//Output for when we do select something. Makes a little pop up screen son.
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *rowValue = self.settingsLabels[indexPath.row];
    
    if ([rowValue isEqualToString:@"VIEW & EDIT PROFILE"]) {
        
        dispatch_async(dispatch_get_main_queue(),   ^{

            [self performSegueWithIdentifier:@"updateAccountSegue" sender:self];
            
        });

    } else if ([rowValue isEqualToString:@"FAQ"]) {
    
        dispatch_async(dispatch_get_main_queue(),   ^{
            
            [self performSegueWithIdentifier:@"faqSegue" sender:self];
            
        });
    
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

//Set the cell height here... Make it proportional to the number of cells and the over screen size? Bigger screen means can show more info, but should all the sizes be the same, or should it start to scale down at a certain size?
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    
//}









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
