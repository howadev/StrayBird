//
//  CHBAchievementsViewController.m
//  chasingbird
//
//  Created by Rock Lee on 2015-11-09.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBAchievementsViewController.h"
#import "CHBGameKitHelper.h"
#import "CHBAchievementsTableView.h"

@interface CHBAchievementsViewController () <CHBAchievementsTableViewDelegate>
@property (weak, nonatomic) IBOutlet CHBAchievementsTableView *tableView;
@end

@implementation CHBAchievementsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.achievementDelegate = self;
    
    [self setupMultiPlayersBackground];
    [self setupBackButton];
    [self loadAchievements];
    
}

- (void)loadAchievements
{
    [GKAchievement loadAchievementsWithCompletionHandler:^(NSArray *achievements, NSError *error) {
        if (error != nil) {
            NSLog(@"Error in loading achievements: %@", error);
        }
        if (achievements != nil) {
            self.tableView.achievements = achievements;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - CHBAchievementsTableViewDelegate

- (void)achievementsTableView:(UITableView *)tableView didSelectAchievement:(GKAchievement *)achievement {
    [[GKLocalPlayer localPlayer] loadFriendPlayersWithCompletionHandler:^(NSArray<GKPlayer *> * _Nullable friendPlayers, NSError * _Nullable error) {
        if (error) {
            return;
        }
        
        UIViewController *vc = [achievement challengeComposeControllerWithMessage:@"Try to beat my achievement" players:friendPlayers completionHandler:^(UIViewController * _Nonnull composeController, BOOL didIssueChallenge, NSArray<NSString *> * _Nullable sentPlayerIDs) {
            [composeController dismissViewControllerAnimated:YES completion:^{
                
            }];
        }];
        
        [self presentViewController:vc animated:YES completion:^{
            
        }];
    }];
}

@end
