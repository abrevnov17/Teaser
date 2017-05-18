//
//  HomeViewController.m
//  Teaser
//
//  Created by Anatoly Brevnov on 5/4/17.
//  Copyright © 2017 Anatoly Brevnov. All rights reserved.
//

#import "HomeViewController.h"
#import "Teaser.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if (![Teaser isUserLoggedIn]){
        //segue to login view -> user is not logged in yet
        [self performSegueWithIdentifier:@"authentication" sender:self];

    }
    
    //user is logged in
    
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
