//
//  GroupsAndRequestsViewController.m
//  Teaser
//
//  Created by Anatoly Brevnov on 5/9/17.
//  Copyright © 2017 Anatoly Brevnov. All rights reserved.
//

#import "GroupsAndRequestsViewController.h"

#define TO_DELETE 0001


@interface GroupsAndRequestsViewController ()

@end

@implementation GroupsAndRequestsViewController

@synthesize segmentedController;
@synthesize topLabel;
@synthesize bottomLabel;
@synthesize topTable;
@synthesize bottomTable;

//passed in user uid

NSString *uid;

//initializing data arrays for the table views

NSMutableArray *groupIDS;
NSMutableArray *groupRequestIDS;

NSMutableArray *friendIDS;
NSMutableArray *friendRequestIDS;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    uid = [Teaser getCurrentUserUID];
    
    //setting delegates and datasources for tableviews
    topTable.delegate = self;
    topTable.dataSource = self;
    bottomTable.delegate = self;
    bottomTable.dataSource = self;
    
    //initializing data arrays
    groupIDS = [[NSMutableArray alloc] init];
    groupRequestIDS = [[NSMutableArray alloc] init];
    friendIDS = [[NSMutableArray alloc] init];
    friendRequestIDS = [[NSMutableArray alloc] init];
    
    //initial loadData() call to populata data arrays
    [self loadData];

}

-(void)loadData{
    
    //getting groupIDS
    
    [Teaser aggregateGroups:uid withCompletion:^(NSMutableArray *groupUIDS){
        
        groupIDS = groupUIDS;
        
        [Teaser aggregateGroupRequests:uid withCompletion:^(NSMutableArray *requests){
            
            groupRequestIDS = requests;
            
            [Teaser aggregateFriends:uid withCompletion:^(NSMutableArray *friends){
               
                friendIDS = friends;
                
                [Teaser aggregateFriendRequests:uid withCompletion:^(NSMutableArray *requests){
                   
                    friendRequestIDS = requests;

                    //reloading our data once our mutable data arrays are updated/populated
                    [self.topTable reloadData];
                    [self.bottomTable reloadData];
                    
                }];
                
            }];
            
        }];
        
    }];
    

}

-(IBAction)plusButtonPressed:(id)sender{
    //plus button pressed
    
    if (segmentedController.selectedSegmentIndex == 0){
        //groups view controller
        
        [self performSegueWithIdentifier:@"createGroupFromMain" sender:self];
    }
    else {
        //friends view controller
        
        //alertview that allows people to enter friend's username to send a friend request
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Add Friend"
                                   message:@"Enter friend's username:"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Send Request" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                                                       //sending request
                                                       UITextField *usernameTextField = alert.textFields[0];
                                                       
                                                       if (usernameTextField.text != nil && ![usernameTextField.text isEqual: @" "]){
                                                           //sending our request
                                                           
                                                           [Teaser sendFriendRequest:uid withFriendUsername:usernameTextField.text withCompletion:^(NSString *success){
                                                               //dismissing alertcontroller
                                                               [alert dismissViewControllerAnimated:YES completion:nil];

                                                               if ([success isEqual: @"success"]){
                                                                   //sent a successful friend request
                                                                   
                                                                   //optional print statement: NSLog(@"friend request sent successfully");
                                                               }
                                                               
                                                               else {
                                                                   //invalid username inputted
                                                                   
                                                                   //simple alertController popup to tell user it was a failed attempt
                                                                   
                                                                   UIAlertController *alertControllerFailed = [UIAlertController alertControllerWithTitle:@"Invalid Username"
                                                                                                                                            message:@"No user exists with that username."
                                                                                                                                     preferredStyle:UIAlertControllerStyleAlert];
                                                                   //We add buttons to the alert controller by creating UIAlertActions:
                                                                   UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                                                                      style:UIAlertActionStyleDefault
                                                                                                                    handler:nil];
                                                                   [alertControllerFailed addAction:actionOk];
                                                                   [self presentViewController:alertControllerFailed animated:YES completion:nil];
                                                               }
                                                               
                                                           }];
                                                           
                                                       }
                                                       else {
                                                           //invalid username
                                                           [alert dismissViewControllerAnimated:YES completion:nil];

                                                       }
                                                       
                                                   }];
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action) {
                                                           //cancel button clicked
                                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                                           
                                                       }];
        
        [alert addAction:ok];
        [alert addAction:cancel];
        
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"username";
            textField.keyboardType = UIKeyboardTypeDefault;
            textField.textAlignment = NSTextAlignmentCenter;
        }];
        
        [self presentViewController:alert animated:YES completion:nil];    }
}

