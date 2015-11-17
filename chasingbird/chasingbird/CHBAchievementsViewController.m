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

- (void)achievementsTableViewDidGetViewController:(UIViewController*)viewController {
    [self presentViewController:viewController animated:YES completion:^{
        
    }];
}

@end
