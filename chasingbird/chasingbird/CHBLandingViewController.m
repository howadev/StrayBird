//
//  CHBLandingViewController.m
//  chasingbird
//
//  Created by Rock Lee on 2015-11-09.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBLandingViewController.h"
#import "CHBGameKitHelper.h"
#import "CHBAchievementsViewController.h"
#import "CHBLeaderboardViewController.h"
#import "CHBChallengeViewController.h"
#import "CHBMapViewController.h"
#import "CHBPerformanceViewController.h"
#import "CHBConf.h"
#import "CHBTracker.h"

@interface CHBLandingViewController () <GKGameCenterControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *leaderboardButton;
@property (weak, nonatomic) IBOutlet UIButton *achievementsButton;
@property (weak, nonatomic) IBOutlet UIButton *challengeInboxButton;

@end

@implementation CHBLandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBackButton];
    
    switch ([CHBConf initialGroup]) {
        case CHBGroupFirst:
            break;
        case CHBGroupSecond:
            break;
        case CHBGroupThird:
            self.leaderboardButton.userInteractionEnabled = [CHBConf daysSinceFirstOpenTime] > 20;
            self.achievementsButton.userInteractionEnabled = [CHBConf daysSinceFirstOpenTime] > 50;
            self.challengeInboxButton.userInteractionEnabled = [CHBConf daysSinceFirstOpenTime] > 70;
    }
}

-(void)showLeaderboardAndAchievements:(BOOL)shouldShowLeaderboard{
    GKGameCenterViewController *gcViewController = [[GKGameCenterViewController alloc] init];
    
    gcViewController.gameCenterDelegate = self;
    
    if (shouldShowLeaderboard) {
        gcViewController.viewState = GKGameCenterViewControllerStateLeaderboards;
        gcViewController.leaderboardIdentifier = [CHBGameKitHelper sharedGameKitHelper].leaderboardIdentifier;
    } else{
        gcViewController.viewState = GKGameCenterViewControllerStateAchievements;
    }
    
    [self presentViewController:gcViewController animated:YES completion:nil];
}

#pragma mark - Actions

- (IBAction)startGameAction:(id)sender {
    [CHBTracker createEventWithCategory:@"MultiPlayNowButton" action:@"Tap"];
    CHBMapViewController *vc = [CHBMapViewController new];
    vc.multiplePlayers = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)performanceAction:(id)sender {
    [CHBTracker createEventWithCategory:@"PerformanceButton" action:@"Tap"];
    CHBPerformanceViewController *vc = [CHBPerformanceViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)leaderBoardAction:(id)sender {
    [CHBTracker createEventWithCategory:@"LeaderBoardButton" action:@"Tap"];
    //[self showLeaderboardAndAchievements:YES];
    CHBLeaderboardViewController *vc = [CHBLeaderboardViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)achievementsAction:(id)sender {
    [CHBTracker createEventWithCategory:@"AchievementsButton" action:@"Tap"];
    //[self showLeaderboardAndAchievements:NO];
    CHBAchievementsViewController *vc = [CHBAchievementsViewController new];
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)inboxAction:(id)sender {
    [CHBTracker createEventWithCategory:@"InboxButton" action:@"Tap"];
    CHBChallengeViewController *vc = [CHBChallengeViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - GKGameCenterControllerDelegate

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