-(IBAction)segmentControllerValueChanged:(id)sender{
    //segement value changed
    
    //immediately want to clear the table
    [friendIDS removeAllObjects];
    [friendRequestIDS removeAllObjects];
    [groupRequestIDS removeAllObjects];
    [groupIDS removeAllObjects];
    
    [self.topTable reloadData];
    [self.bottomTable reloadData];
    
    //now we actually switch what we are displaying to the other page's content
    
    
    NSInteger index = segmentedController.selectedSegmentIndex;
    
    if (index == 0){
        //groups page
        
        self.topLabel.text = @"Groups.";
        self.bottomLabel.text = @"Requests.";
        
    }
    
    else {
        //friends page
        
        self.topLabel.text = @"Friends.";
        self.bottomLabel.text = @"Requests.";
        
    }
    
    //refreshing our data
    
    [self loadData];
}

//necessary stuff for tableviews

- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    // Set the data for this cell:
    
    //removing all subviews added in previous cycle
    NSArray *viewsToRemove = [cell subviews];
    for (UIView *view in viewsToRemove) {
        if (view.tag == TO_DELETE){
            [view removeFromSuperview];
        }
    }
    
    if (segmentedController.selectedSegmentIndex == 0){
        //groups view controller
        
        if (tableView1 == topTable){
            //top table in groups view controller
            
            //defining our groupID
            
            NSString *groupID = [groupIDS objectAtIndex:indexPath.row];
            
            //set the title text
            [Teaser getGroupName:groupID withCompletion:^(NSString *name){
                cell.textLabel.text = name;
            }];
            
            //below we add our play button to the cell
            UIButton *playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            playButton.frame = CGRectMake(cell.frame.size.width-cell.frame.size.width/4, cell.frame.size.height/4, cell.frame.size.height*1.2, cell.frame.size.height/1.8);
            playButton.backgroundColor = [UIColor colorWithRed:112/255.0 green:196/255.0 blue:127/255.0 alpha:1];
            [playButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [playButton setTitle:@"Play" forState:UIControlStateNormal];
            playButton.layer.cornerRadius = 5;
            playButton.tag = TO_DELETE;
            [cell addSubview:playButton];
            
            //below we add the number of members label to the cell
            UILabel *numberOfMembers = [[UILabel alloc] init];
            numberOfMembers.frame = CGRectMake(cell.frame.size.width/2.2, cell.frame.size.height/4, cell.frame.size.height*1.2, cell.frame.size.height/1.8);
            numberOfMembers.tag = TO_DELETE;
            [numberOfMembers setTextColor:[UIColor blackColor]];
            [Teaser getGroupNumMembers:groupID withCompletion:^(NSString *num){
                numberOfMembers.text = [NSString stringWithFormat:@"%@/30",num];
                [cell addSubview:numberOfMembers];
            }];
            
        }
        else {
            //bottom table in groups view controller
            
            //defining our groupRequestID
            
            NSString *groupRequestID = [groupRequestIDS objectAtIndex:indexPath.row];
            
            //getting the groupID from the requestID, which we then use to get information used in labels/buttons contained within the cell
            
            [Teaser getRequestingGroupUID:groupRequestID withCompletion:^(NSString *groupID){
            
                //set the title text by retrieving the group name
                [Teaser getGroupName:groupID withCompletion:^(NSString *name){
                    cell.textLabel.text = name;
                }];
                
                //below we add our decline button to the cell
                
                UIButton *declineButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                declineButton.frame = CGRectMake(cell.frame.size.width-cell.frame.size.width/4, cell.frame.size.height/4, cell.frame.size.height*1.2, cell.frame.size.height/1.8);
                declineButton.backgroundColor = [UIColor colorWithRed:112/255.0 green:196/255.0 blue:127/255.0 alpha:1];
                [declineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [declineButton setTitle:@"decline" forState:UIControlStateNormal];
                declineButton.layer.cornerRadius = 5;
                declineButton.tag = TO_DELETE;
                [cell addSubview:declineButton];
                
                //below we add the accept button to the cell
                
                UIButton *acceptButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                acceptButton.frame = CGRectMake(cell.frame.size.width-cell.frame.size.width/4, cell.frame.size.height/4, cell.frame.size.height*1.2, cell.frame.size.height/1.8);
                acceptButton.backgroundColor = [UIColor colorWithRed:112/255.0 green:196/255.0 blue:127/255.0 alpha:1];
                [acceptButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [acceptButton setTitle:@"decline" forState:UIControlStateNormal];
                acceptButton.tag = TO_DELETE;
                acceptButton.layer.cornerRadius = 5;
                [cell addSubview:acceptButton];
  
            }];


        }
    }
    
    else {
        //friends controller
        
        if (tableView1 == topTable){
            //top table in friends view controller
            
            //getting friend name from id
            
            [Teaser getUsername:[friendIDS objectAtIndex:indexPath.row] withCompletion:^(NSString *username){
                cell.textLabel.text = username;
            }];

            
        }
        else {
            //bottom table in friends view controller

            //defining our friendRequestID
            
            NSString *friendRequestID = [friendRequestIDS objectAtIndex:indexPath.row];
            
            //getting the userid from the friendRequestID, which we then use to get information used in labels/buttons contained within the cell
            
            [Teaser getRequestingFriendUserUID:friendRequestID withCompletion:^(NSString *uid){
                
                //set the title text by retrieving the friend name
                [Teaser getUsername:uid withCompletion:^(NSString *name){
                    cell.textLabel.text = name;
                }];
                
                //below we add our decline button to the cell
                
                UIButton *declineButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                declineButton.frame = CGRectMake(cell.frame.size.width-cell.frame.size.width/4, cell.frame.size.height/4, cell.frame.size.height*1.2, cell.frame.size.height/1.8);
                declineButton.backgroundColor = [UIColor colorWithRed:112/255.0 green:196/255.0 blue:127/255.0 alpha:1];
                [declineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [declineButton setTitle:@"decline" forState:UIControlStateNormal];
                declineButton.layer.cornerRadius = 5;
                declineButton.tag = TO_DELETE;
                [cell addSubview:declineButton];
                
                //below we add the accept button to the cell
                
                UIButton *acceptButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                acceptButton.frame = CGRectMake(cell.frame.size.width-cell.frame.size.width/4, cell.frame.size.height/4, cell.frame.size.height*1.2, cell.frame.size.height/1.8);
                acceptButton.backgroundColor = [UIColor colorWithRed:112/255.0 green:196/255.0 blue:127/255.0 alpha:1];
                [acceptButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [acceptButton setTitle:@"decline" forState:UIControlStateNormal];
                acceptButton.tag = TO_DELETE;
                acceptButton.layer.cornerRadius = 5;
                [cell addSubview:acceptButton];
                
            }];

        }
        
    }
    
    //cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    //cell.detailTextLabel.text = @"More text";
    //cell.imageView.image = [UIImage imageNamed:@"flower.png"];
    
    // set the accessory view:
    cell.accessoryType =  UITableViewCellAccessoryNone;
    
    return cell;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // If you're serving data from an array, return the length of the array:
    
    if (segmentedController.selectedSegmentIndex == 0){
        //groups view controller
        
        if (tableView == topTable){
            //top table in groups view controller
            return groupIDS.count;
        }
        else {
            //bottom table in groups view controller
            return groupRequestIDS.count;
            
        }
    }
    
    else {
        //friends controller
        
        if (tableView == topTable){
            //top table in friends view controller
            return friendIDS.count;
            
            
        }
        else {
            //bottom table in friends view controller
            return friendRequestIDS.count;
            
        }
        
    }
    
    return 0;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}


@end
