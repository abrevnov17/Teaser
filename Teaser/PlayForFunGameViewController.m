//
//  PlayForFunGameViewController.m
//  Teaser
//
//  Created by Anatoly Brevnov on 5/19/17.
//  Copyright © 2017 Anatoly Brevnov. All rights reserved.
//

// This is our viewcontroller that handles all of the gameplay for the play for fun game mode. It follows a very simple game logic: users get presented with a bunch of riddles. Every two correct answers increases the difficulty by one, with a maximum dificulty of 10 and an initial, minimum difficutly of 1.

#import "PlayForFunGameViewController.h"

@interface PlayForFunGameViewController ()

@end

@implementation PlayForFunGameViewController

@synthesize topImageView;
@synthesize topTextView;
@synthesize bottomTextView;
@synthesize optionAButton;
@synthesize optionBButton;
@synthesize optionCButton;
@synthesize optionDButton;
@synthesize inputAnswerTextField;
@synthesize submitAnswerButton;
@synthesize timeIndicatorLabel;
@synthesize countdownLabel;

int countdownNumber;
int difficulty;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    countdownNumber = 3;
    difficulty = 1;
    
    //initiating our countdown sequence
    
    [self initiateCountdown];
}

-(void)initiateGame {
    //initiating the actual game
    
    //hiding/unhiding necessary subviews
    
    self.topImageView.hidden = NO;
    self.topTextView.hidden = NO;
    self.bottomTextView.hidden = NO;
    self.optionAButton.hidden = NO;
    self.optionBButton.hidden = NO;
    self.optionCButton.hidden = NO;
    self.optionDButton.hidden = NO;
    self.inputAnswerTextField.hidden = NO;
    self.submitAnswerButton.hidden = NO;
    self.timeIndicatorLabel.hidden = NO;
    
    self.countdownLabel.hidden = YES;
    
    //getting a problem from our database using our wrapper
    
    

    
}

-(void)initiateCountdown {
    
    //hiding all necessary subviews
    
    self.topImageView.hidden = YES;
    self.topTextView.hidden = YES;
    self.bottomTextView.hidden = YES;
    self.optionAButton.hidden = YES;
    self.optionBButton.hidden = YES;
    self.optionCButton.hidden = YES;
    self.optionDButton.hidden = YES;
    self.inputAnswerTextField.hidden = YES;
    self.submitAnswerButton.hidden = YES;
    self.timeIndicatorLabel.hidden = YES;
    
    //verifying that the countdown label is not hidden
    
    self.countdownLabel.hidden = NO;
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countdownTimer:) userInfo:nil repeats:YES];

}

- (void)countdownTimer:(NSTimer *)timer
{
    countdownNumber--;
    //updating label
    self.countdownLabel.text = [NSString stringWithFormat:@"%d",countdownNumber];
    if (countdownNumber <= 0) {
        [timer invalidate];
        countdownNumber = 3; //setting up the countdown for the next time it is needed
        //countdown has completed
        [self initiateGame];
        
    }
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
