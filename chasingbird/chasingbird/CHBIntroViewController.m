//
//  CHBIntroViewController.m
//  chasingbird
//
//  Created by Rock Lee on 2015-10-17.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBIntroViewController.h"
#import "CHBStartViewController.h"
#import "CHBPerformanceHelper.h"
#import "CHBTypes.h"
#import "CHBTracker.h"

@interface CHBIntroViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *starView;
@property (weak, nonatomic) IBOutlet UIImageView *titleLevelView;
@property (weak, nonatomic) IBOutlet UIImageView *headingView;
@property (weak, nonatomic) IBOutlet UIImageView *nextButton;
@end

@implementation CHBIntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
            self.starView.image = [UIImage imageNamed:@"single_start-level_stars_0"];
            break;
        case CHBMapLevelViewStarModeOne:
            self.starView.image = [UIImage imageNamed:@"single_start-level_stars_1"];
            break;
        case CHBMapLevelViewStarModeTwo:
            self.starView.image = [UIImage imageNamed:@"single_start-level_stars_2"];
            break;
        case CHBMapLevelViewStarModeThree:
            self.starView.image = [UIImage imageNamed:@"single_start-level_stars_3"];
            break;
    }
    
    self.nextButton.userInteractionEnabled = YES;
    [self.nextButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nextButtonDidTap:)]];
    
    [self setupBackButton];
}

- (void)nextButtonDidTap:(id)sender {
    [CHBTracker createEventWithCategory:@"IntroViewNextButton" action:@"Tap"];
    CHBStartViewController *vc = [CHBStartViewController new];
    vc.level = self.level;
    vc.multiplePlayers = self.multiplePlayers;
    [self.navigationController pushViewController:vc animated:NO];
}

@end
