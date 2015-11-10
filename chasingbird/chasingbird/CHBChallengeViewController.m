//
//  CHBChallengeViewController.m
//  chasingbird
//
//  Created by Rock Lee on 2015-11-09.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBChallengeViewController.h"
#import "CHBChallengeTableView.h"
#import "CHBGameKitHelper.h"

@interface CHBChallengeViewController ()
@property (weak, nonatomic) IBOutlet CHBChallengeTableView *tableView;

@end

@implementation CHBChallengeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBackButton];
    [self setupMultiPlayersBackground];
    [self loadChallenges];
}

- (void)loadChallenges
{
    [GKChallenge loadReceivedChallengesWithCompletionHandler:^(NSArray<GKChallenge *> * _Nullable challenges, NSError * _Nullable error) {
        self.tableView.challenges = challenges;
        [self.tableView reloadData];
    }];
}

@end
