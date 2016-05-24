//
//  CHBStartViewController.m
//  chasingbird
//
//  Created by Howard on 2015-08-29.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBStartViewController.h"
#import "CHBTracker.h"

@interface CHBStartViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *titleLevelView;
@property (weak, nonatomic) IBOutlet UIImageView *headingView;
@property (weak, nonatomic) IBOutlet UIButton *cyclingButton;
@property (weak, nonatomic) IBOutlet UIButton *runningButton;
@property (weak, nonatomic) IBOutlet UIButton *ropeSkippingButton;
@end

@implementation CHBStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    switch (self.level) {
        case CHBGameLevelFirst:
            self.headingView.image = [UIImage imageNamed:@"heading_level1"];
            self.titleLevelView.image = [UIImage imageNamed:@"title_level1"];
            break;
        case CHBGameLevelSecond:
            self.headingView.image = [UIImage imageNamed:@"heading_level2"];
            self.titleLevelView.image = [UIImage imageNamed:@"title_level2"];
            break;
        case CHBGameLevelThird:
            self.headingView.image = [UIImage imageNamed:@"heading_level3"];
            self.titleLevelView.image = [UIImage imageNamed:@"title_level3"];
            break;
        default:
            break;
    }
    
    [self setupBackButton];
}

- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:NO];
}

- (IBAction)playAction:(id)sender {
    [CHBTracker createEventWithCategory:@"PlayNowButton" action:@"Tap"];
    NSDictionary *dict = @{@"level":@(self.level),
                           @"multiplePlayers":@(self.multiplePlayers)};
    [[NSNotificationCenter defaultCenter] postNotificationName:playNotification object:nil userInfo:dict];
}

- (IBAction)cyclingAction:(id)sender {
    [CHBTracker createEventWithCategory:@"CyclingButton" action:@"Tap"];
    self.cyclingButton.selected = YES;
    self.runningButton.selected = NO;
    self.ropeSkippingButton.selected = NO;
}

- (IBAction)runningAction:(id)sender {
    [CHBTracker createEventWithCategory:@"RunningButton" action:@"Tap"];
    self.cyclingButton.selected = NO;
    self.runningButton.selected = YES;
    self.ropeSkippingButton.selected = NO;
}

- (IBAction)ropeSkippingAction:(id)sender {
    [CHBTracker createEventWithCategory:@"RopeSkippingButton" action:@"Tap"];
    self.cyclingButton.selected = NO;
    self.runningButton.selected = NO;
    self.ropeSkippingButton.selected = YES;
}

@end
