//
//  PlayForFunGameViewController.m
//  Teaser
//
//  Created by Anatoly Brevnov on 5/19/17.
//  Copyright © 2017 Anatoly Brevnov. All rights reserved.
//

// This is our viewcontroller that handles all of the gameplay for the play for fun game mode. It follows a very simple game logic: users get presented with a bunch of riddles. Every two correct answers increases the difficulty by one (which we keep track of using our streak variable), with a maximum dificulty of 10 and an initial, minimum difficutly of 1.

#import "PlayForFunGameViewController.h"

@interface PlayForFunGameViewController ()

@end

@implementation PlayForFunGameViewController

//synthesizing properties from header file

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
@synthesize difficultyLabel;
@synthesize correctAnswer;

//declaring some helpful variables

int countdownNumber;
int timerNumber;
int difficulty;
int streak;

NSString *uid;
NSString *problem_type;
BOOL isBetweenGames;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //setting up the gesture recognizer for a tap which we use to continue the game after each round
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRegistered:)];
    [self.view addGestureRecognizer:tap];
    
    //initializing some of our variables
    
    countdownNumber = 3;
    timerNumber = 60;
    difficulty = 1;
    correctAnswer = @"";
    problem_type = @"";
    streak = 0;
    isBetweenGames = NO;
    
    //centering text for multiple choice buttons
    optionAButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    optionBButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    optionCButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    optionDButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //centering text for input textfield
    inputAnswerTextField.textAlignment = NSTextAlignmentCenter;

    //getting our uid using user function
    uid = [Teaser getCurrentUserUID];
    
    //initiating our countdown sequence
    
    [self initiateCountdown];
    
    //we now want to preload our data while the countdown occurs to reduce latency
    
    [self preloadData];
}

-(void)initiateGame {
    
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
    self.difficultyLabel.hidden = NO;
    
    self.countdownLabel.hidden = YES;
    
    
    if ([problem_type isEqualToString:@"image_text_options"]){
        inputAnswerTextField.hidden = YES;
        submitAnswerButton.hidden = YES;
        topTextView.hidden = YES;
    }
    else if ([problem_type isEqualToString:@"image_text_choice"]){
        optionAButton.hidden = YES;
        optionBButton.hidden = YES;
        optionCButton.hidden = YES;
        optionDButton.hidden = YES;
        topTextView.hidden = YES;
    }
    else if ([problem_type isEqualToString:@"text_text_options"]){
        inputAnswerTextField.hidden = YES;
        submitAnswerButton.hidden = YES;
        topImageView.hidden = YES;
    }
    else {
        optionAButton.hidden = YES;
        optionBButton.hidden = YES;
        optionCButton.hidden = YES;
        optionDButton.hidden = YES;
        topImageView.hidden = YES;
    }

    //now we would like to initiate our timer that counts down how much time the user has (found in upper right corner)
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCountDown:) userInfo:nil repeats:YES];

}

