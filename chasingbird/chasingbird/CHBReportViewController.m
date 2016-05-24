//
//  CHBReportViewController.m
//  StrayBird
//
//  Created by Rock Lee on 2016-05-23.
//  Copyright © 2016 howalee. All rights reserved.
//

#import "CHBReportViewController.h"
#import "UIView+AutoLayoutHelpers.h"
#import "CHBTypes.h"
#import "CHBTracker.h"
@import HockeySDK;

@interface CHBReportViewController () <BITFeedbackComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *questionButton;
@property (weak, nonatomic) IBOutlet UIButton *veryDiscourageButton;
@property (weak, nonatomic) IBOutlet UIButton *mildDiscourageButton;
@property (weak, nonatomic) IBOutlet UIButton *noDifferenceButton;
@property (weak, nonatomic) IBOutlet UIButton *mildEncourageButton;
@property (weak, nonatomic) IBOutlet UIButton *veryEncourageButton;

@property (retain, nonatomic) UITextView *commentView;
@property (retain, nonatomic) UIButton *sendButton;
@property (retain, nonatomic) NSString *reportString;
@end

@implementation CHBReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sendButton = [UIButton new];
    self.sendButton.translatesAutoresizingMaskIntoConstraints = NO;
    self.sendButton.alpha = 0;
    self.sendButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.sendButton setBackgroundImage:[UIImage imageNamed:@"game_pause_status-item_title"] forState:UIControlStateNormal];
    [self.sendButton setTitle:@"Send" forState:UIControlStateNormal];
    [self.view addSubview:self.sendButton];
    [self.view pinItem:self.sendButton attribute:NSLayoutAttributeRight to:self.questionButton];
    [self.view pinItem:self.sendButton attribute:NSLayoutAttributeLeft to:self.questionButton];
    [self.view pinItem:self.sendButton attribute:NSLayoutAttributeHeight to:self.questionButton];
    [self.view pinItem:self.sendButton attribute:NSLayoutAttributeTop to:self.veryEncourageButton toAttribute:NSLayoutAttributeBottom withOffset:16 andScale:1];
    [self.sendButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.questionButton.userInteractionEnabled = NO;
    
    for (UIButton *button in @[self.questionButton, self.veryDiscourageButton, self.mildDiscourageButton, self.noDifferenceButton, self.mildEncourageButton, self.veryEncourageButton, self.sendButton]) {
        button.clipsToBounds = YES;
        button.layer.cornerRadius = 10;
    }
    
    self.commentView = [UITextView new];
    self.commentView.font = [UIFont systemFontOfSize:16];
    self.commentView.tintColor = [UIColor whiteColor];
    self.commentView.textColor = [UIColor whiteColor];
    self.commentView.backgroundColor = [UIColor colorWithRed:60/255.0 green:119/255.0 blue:119/255.0 alpha:1.0];
    self.commentView.alpha = 0;
    self.commentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.commentView];
    [self.view pinItem:self.commentView attribute:NSLayoutAttributeTop to:self.veryDiscourageButton];
    [self.view pinItem:self.commentView attribute:NSLayoutAttributeLeft to:self.veryDiscourageButton];
    [self.view pinItem:self.commentView attribute:NSLayoutAttributeRight to:self.veryDiscourageButton];
    [self.view pinItem:self.commentView attribute:NSLayoutAttributeBottom to:self.veryEncourageButton];
    
}

# pragma mark - Actions

- (void)didTapButton:(id)sender {
    if ([sender isKindOfClass:[UIButton class]]) {
        self.reportString = ((UIButton*)sender).titleLabel.text;
    }

    [self reportAction];
    
    /*
    [UIView animateWithDuration:1.0 animations:^{
        for (UIButton *button in @[self.veryDiscourageButton, self.mildDiscourageButton, self.noDifferenceButton, self.mildEncourageButton, self.veryEncourageButton]) {
            button.alpha = 0;
        }
        [self.questionButton setTitle:@"More comments?" forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        self.sendButton.alpha = 1;
        self.commentView.alpha = 1;
        [self.commentView becomeFirstResponder];
    }];
     */
}

- (IBAction)veryDiscourageAction:(id)sender {
    [CHBTracker createEventWithCategory:@"VeryDiscourageButton" action:@"Tap"];
    [self didTapButton:sender];
}

- (IBAction)mildDiscourageAction:(id)sender {
    [CHBTracker createEventWithCategory:@"MildDiscourageButton" action:@"Tap"];
   [self didTapButton:sender];
}

- (IBAction)noDifferenceAction:(id)sender {
    [CHBTracker createEventWithCategory:@"NoDifferenceButton" action:@"Tap"];
    [self didTapButton:sender];
}

- (IBAction)mildEncourageAction:(id)sender {
    [CHBTracker createEventWithCategory:@"MildEncourageButton" action:@"Tap"];
    [self didTapButton:sender];
}

- (IBAction)veryEncourageAction:(id)sender {
    [CHBTracker createEventWithCategory:@"VeryEncourageButton" action:@"Tap"];
    [self didTapButton:sender];
}

- (void)sendAction:(id)sender {
    NSString *finalReport = [NSString stringWithFormat:@"%@\n%@", self.reportString, self.commentView.text];
    NSLog(@"%@", finalReport);
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:homeNotification object:nil];
    }];
}

- (void)reportAction {
    BITFeedbackComposeViewController *feedbackCompose = [[BITHockeyManager sharedHockeyManager].feedbackManager feedbackComposeViewController];
    feedbackCompose.delegate = self;
    [feedbackCompose prepareWithItems:@[self.reportString]];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:feedbackCompose];
    navController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma mark - BITFeedbackComposeViewControllerDelegate

- (void)feedbackComposeViewController:(BITFeedbackComposeViewController *)composeViewController didFinishWithResult:(BITFeedbackComposeResult)composeResult {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:homeNotification object:nil];
    }];
}

@end
