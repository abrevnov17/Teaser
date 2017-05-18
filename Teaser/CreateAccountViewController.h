//
//  CreateAccountViewController.h
//  Teaser
//
//  Created by Anatoly Brevnov on 5/6/17.
//  Copyright © 2017 Anatoly Brevnov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Teaser.h"
#import "FDKeychain.h"

@interface CreateAccountViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTextField;

-(IBAction)submitCreateAccount:(id)sender;

@end
