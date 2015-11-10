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

@interface CHBLeaderboardViewController ()
@property (weak, nonatomic) IBOutlet CHBLeaderboardTableView *tableView;
@property (nonatomic, retain) NSArray *leaderboards;
@property (nonatomic, retain) GKLeaderboard *leaderboard;
@end

@implementation CHBLeaderboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

@end
