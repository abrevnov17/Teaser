//
//  GroupsAndRequestsViewController.h
//  Teaser
//
//  Created by Anatoly Brevnov on 5/9/17.
//  Copyright © 2017 Anatoly Brevnov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Teaser.h"
#import "MultiplayerGameViewController.h"
#import "GroupPageViewController.h"

@interface GroupsAndRequestsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedController;
@property (strong, nonatomic) IBOutlet UILabel *topLabel;
@property (strong, nonatomic) IBOutlet UILabel *bottomLabel;
@property (strong, nonatomic) IBOutlet UITableView *topTable;
@property (strong, nonatomic) IBOutlet UITableView *bottomTable;

-(IBAction)segmentControllerValueChanged:(id)sender;
-(IBAction)plusButtonPressed:(id)sender;

@end
