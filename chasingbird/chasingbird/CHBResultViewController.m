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

@interface CHBResultViewController ()
@property (weak, nonatomic) IBOutlet CHBResultTableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *starView;
@property (weak, nonatomic) IBOutlet UIImageView *titleLevelView;
@property (weak, nonatomic) IBOutlet UIImageView *headingView;
@property (weak, nonatomic) IBOutlet UIImageView *resultStatusView;
@end

@implementation CHBResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.performance = self.performance;
    [self.tableView reloadData];
    
    switch (self.level) {
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
    
    CHBMapLevelViewsStarMode starMode = [[CHBPerformanceHelper sharedHelper] starModeWithGameLevel:self.level];
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
}

#pragma mark - Actions

- (IBAction)homeAction:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:homeNotification object:nil];
}

- (IBAction)restartAction:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
    NSDictionary *dict = @{@"level":@(self.level)};
    [[NSNotificationCenter defaultCenter] postNotificationName:restartNotification object:nil userInfo:dict];
}

@end
