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

@class FriendsListViewController;

@protocol FriendsListViewControllerDelegate <NSObject>
- (void)updateFriendsToAdd:(FriendsListViewController *)controller withFriendsToAdd:(NSMutableArray *)friendsToAdd;
@end

@interface FriendsListViewController : UITableViewController

@property (nonatomic,retain)NSString *uid;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic, weak) id <FriendsListViewControllerDelegate> delegate;


@end
