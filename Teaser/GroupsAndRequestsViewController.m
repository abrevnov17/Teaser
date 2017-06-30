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

//helpful variable to declare so we don't have to keep calling our getCurrentUserID function

NSString *uid;

//below we define a variable that keeps track of the last selected groupUID which is passed into our multiplayer game view controller

NSString *lastSelectedGroupUID;

//initializing data arrays for the table views

NSMutableArray *groupIDS;
NSMutableArray *groupRequestIDS;

NSMutableArray *friendIDS;
NSMutableArray *friendRequestIDS;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //getting our uid
    uid = [Teaser getCurrentUserUID];
    
    //initializing lastSelectedGroupUID variable
    lastSelectedGroupUID = @"";
    
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
        NSLog(@"orange");
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
            playButton.tag = indexPath.row;
            [playButton addTarget:self action:@selector(playButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
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
                declineButton.tag = indexPath.row;
                [declineButton addTarget:self action:@selector(rejectButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:declineButton];
                
                //below we add the accept button to the cell
                
                UIButton *acceptButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                acceptButton.frame = CGRectMake(cell.frame.size.width-cell.frame.size.width/4, cell.frame.size.height/4, cell.frame.size.height*1.2, cell.frame.size.height/1.8);
                acceptButton.backgroundColor = [UIColor colorWithRed:112/255.0 green:196/255.0 blue:127/255.0 alpha:1];
                [acceptButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [acceptButton setTitle:@"decline" forState:UIControlStateNormal];
                acceptButton.tag = indexPath.row;
                acceptButton.layer.cornerRadius = 5;
                [declineButton addTarget:self action:@selector(acceptButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:acceptButton];
  
            }];


        }
    }
    
    else {
        //friends controller
        NSLog(@"alpha");
        if (tableView1 == topTable){
            //top table in friends view controller
            NSLog(@"beta");

            //getting friend name from id
            
            [Teaser getUsername:[friendIDS objectAtIndex:indexPath.row] withCompletion:^(NSString *username){
                cell.textLabel.text = username;
            }];

            
        }
        else {
            NSLog(@"kappa");

            //bottom table in friends view controller

            //defining our friendRequestID
            
            NSString *friendRequestID = [friendRequestIDS objectAtIndex:indexPath.row];
            
            //getting the userid from the friendRequestID, which we then use to get information used in labels/buttons contained within the cell
            
            [Teaser getRequestingFriendUserUID:friendRequestID withCompletion:^(NSString *uid){
                NSLog(@"%@",uid);
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
                declineButton.tag = indexPath.row;
                [declineButton addTarget:self action:@selector(rejectButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
                [cell addSubview:declineButton];
                
                //below we add the accept button to the cell
                
                UIButton *acceptButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                acceptButton.frame = CGRectMake(cell.frame.size.width-cell.frame.size.width/4, cell.frame.size.height/4, cell.frame.size.height*1.2, cell.frame.size.height/1.8);
                acceptButton.backgroundColor = [UIColor colorWithRed:112/255.0 green:196/255.0 blue:127/255.0 alpha:1];
                [acceptButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [acceptButton setTitle:@"decline" forState:UIControlStateNormal];
                acceptButton.tag = indexPath.row;
                acceptButton.layer.cornerRadius = 5;
                [declineButton addTarget:self action:@selector(acceptButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
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

-(void)playButtonPressed:(UIButton *)sender
{
    //play button was pressed
    
    //we get the index of the button that was clicked (we need to know what row it was)
    NSInteger index = sender.tag;
    
    //setting lastSelectedGroupUID to the groupuid selected
    
    lastSelectedGroupUID = [groupIDS objectAtIndex:index];
    
    //here we need to check when the last
    
    [Teaser getGroupMembershipIDFromGroupUIDAndMemberUID:uid withGroupUID:lastSelectedGroupUID withCompletion:^(NSString *membershipUID){
        //now we have our membershipUID, which we can use to get the timestamp of the last time the user answered a problem in that given group
        
        [Teaser getGroupMemberLastAnsweredTimestamp:membershipUID withCompletion:^(NSString *timestamp){
            //now we have our timestamp, which we need to compare to the timestamp of the current problem to make sure that the user has not answered a problem after the problem's timestamp was set (i.e. make sure they haven't already answered the group's current problem)
            
            [Teaser getGroupCurrentProblemTimestamp:lastSelectedGroupUID withCompletion:^(NSString *groupProblemTimestamp){
                /* 
                 now we have our groupProblemTimestamp. There are a few tasks we need to perform now
                        1) Make sure that the timestamp (not the groupProblemTimestamp, the other one) is older than the groupProblemTimestamp (ensuring that you have not already played). If it is, continue. If not, give some alert saying you have already done the current problem and need to wait until the current problem expires.
                        2) Assuming a successful first step, verify that the groupProblemTimestamp is less than a day older than today's date. If yes, continue, otherwise, we need to change the current problem and then continue.
                        3) Assuming the first two steps went well, we need to transition to the view controller handling the actual game and begin
                */
                
                //we define the below boolean so that we decide whether we want to continue to the transition or cancel for some reason
                
                BOOL continueOrNot = YES;
                
                //beginning part 1
                
                //converting to NSDate and formatting our data
                
                NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                [formatter setDateFormat:@"yyyy-mm-dd HH:mm:ss"];
            
                
                NSDate *dateTimestamp = [formatter dateFromString:timestamp];
                NSDate *dateGroupProblemTimestamp = [formatter dateFromString:groupProblemTimestamp];
                NSDate *today = [NSDate date];
                
                NSTimeInterval distanceBetweenDates = [today timeIntervalSinceDate:dateGroupProblemTimestamp];
                double secondsInAnHour = 3600;
                NSInteger hoursBetweenDates = distanceBetweenDates/secondsInAnHour;

                
                switch ([dateTimestamp compare:dateGroupProblemTimestamp]) {
                    case NSOrderedAscending:
                        // we can continue since the dateTimeStamp is earlier in time than the dateGroupProblemTimestamp
                        break;
                    case NSOrderedSame:
                        // treating equal same as the first case
                        break;
                    case NSOrderedDescending:
                        // this is the problem case. we should not continue here if the current date is more than a day newer than the dateGroupProblemTimestamp we do continue
                        
                        if (hoursBetweenDates >= 24){
                            continueOrNot = YES;
                        }
                        else {
                            continueOrNot = NO;
                        }
                        
                    break;
                }
                
                if (continueOrNot){
                
                    //beginning part 2
                    
                    if (hoursBetweenDates >= 24){
                        //we need to generate a new problem and then transition to the game view controller
                        
                        //generating a new (randomly selected problem)
                        
                        [Teaser updateGroupCurrentProblem:lastSelectedGroupUID withCompletion:^(NSString *success){
                            //updated our current_problem_uid
                            
                            [Teaser updateGroupCurrentProblemTimestamp:lastSelectedGroupUID withCompletion:^(NSString *success){
                                //we have updated the group current problem timestamp
                                //now we need to transition to the game view

                                [self performSegueWithIdentifier:@"gotomultiplayer" sender:self];
                            }];
                            
                        }];
                    }
                    else {
                        //we transition to the game view controller
                        
                        [self performSegueWithIdentifier:@"gotomultiplayer" sender:self];

                    }
                
                }
                
                else {
                    //display UIAlertView saying that you have already answered the current problem and need to wait until the next problem cycle
                    
                    //first we get the hours until you can play again
                    
                    NSInteger hoursRemaining = 24 - hoursBetweenDates;
 
                    //simple alertController
                    
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"You Have Already Played This Problem" message:[NSString stringWithFormat:@"You must wait %ld hours to play again",(long)hoursRemaining] preferredStyle:UIAlertControllerStyleAlert];
                    
                    //We add buttons to the alert controller by creating UIAlertActions:
                    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                       style:UIAlertActionStyleDefault
                                                                     handler:nil];
                    [alertController addAction:actionOk];
                    [self presentViewController:alertController animated:YES completion:nil];

                }
                
            }];
            
        }];
        
        
        
    }];
    
    
    
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    //here, we have registered a tap on a row that was not a play button
    //we want to transition to our group page while passing our groupUID variable in
    
    lastSelectedGroupUID = [groupIDS objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"gotogrouppage" sender:self];
}

-(void)rejectButtonPressed:(UIButton *)sender
{
    //we get the index of the button that was clicked (we need to know what row it was)
    NSInteger index = sender.tag;
    
    if (segmentedController.selectedSegmentIndex == 0){
        //group request
        
        [Teaser declineGroupRequest:[groupRequestIDS objectAtIndex:index] withCompletion:^(NSString *success){
            //declined the group request
            
            //reloading our tableview data
            
            [self loadData];
        }];
    }
    else {
        //friend request
        [Teaser declineFriendRequest:[friendRequestIDS objectAtIndex:index] withCompletion:^(NSString *success){
            //declined the friend request
            
            //reloading our tableview data
            
            [self loadData];
        }];
    }
    
}

-(void)acceptButtonPressed:(UIButton *)sender
{
    //we get the index of the button that was clicked (we need to know what row it was)
    NSInteger index = sender.tag;
    
    if (segmentedController.selectedSegmentIndex == 0){
        //group request
        [Teaser acceptGroupRequest:uid withRequestUID:[groupRequestIDS objectAtIndex:index] withCompletion:^(NSString *success){
            //accepted the group request
            
            //reloading our tableview data
            
            [self loadData];
        }];
    }
    else {
        //friend request
        [Teaser acceptFriendRequest:uid withRequestUID:[friendRequestIDS objectAtIndex:index] withCompletion:^(NSString *success){
            //accepted the friend request
            
            //reloading our tableview data
            
            [self loadData];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"gotomultiplayer"]){
        //we are about to transition to our multiplayer view
        //we need to pass the selected groupUID
        
        MultiplayerGameViewController *multiplayerViewController = [segue destinationViewController];
        multiplayerViewController.groupUID = lastSelectedGroupUID;
    }
    
    else if ([segue.identifier isEqualToString:@"gotogrouppage"]){
        //we are about to transition to our group page view controller
        //we need to pass the selected groupUID
        
        GroupPageViewController *groupPageViewController = [segue destinationViewController];
        groupPageViewController.groupUID = lastSelectedGroupUID;
    }
    
    
}


@end
