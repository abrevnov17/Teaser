//
//  FriendsListViewController.m
//  
//
//  Created by Anatoly Brevnov on 5/15/17.
//
//

#import "FriendsListViewController.h"

@interface FriendsListViewController ()

@end

@implementation FriendsListViewController

@synthesize uid;
@synthesize doneButton;
@synthesize delegate;

NSMutableArray *friends;
NSMutableArray *cells;
NSMutableArray *friendsToAdd;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    friends = [[NSMutableArray alloc] init];
    cells = [[NSMutableArray alloc] init];
    friendsToAdd = [[NSMutableArray alloc] init];
    
    //need to change below
    uid = [Teaser getCurrentUserUID];
    
    //loading our initial data
    
    [self loadData];
    
    doneButton.target = self;
    doneButton.action = @selector(donePressed:);

}

-(IBAction)donePressed:(UIBarButtonItem *)sender{
    //done button pressed

}


-(void)loadData{
    //reloading our data
    
    [Teaser aggregateFriends:uid withCompletion:^(NSMutableArray *friendUIDS){
        
        if (friendUIDS){
            //user have friends
            friends = friendUIDS;
            [self.tableView reloadData];
        }
        else {
            //user does not have friends
            [friends removeAllObjects];
            [self.tableView reloadData];
        }
        
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //cell is clicked
    
    //changing checked/unchecked image
    
    UITableViewCell *cell = cells[indexPath.row];
    
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    if ([self image:cell.imageView.image isEqualTo:[UIImage imageNamed:@"uncheckedBox.png"]]){
        cell.imageView.image = [UIImage imageNamed:@"checkedBox.png"];
        cell.contentView.backgroundColor = [UIColor colorWithRed:(133/255.0) green:(207/255.0) blue:(151/255.0) alpha:1];
        cell.textLabel.textColor = [UIColor whiteColor];
        [friendsToAdd addObject:[friends objectAtIndex:indexPath.row]];
    }
    else {
        cell.imageView.image = [UIImage imageNamed:@"uncheckedBox.png"];
        cell.contentView.backgroundColor = [UIColor colorWithRed:133 green:207 blue:151 alpha:1];
        cell.textLabel.textColor = [UIColor blackColor];
        [friendsToAdd removeObject:[friends objectAtIndex:indexPath.row]];

    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //this allows us to change image on click later
    [cells addObject:cell];
    
    // Set the data for this cell:
    
    //getting the name
    [Teaser getUsername:friends[indexPath.row] withCompletion:^(NSString *name){
        //setting the cell label to be the username of the friend
        cell.textLabel.text = name;
    }];
    
    
    cell.imageView.image = [UIImage imageNamed:@"uncheckedBox.png"];
    
    // set the accessory view:
    //cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (BOOL)image:(UIImage *)image1 isEqualTo:(UIImage *)image2
{
    //this is the function we use to compare UIImages
    
    NSData *data1 = UIImagePNGRepresentation(image1);
    NSData *data2 = UIImagePNGRepresentation(image2);
    
    return [data1 isEqual:data2];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // If you're serving data from an array, return the length of the array:
    
    return friends.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    //passing in our selected friends
    NSLog(@"success part 2");
    CreateGroupViewController *controller = (CreateGroupViewController *)segue.destinationViewController;
    controller.friendsAdded = friendsToAdd;

}


@end
