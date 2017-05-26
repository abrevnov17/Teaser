//
//  MultiplayerGameViewController.m
//  Teaser
//
//  Created by Anatoly Brevnov on 5/23/17.
//  Copyright © 2017 Anatoly Brevnov. All rights reserved.
//

#import "MultiplayerGameViewController.h"

@interface MultiplayerGameViewController ()

@end

@implementation MultiplayerGameViewController
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
@synthesize groupUID;

//declaring some helpful variables

int countdownNumber;
int timerNumber;

NSString *uid;
NSString *problem_type;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //initializing some of our variables
    
    countdownNumber = 3;
    timerNumber = 60;
    correctAnswer = @"";
    problem_type = @"";
    
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
    
    //immediately we update the group member last answered problem timestamp

    [Teaser updateGroupMemberLastAnsweredTimestamp:uid withGroupUID:groupUID withCompletion:^(NSString *success){
        //updated the timestamp for the group member to indicate that he has answered the current question
    }];
    
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
    
    [Teaser getGroupCurrentProblemUID:groupUID withCompletion:^(NSString *problem_uid){
        //now that we have our problem_uid, we need to get the problem_type
        [Teaser getProblemType:uid withProblemID:problem_uid withCompletion:^(NSString *problemType){
            //we have our problem type, now we need to hide our unhide certain views depending on the type of problem
            
            problem_type = problemType;
            
            //getting the correct answer
            [Teaser getProblemCorrectAnswer:uid withProblemID:problem_uid withCompletion:^(NSString *correctAns){
                //setting correct answer
                self.correctAnswer = correctAns;
            }];
            
            //getting problem difficulty
            [Teaser getProblemDifficultyRating:uid withProblemID:problem_uid withCompletion:^(NSString *problemDifficulty){
                //changing difficulty label text to display correct information
                self.difficultyLabel.text = [NSString stringWithFormat:@"Difficulty: %@",problemDifficulty];
            }];
            
            //getting the question text
            [Teaser getProblemQuestionText:uid withProblemID:problem_uid withCompletion:^(NSString *questionText){
                //setting bottomTextView text
                self.bottomTextView.text = questionText;
                
            }];
            
            //now we have to populate the views
            
            if ([problemType isEqualToString:@"image_text_options"] || [problemType isEqualToString:@"image_text_choice"]){
                //getting the image -> STILL NEEDS TO BE DONE!!! (first need to update the REST API and then the wrapper before adding it here)
                
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
    
    [Teaser addToGroupMemberScore:uid withGroupUID:groupUID withScoreToAdd:@"10" withCompletion:^(NSString *success){
        //added 10 to the user group member score
    }];
    

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
    
    if ([[inputAnswerTextField.text lowercaseString] containsString:correctAnswer]){
        //correct answer was selected
        
        [self gameWon];
        
    }
    
    else {
        //incorrect answer was selected
        
        [self gameLost];
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
