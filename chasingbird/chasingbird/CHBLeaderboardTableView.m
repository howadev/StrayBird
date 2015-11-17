//
//  CHBLeaderboardTableView.m
//  chasingbird
//
//  Created by Rock Lee on 2015-11-09.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBLeaderboardTableView.h"
#import "CHBLeaderboardTableViewCell.h"
#import "CHBGameKitHelper.h"

@interface CHBLeaderboardTableView () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation CHBLeaderboardTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initialize];
}

- (void)initialize {
    self.clipsToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rowHeight = 50.0;
    self.scrollEnabled = YES;
    self.showsVerticalScrollIndicator = NO;
    
    [self registerNib:[UINib nibWithNibName:@"CHBLeaderboardTableViewCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([CHBLeaderboardTableViewCell class])];
    self.delegate = self;
    self.dataSource = self;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GKScore *score = self.scores[indexPath.row];
    if (score == nil) {
        return;
    }
    
    [[GKLocalPlayer localPlayer] loadFriendPlayersWithCompletionHandler:^(NSArray<GKPlayer *> * _Nullable friendPlayers, NSError * _Nullable error) {
        if (error) {
            return;
        }
        
        [score challengeComposeControllerWithMessage:@"Try to beat my score" players:friendPlayers completionHandler:^(UIViewController * _Nonnull composeController, BOOL didIssueChallenge, NSArray<NSString *> * _Nullable sentPlayerIDs) {
            
        }];
    }];
    
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.scores.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CHBLeaderboardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CHBLeaderboardTableViewCell class]) forIndexPath:indexPath];
    GKScore *score = self.scores[indexPath.row];
    cell.rankLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row+1];
    cell.nameLabel.text = score.player.displayName;
    cell.pointLabel.text = [NSString stringWithFormat:@"%lld", score.value];
    return cell;
}

@end
