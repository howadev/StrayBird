//
//  CHBLeaderboardViewController.m
//  chasingbird
//
//  Created by Rock Lee on 2015-11-09.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBLeaderboardViewController.h"
#import "CHBLeaderboardTableView.h"
#import "CHBGameKitHelper.h"

@interface CHBLeaderboardViewController () <CHBLeaderboardTableViewDelegate>
@property (weak, nonatomic) IBOutlet CHBLeaderboardTableView *tableView;
@property (nonatomic, retain) NSArray *leaderboards;
@property (nonatomic, retain) GKLeaderboard *leaderboard;
@end

@implementation CHBLeaderboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.leaderboardDelegate = self;
    
    [self setupMultiPlayersBackground];
    [self setupBackButton];
    [self loadLeaderboardInfo];
}

- (void)loadLeaderboardInfo
{
    [GKLeaderboard loadLeaderboardsWithCompletionHandler:^(NSArray *leaderboards, NSError *error) {
        self.leaderboards = leaderboards;
        self.leaderboard = [leaderboards firstObject];
        [self.leaderboard loadScoresWithCompletionHandler:^(NSArray<GKScore *> * _Nullable scores, NSError * _Nullable error) {
            self.tableView.scores = scores;
            [self.tableView reloadData];
        }];
    }];
}

#pragma mark - CHBAchievementsTableViewDelegate

- (void)leaderboardTableView:(UITableView *)tableView didSelectScore:(GKScore *)score {
    [[GKLocalPlayer localPlayer] loadFriendPlayersWithCompletionHandler:^(NSArray<GKPlayer *> * _Nullable friendPlayers, NSError * _Nullable error) {
        if (error) {
            return;
        }
        
        UIViewController *vc = [score challengeComposeControllerWithMessage:@"Try to beat my score" players:friendPlayers completionHandler:^(UIViewController * _Nonnull composeController, BOOL didIssueChallenge, NSArray<NSString *> * _Nullable sentPlayerIDs) {
            [composeController dismissViewControllerAnimated:YES completion:^{
                
            }];
        }];
        
        [self presentViewController:vc animated:YES completion:^{
            
        }];
    }];
}

@end
