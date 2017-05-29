//
//  GroupPageViewController.m
//  Teaser
//
//  Created by Anatoly Brevnov on 5/28/17.
//  Copyright © 2017 Anatoly Brevnov. All rights reserved.
//

#import "GroupPageViewController.h"

@interface GroupPageViewController ()

@end

@implementation GroupPageViewController

//synthesizing properties declared in our header file

@synthesize groupNameLabel;
@synthesize groupRankedMembersTableView;
@synthesize groupDescriptionTextView;
@synthesize groupUID;

//declaring variables

NSMutableArray *groupMemberUIDS;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //initializing necessary variables
    groupMemberUIDS = [[NSMutableArray alloc] init];
    
    //setting delegates and datasources for tableview
    groupRankedMembersTableView.delegate = self;
    groupRankedMembersTableView.dataSource = self;
    self.automaticallyAdjustsScrollViewInsets = NO;

    
    //we need to update our subviews to display the appropriate data for the given groupUID
    
    [Teaser getGroupName:groupUID withCompletion:^(NSString *name){
        //setting our group name label text
        groupNameLabel.text = name;
        
    }];
    
    [Teaser getGroupDescription:groupUID withCompletion:^(NSString *description) {
        //setting our group description label text
        groupDescriptionTextView.text = [NSString stringWithFormat:@"Description: %@",description];
        
    }];
    
    [self loadData];
}

-(void)loadData{
    //loading our tableview data for groupRankedMembersTableView
    
    [Teaser aggregateGroupMembers:groupUID withCompletion:^(NSMutableArray *members){
        //setting our groupMemberUIDS to be the same as members
        
        groupMemberUIDS = members;
        
        [self.groupRankedMembersTableView reloadData];
        
    }];
    
}

//below we are going to implement the functions necessary for our uitableview

- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSString *uid = [groupMemberUIDS objectAtIndex:indexPath.row];
    
    // Set the data for this cell:
    
    [Teaser getUsername:uid withCompletion:^(NSString *username){
        //we have successfully gotten the username
        cell.textLabel.text = username;
    }];
    
    [Teaser getGroupMembershipIDFromGroupUIDAndMemberUID:uid withGroupUID:groupUID withCompletion:^(NSString *membershipUID){
        //we needed to get the membershipUID so we can query for the score of the group member
        
        [Teaser getGroupMemberScore:membershipUID withCompletion:^(NSString *memberScore){
            //we have successfuly gotten the member score, so now we set the other text field to display the score
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ points", memberScore];
            
        }];
    }];
    
    
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
    //in this case, the number of rows in the section is just the size of the groupMemberUIDS array
    
    return groupMemberUIDS.count;
    
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
