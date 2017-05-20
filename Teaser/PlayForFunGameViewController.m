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
int timerNumber;
int difficulty;

NSString *uid;
NSString *correctAnswer;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    countdownNumber = 3;
    timerNumber = 60;
    difficulty = 1;
    correctAnswer = @"";
    
    //centering text for multiple choice buttons
    optionAButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    optionBButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    optionCButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    optionDButton.titleLabel.textAlignment = NSTextAlignmentCenter;

    //getting our uid using user function
    uid = [Teaser getCurrentUserUID];
    
    //initiating our countdown sequence
    
    [self initiateCountdown];
}

-(void)initiateGame {
    //initiating the actual game
    
    correctAnswer = @"";
    
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
    
    //our getProblemIDForDifficulty function takes the difficulty paramater as a string so:
    NSString *difficultyAsAString = [NSString stringWithFormat:@"%d",difficulty];
    
    [Teaser getProblemIDForDifficulty:uid withDifficulty:difficultyAsAString withCompletion:^(NSString *problem_uid){
        //now that we have our problem_uid, we need to get the problem_type
        [Teaser getProblemType:uid withProblemID:problem_uid withCompletion:^(NSString *problemType){
            //we have our problem type, now we need to hide our unhide certain views depending on the type of problem
            if ([problemType isEqualToString:@"image_text_options"]){
                inputAnswerTextField.hidden = YES;
                submitAnswerButton.hidden = YES;
                topTextView.hidden = YES;
            }
            else if ([problemType isEqualToString:@"image_text_choice"]){
                optionAButton.hidden = YES;
                optionBButton.hidden = YES;
                optionCButton.hidden = YES;
                optionDButton.hidden = YES;
                topTextView.hidden = YES;
            }
            else if ([problemType isEqualToString:@"text_text_options"]){
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
            
            //getting the correct answer
            
            [Teaser getProblemCorrectAnswer:uid withProblemID:problem_uid withCompletion:^(NSString *correctAns){
                //setting correct answer
                correctAnswer = correctAns;
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
                    self.optionAButton.titleLabel.text = optionA;
                }];
                
                [Teaser getProblemOptionB:uid withProblemID:problem_uid withCompletion:^(NSString *optionB){
                    self.optionBButton.titleLabel.text = optionB;
                }];
                
                [Teaser getProblemOptionC:uid withProblemID:problem_uid withCompletion:^(NSString *optionC){
                    self.optionCButton.titleLabel.text = optionC;
                }];
                
                [Teaser getProblemOptionD:uid withProblemID:problem_uid withCompletion:^(NSString *optionD){
                    self.optionDButton.titleLabel.text = optionD;
                }];
        
            }
            
            //now we would like to initiate our timer that counts down how much time the user has (found in upper right corner)
            
            [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeCountDown:) userInfo:nil repeats:YES];
            
            
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
