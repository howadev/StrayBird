//
//  CHBMapViewController.m
//  chasingbird
//
//  Created by Howard on 2015-08-26.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBMapViewController.h"
#import "CHBImageView.h"
#import "CHBMapLevelView.h"
#import "UIView+AutoLayoutHelpers.h"
#import "CHBIntroViewController.h"
#import "CHBPerformanceHelper.h"
#import "CHBTracker.h"
#import "CHBConf.h"

@interface CHBMapViewController ()
@property (nonatomic, retain) CHBMapLevelView *firstLevelView;
@property (nonatomic, retain) CHBMapLevelView *secondLevelView;
@property (nonatomic, retain) CHBMapLevelView *thirdLevelView;
@end

@implementation CHBMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CHBImageView *backgroundView = [[CHBImageView alloc] initWithFrame:self.view.bounds];
    backgroundView.image = [UIImage imageNamed:@"single_landing_map"];
    [self.view addSubview:backgroundView];
    
    self.firstLevelView = [CHBMapLevelView new];
    self.firstLevelView.level = CHBGameLevelFirst;
    [self.view addSubview:self.firstLevelView];
    
    self.secondLevelView = [CHBMapLevelView new];
    self.secondLevelView.level = CHBGameLevelSecond;
    [self.view addSubview:self.secondLevelView];
    
    self.thirdLevelView = [CHBMapLevelView new];
    self.thirdLevelView.level = CHBGameLevelThird;
    [self.view addSubview:self.thirdLevelView];
    
    [self.firstLevelView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firstLevelViewDidTap:)]];
    [self.secondLevelView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(secondLevelViewDidTap:)]];
    [self.thirdLevelView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thirdLevelViewDidTap:)]];
    
    [self setupConstraints];
    
    [self setupBackButton];
    
    switch ([CHBConf initialGroup]) {
        case CHBGroupFirst:
            self.firstLevelView.alpha = 1;
            self.secondLevelView.alpha = 0;
            self.thirdLevelView.alpha = 0;
            break;
        case CHBGroupSecond:
            self.firstLevelView.alpha = 1;
            self.secondLevelView.alpha = 1;
            self.thirdLevelView.alpha = 1;
            break;
        case CHBGroupThird:
            self.firstLevelView.alpha = 1;
            self.secondLevelView.alpha = [CHBConf daysSinceFirstOpenTime] > 30 ? 1 : 0;
            self.thirdLevelView.alpha = [CHBConf daysSinceFirstOpenTime] > 60 ? 1 : 0;
            break;
    }
}

- (void)setupConstraints {
    [self.view pinItem:self.view attribute:NSLayoutAttributeRight to:self.firstLevelView withOffset:30.0 andScale:1.0];
    [self.view pinItem:self.view attribute:NSLayoutAttributeBottom to:self.firstLevelView withOffset:80.0 andScale:1.0];
    //[self.view setSizeConstraintsForItem:self.firstLevelView size:CGSizeMake(80, 80)];
    
    [self.view pinItem:self.view attribute:NSLayoutAttributeLeft to:self.secondLevelView withOffset:-70.0 andScale:1.0];
    [self.view pinItemCenterVertically:self.view to:self.secondLevelView];
    //[self.view setSizeConstraintsForItem:self.secondLevelView size:CGSizeMake(80, 80)];
    
    [self.view pinItem:self.view attribute:NSLayoutAttributeRight to:self.thirdLevelView withOffset:80.0 andScale:1.0];
    [self.view pinItem:self.view attribute:NSLayoutAttributeTop to:self.thirdLevelView withOffset:-140.0 andScale:1.0];
    //[self.view setSizeConstraintsForItem:self.thirdLevelView size:CGSizeMake(80, 80)];
}

#pragma mark - UI Actions

- (void)firstLevelViewDidTap:(id)sender {
    [CHBTracker createEventWithCategory:@"FirstLevelButton" action:@"Tap"];
    if ([[CHBPerformanceHelper sharedHelper] gameLevelShouldActivate:CHBGameLevelFirst]) {
        CHBIntroViewController *vc = [CHBIntroViewController new];
        vc.level = CHBGameLevelFirst;
        vc.multiplePlayers = self.multiplePlayers;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)secondLevelViewDidTap:(id)sender {
    [CHBTracker createEventWithCategory:@"SecondLevelButton" action:@"Tap"];
    if ([[CHBPerformanceHelper sharedHelper] gameLevelShouldActivate:CHBGameLevelSecond]) {
        CHBIntroViewController *vc = [CHBIntroViewController new];
        vc.level = CHBGameLevelSecond;
        vc.multiplePlayers = self.multiplePlayers;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)thirdLevelViewDidTap:(id)sender {
    [CHBTracker createEventWithCategory:@"ThirdLevelButton" action:@"Tap"];
    if ([[CHBPerformanceHelper sharedHelper] gameLevelShouldActivate:CHBGameLevelThird]) {
        CHBIntroViewController *vc = [CHBIntroViewController new];
        vc.level = CHBGameLevelThird;
        vc.multiplePlayers = self.multiplePlayers;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
