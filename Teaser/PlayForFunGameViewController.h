//
//  PlayForFunGameViewController.h
//  Teaser
//
//  Created by Anatoly Brevnov on 5/19/17.
//  Copyright © 2017 Anatoly Brevnov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayForFunGameViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *topImageView;
@property (strong, nonatomic) IBOutlet UITextView *topTextView;
@property (strong, nonatomic) IBOutlet UITextView *bottomTextView;
@property (strong, nonatomic) IBOutlet UIButton *optionAButton;
@property (strong, nonatomic) IBOutlet UIButton *optionBButton;
@property (strong, nonatomic) IBOutlet UIButton *optionCButton;
@property (strong, nonatomic) IBOutlet UIButton *optionDButton;
@property (strong, nonatomic) IBOutlet UITextField *inputAnswerTextField;
@property (strong, nonatomic) IBOutlet UIButton *submitAnswerButton;
@property (strong, nonatomic) IBOutlet UILabel *timeIndicatorLabel;
@property (strong, nonatomic) IBOutlet UILabel *countdownLabel;

@end
