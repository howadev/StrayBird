//
//  CHBPauseViewController.m
//  chasingbird
//
//  Created by Rock Lee on 2015-10-18.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBPauseViewController.h"
#import "CHBGameViewController.h"
#import "CHBResultTableView.h"
#import "CHBPerformanceHelper.h"

@interface CHBPauseViewController ()
@property (weak, nonatomic) IBOutlet CHBResultTableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *starView;
@property (weak, nonatomic) IBOutlet UIImageView *titleLevelView;
@property (weak, nonatomic) IBOutlet UIImageView *headingView;
@end

@implementation CHBPauseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)resumeAction:(id)sender {
    [self.delegate pauseViewControllerDidTapResume:self];
}

@end
