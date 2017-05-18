//
//  CreateGroupViewController.m
//  
//
//  Created by Anatoly Brevnov on 5/12/17.
//
//

#import "CreateGroupViewController.h"

@interface CreateGroupViewController ()

@end

@implementation CreateGroupViewController

@synthesize groupNameTextField;
@synthesize groupDescriptionTextField;
@synthesize friendsAdded;
@synthesize uid;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    friendsAdded = [[NSMutableArray alloc] init];
    
    uid = [Teaser getCurrentUserUID];
    
    //adding a gesture recognizer to remove keyboard when user taps outside of it
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:gestureRecognizer];
}

-(IBAction)submit:(id)sender{
    //submit button pressed
    
    NSString *groupName = groupNameTextField.text;
    NSString *groupDescription = groupDescriptionTextField.text;
    NSString *numberOfMembers = [NSString stringWithFormat:@"%lu", (unsigned long)(friendsAdded.count+1)];
    
    //checking for invalid strings
    if (![groupName isEqualToString:@" "] && ![groupName isEqualToString:@""] && groupName!=nil && ![groupDescription isEqualToString:@" "] && ![groupDescription isEqualToString:@""] && groupDescription!=nil){
        //creating our group
        [Teaser createGroup:groupName withNumberOfMembers:numberOfMembers withDescription:groupDescription withAdminUID:uid withMembers:friendsAdded withCompletion:^(NSString *success){
            if ([success containsString:@"success"]){
                //successfuly created a group -> consider adding a UIAlertController here, some kind of animation, or a forced transition
            }
            else {
                //failed to create a group
                
                //simple alertController notifying the user that there was an error
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Invalid Group"
                                                                                         message:success
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                //We add buttons to the alert controller by creating UIAlertActions:
                UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                   style:UIAlertActionStyleDefault
                                                                 handler:nil];
                [alertController addAction:actionOk];
                [self presentViewController:alertController animated:YES completion:nil];

                
            }
            
        }];
        
        
    }
}

-(IBAction)addFriends:(id)sender{
    //optional
}

- (void)hideKeyboard {
    //selector that hides our keyboard, triggered by tap gesture recognizer
    
    [self.view endEditing:YES];
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
