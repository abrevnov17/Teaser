//
//  CreateGroupViewController.h
//  
//
//  Created by Anatoly Brevnov on 5/12/17.
//
//

#import <UIKit/UIKit.h>
#import "Teaser.h"

@interface CreateGroupViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *groupNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *groupDescriptionTextField;
@property (nonatomic, retain) NSMutableArray *friendsAdded;
@property (nonatomic,retain) NSString *uid;

-(IBAction)addFriends:(id)sender;
-(IBAction)submit:(id)sender;

@end
