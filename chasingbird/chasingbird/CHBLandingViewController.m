//
//  CHBLandingViewController.m
//  chasingbird
//
//  Created by Rock Lee on 2015-11-09.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBLandingViewController.h"
#import "CHBGameKitHelper.h"

@interface CHBLandingViewController () <GKGameCenterControllerDelegate>

@end

@implementation CHBLandingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBackButton];
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

- (IBAction)inviteFriendsAction:(id)sender {

}

- (IBAction)performanceAction:(id)sender {
    
}

- (IBAction)leaderBoardAction:(id)sender {
    [self showLeaderboardAndAchievements:YES];
}

- (IBAction)achievementsAction:(id)sender {
    [self showLeaderboardAndAchievements:NO];

}

- (IBAction)inboxAction:(id)sender {

}

#pragma mark - GKGameCenterControllerDelegate

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