-(void)preloadData {
    //getting a problem from our database using our wrapper
    
    //our getProblemIDForDifficulty function takes the difficulty paramater as a string so:
    NSString *difficultyAsAString = [NSString stringWithFormat:@"%d",difficulty];
    
    [Teaser getProblemIDForDifficulty:uid withDifficulty:difficultyAsAString withCompletion:^(NSString *problem_uid){
        //now that we have our problem_uid, we need to get the problem_type
        
        [Teaser getProblemType:uid withProblemID:problem_uid withCompletion:^(NSString *problemType){
            //we have our problem type, now we need to hide our unhide certain views depending on the type of problem
            
            problem_type = problemType;
            
            //getting the correct answer
            
            [Teaser getProblemCorrectAnswer:uid withProblemID:problem_uid withCompletion:^(NSString *correctAns){
                //setting correct answer
                self.correctAnswer = correctAns;
            }];
            
            //getting the question text
            [Teaser getProblemQuestionText:uid withProblemID:problem_uid withCompletion:^(NSString *questionText){
                //setting bottomTextView text
                self.bottomTextView.text = questionText;
                
            }];
            
            //now we have to populate the views
            
            if ([problemType isEqualToString:@"image_text_options"] || [problemType isEqualToString:@"image_text_choice"]){
                //getting the image using our wrapper function
                
                [Teaser getProblemHeaderImage:uid withProblemID:problem_uid withCompletion:^(UIImage *headerImage){
                    //we have successfully gotten our image, so now we set the uiimageview's image to be the retrieved headerImage
                    
                    [self.topImageView setImage:headerImage];
                    
                }];
                
            }
            
            else {
                //this is a question that has a header text field, so we now get the header text value using our wrapper
                
                [Teaser getProblemHeaderText:uid withProblemID:problem_uid withCompletion:^(NSString *headerText){
                    //setting the header text
                    self.topTextView.text = headerText;
                }];
            }
            
            if ([problemType containsString:@"options"]){
                //general multiple choice question
                
                //setting multiple choice button options
                [Teaser getProblemOptionA:uid withProblemID:problem_uid withCompletion:^(NSString *optionA){
                    [optionAButton setTitle:optionA forState:UIControlStateNormal];
                }];
                
                [Teaser getProblemOptionB:uid withProblemID:problem_uid withCompletion:^(NSString *optionB){
                    [optionBButton setTitle:optionB forState:UIControlStateNormal];
                }];
                
                [Teaser getProblemOptionC:uid withProblemID:problem_uid withCompletion:^(NSString *optionC){
                    [optionCButton setTitle:optionC forState:UIControlStateNormal];
                }];
                
                [Teaser getProblemOptionD:uid withProblemID:problem_uid withCompletion:^(NSString *optionD){
                    [optionDButton setTitle:optionD forState:UIControlStateNormal];
                }];
                
            }
            
        }];
    }];

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
    self.difficultyLabel.hidden = YES;

    
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

- (void)timeCountDown:(NSTimer *)timer
{
    timerNumber--;
    //updating label
    self.timeIndicatorLabel.text = [NSString stringWithFormat:@"%ds",timerNumber];
    if (timerNumber <= 0) {
        [timer invalidate];
        timerNumber = 60; //setting up the countdown for the next time it is needed
        //countdown has completed
        [self gameLost];
        
    }
    
    if (isBetweenGames){
        //previous game cycle has ended, so we need to delete the previous timer
        [timer invalidate];
    }
}

-(void)gameWon {
    //user has won the round
    
    //hiding all of the subviews
    for (UIView *subview in self.view.subviews)
    {
        subview.hidden = YES;
    }
    
    //unhiding the count label, which we change the text to say whether the user won or lost
    self.countdownLabel.hidden = NO;
    self.countdownLabel.text = @"Correct!";
    
    //checking if we need to up the difficulty or not using our streak variable
    
    streak++;
    
    if (streak >= 2){
        //we need to inrease the difficulty level
        if (difficulty < 10){
            //we need this if statement so our difficulty does not exceed the maximum possible
            difficulty++;
            //changing difficultyLabel text
            self.difficultyLabel.text = [NSString stringWithFormat:@"Difficulty: %d",difficulty];
        }
        
        //we reset the streak variable
        
        streak = 0;
    }
    
    //setting our boolean to keep track of our state so the function called by the gesture recognizer will work
    
    isBetweenGames = YES;
}

-(void)gameLost {
    //user has lost the round
    
    //hiding all of the subviews
    
    for (UIView *subview in self.view.subviews)
    {
        subview.hidden = YES;
    }
    
    //unhiding the count label, which we change the text to say whether the user won or lost
    self.countdownLabel.hidden = NO;
    self.countdownLabel.text = @"Incorrect!";
    
    //we reset our streak variable because we answered incorrectly
    
    streak = 0;
    
    //setting our boolean to keep track of our state so the function called by the gesture recognizer will work
    
    isBetweenGames = YES;
    
}

-(IBAction)optionAPressed:(id)sender{
    //option button a pressed
    
    //checking if answer is correct
    
    if ([optionAButton.titleLabel.text isEqualToString:correctAnswer]){
        //correct answer was selected
        
        [self gameWon];
        
    }
    
    else {
        //incorrect answer was selected
        
        [self gameLost];

    }
    
}
-(IBAction)optionBPressed:(id)sender{
    //option button b pressed
    
    //checking if answer is correct
    
    if ([optionBButton.titleLabel.text isEqualToString:correctAnswer]){
        //correct answer was selected
        
        [self gameWon];

    }
    
    else {
        //incorrect answer was selected
        
        [self gameLost];

    }
    
    
}
-(IBAction)optionCPressed:(id)sender{
    //option button c pressed
    
    //checking if answer is correct
    
    if ([optionCButton.titleLabel.text isEqualToString:correctAnswer]){
        //correct answer was selected
        [self gameWon];

    }
    
    else {
        //incorrect answer was selected
        
        [self gameLost];

    }
    
    
}
-(IBAction)optionDPressed:(id)sender{
    //option button d pressed
    
    //checking if answer is correct
    
    if ([optionDButton.titleLabel.text isEqualToString:correctAnswer]){
        //correct answer was selected
        
        [self gameWon];

    }
    
    else {
        //incorrect answer was selected
        
        [self gameLost];
    }
    
    
}

-(IBAction)submitButtonPressed:(id)sender{
    //submit button was pressed
    //checking if answer is correct
    
    if ([[inputAnswerTextField.text lowercaseString] isEqualToString:correctAnswer]){
        //correct answer was selected
        
        [self gameWon];
        
    }
    
    else {
        //incorrect answer was selected
        
        [self gameLost];
    }

}

- (void)tapRegistered:(UITapGestureRecognizer *)recognizer
{
    //we want to check whether we are in the right mode, and if we are, we want to initiate a new game cycle
    
    if (isBetweenGames){
        //we are between game cycles
        
        //reseting some variables to prepare for new game cycle
        isBetweenGames = NO;
        self.countdownLabel.text = @"3";
        timerNumber = 60;
        
        //we now want to preload our data while the countdown occurs to reduce latency
        
        [self preloadData];
        
        //initiating our countdown sequence
        
        [self initiateCountdown];
        

    }
    
    else {
        //in case of keyboard being up, we want to resign that first responder
        
        [self.view endEditing:YES];
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
