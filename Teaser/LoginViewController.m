//
//  LoginViewController.m
//  Teaser
//
//  Created by Anatoly Brevnov on 5/6/17.
//  Copyright © 2017 Anatoly Brevnov. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize usernameTextField;
@synthesize passwordTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //adding a gesture recognizer to remove keyboard when user taps outside of it
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:gestureRecognizer];
}

-(IBAction)submitLogin:(id)sender{
    //login button pressed
    
    NSString *username = usernameTextField.text;
    NSString *password = passwordTextField.text;
    
    [Teaser login:username withPassword:password withCompletion:^(NSString *success) {
    
        if ([success containsString: @"success"]){
            //login user using keychain
            
            NSError *error = nil;
            
            NSArray *components = [success componentsSeparatedByString: @":"];
            
            [FDKeychain saveItem: components[1]
                          forKey: @"uid"
                      forService: @"Teaser"
                           error: &error];
            
            //seguing to home
            
            [self performSegueWithIdentifier:@"loginToHome" sender:self];
            
        }
        else {

            //simple alertController

            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Invalid Information"
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
