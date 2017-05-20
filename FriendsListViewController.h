//
//  FriendsListViewController.h
//  
//
//  Created by Anatoly Brevnov on 5/15/17.
//
//

#import <UIKit/UIKit.h>
#import "Teaser.h"
#import "CreateGroupViewController.h"

@interface FriendsListViewController : UITableViewController

@property (nonatomic,retain)NSString *uid;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property(nonatomic,assign)id delegate;


@end
