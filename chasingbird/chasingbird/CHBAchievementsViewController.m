//
//  CHBAchievementsViewController.m
//  chasingbird
//
//  Created by Rock Lee on 2015-11-09.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBAchievementsViewController.h"
#import "CHBGameKitHelper.h"

@interface CHBAchievementsViewController ()

@end

@implementation CHBAchievementsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
            // Process the array of achievements.
        }
    }];
}

@end
