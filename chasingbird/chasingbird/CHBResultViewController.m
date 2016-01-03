//
//  CHBResultViewController.m
//  chasingbird
//
//  Created by Rock Lee on 2015-10-18.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBResultViewController.h"
#import "CHBResultTableView.h"
#import "CHBPerformanceHelper.h"
#import "CHBGameKitHelper.h"

@interface CHBResultViewController ()
@property (weak, nonatomic) IBOutlet CHBResultTableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *starView;
@property (weak, nonatomic) IBOutlet UIImageView *titleLevelView;
@property (weak, nonatomic) IBOutlet UIImageView *headingView;
@property (weak, nonatomic) IBOutlet UIImageView *resultStatusView;
@property (weak, nonatomic) IBOutlet UILabel *pointLabel;
@end

@implementation CHBResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[CHBPerformanceHelper sharedHelper] updateWithPerformance:self.performance];
    
    self.tableView.performance = self.performance;
    [self.tableView reloadData];
    
    switch (self.performance.level) {
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
    
    CHBMapLevelViewsStarMode starMode = self.performance.starMode;
    switch (starMode) {
        case CHBMapLevelViewStarModeInactive:
            NSAssert(NO, @"Should not be here");
            break;
        case CHBMapLevelViewStarModeNone:
            self.starView.image = [UIImage imageNamed:@"game_single_pause_stars_0"];
            break;
        case CHBMapLevelViewStarModeOne:
            self.starView.image = [UIImage imageNamed:@"game_single_pause_stars_1"];
            break;
        case CHBMapLevelViewStarModeTwo:
            self.starView.image = [UIImage imageNamed:@"game_single_pause_stars_2"];
            break;
        case CHBMapLevelViewStarModeThree:
            self.starView.image = [UIImage imageNamed:@"game_single_pause_stars_3"];
            break;
    }

    self.resultStatusView.highlighted = self.performance.win;
    self.pointLabel.text = [NSString stringWithFormat:@"%ld", self.performance.points];
    
    if (self.multiplePlayers) {
        if (self.performance.maximumSpeed > 8 * 1000 / 60) {
            [[CHBGameKitHelper sharedGameKitHelper] reportAchievementWithIdentifier:@"NoSlowingDown1"];
        }
        if (self.performance.maximumSpeed > 9 * 1000 / 60) {
            [[CHBGameKitHelper sharedGameKitHelper] reportAchievementWithIdentifier:@"NoSlowingDown2"];
        }
        if (self.performance.maximumSpeed > 10 * 1000 /60) {
            [[CHBGameKitHelper sharedGameKitHelper] reportAchievementWithIdentifier:@"NoSlowingDown3"];
        }
        
        if (self.performance.overallCalories > 500) {
            [[CHBGameKitHelper sharedGameKitHelper] reportAchievementWithIdentifier:@"BurningItOff1"];
        }
        if (self.performance.overallCalories > 1000) {
            [[CHBGameKitHelper sharedGameKitHelper] reportAchievementWithIdentifier:@"BurningItOff2"];
        }
        if (self.performance.overallCalories > 2500) {
            [[CHBGameKitHelper sharedGameKitHelper] reportAchievementWithIdentifier:@"BurningItOff3"];
        }
        
        if ([CHBPerformanceHelper sharedHelper].points > 5000) {
            [[CHBGameKitHelper sharedGameKitHelper] reportAchievementWithIdentifier:@"PointAficionado1"];
        }
        if ([CHBPerformanceHelper sharedHelper].points > 10000) {
            [[CHBGameKitHelper sharedGameKitHelper] reportAchievementWithIdentifier:@"PointAficionado2"];
        }
        if ([CHBPerformanceHelper sharedHelper].points > 20000) {
            [[CHBGameKitHelper sharedGameKitHelper] reportAchievementWithIdentifier:@"PointAficionado3"];
        }
        
        [[CHBGameKitHelper sharedGameKitHelper] reportScore:[CHBPerformanceHelper sharedHelper].points];
    }
}

#pragma mark - Actions

- (IBAction)homeAction:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:homeNotification object:nil];
}

- (IBAction)restartAction:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
    NSDictionary *dict = @{@"level":@(self.level),
                           @"multiplePlayers":@(self.multiplePlayers)};
    [[NSNotificationCenter defaultCenter] postNotificationName:restartNotification object:nil userInfo:dict];
}

@end
