//
//  GroupPageViewController.h
//  Teaser
//
//  Created by Anatoly Brevnov on 5/28/17.
//  Copyright © 2017 Anatoly Brevnov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Teaser.h"

@interface GroupPageViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *groupNameLabel;
@property (strong, nonatomic) IBOutlet UITableView *groupRankedMembersTableView;
@property (strong, nonatomic) IBOutlet UITextView *groupDescriptionTextView;

//property declared below must be passed in the controller that pops this view controller

@property (nonatomic,retain) NSString *groupUID;

@end
