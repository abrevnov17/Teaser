//
//  LoginViewController.h
//  Teaser
//
//  Created by Anatoly Brevnov on 5/6/17.
//  Copyright © 2017 Anatoly Brevnov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Teaser.h"
#import "FDKeychain.h"



@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

-(IBAction)submitLogin:(id)sender;

@end
