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
    self.firstLevelView.starMode = CHBMapLevelViewStarModeThree;
    self.firstLevelView.level = CHBGameLevelFirst;
    [self.view addSubview:self.firstLevelView];
    
    self.secondLevelView = [CHBMapLevelView new];
    self.secondLevelView.starMode = CHBMapLevelViewStarModeNone;
    self.secondLevelView.level = CHBGameLevelSecond;
    [self.view addSubview:self.secondLevelView];
    
    self.thirdLevelView = [CHBMapLevelView new];
    self.thirdLevelView.starMode = CHBMapLevelViewStarModeInactive;
    self.thirdLevelView.level = CHBGameLevelThird;
    [self.view addSubview:self.thirdLevelView];
    
    [self.firstLevelView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firstLevelViewDidTap:)]];
    [self.secondLevelView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(secondLevelViewDidTap:)]];
    [self.thirdLevelView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thirdLevelViewDidTap:)]];
    
    [self setupConstraints];
    
    [self setupBackButton];
}

- (void)setupConstraints {
    [self.view pinItem:self.view attribute:NSLayoutAttributeRight to:self.firstLevelView withOffset:30.0 andScale:1.0];
    [self.view pinItem:self.view attribute:NSLayoutAttributeBottom to:self.firstLevelView withOffset:80.0 andScale:1.0];
    [self.view setSizeConstraintsForItem:self.firstLevelView size:CGSizeMake(80, 80)];
    
    [self.view pinItem:self.view attribute:NSLayoutAttributeLeft to:self.secondLevelView withOffset:-70.0 andScale:1.0];
    [self.view pinItemCenterVertically:self.view to:self.secondLevelView];
    [self.view setSizeConstraintsForItem:self.secondLevelView size:CGSizeMake(80, 80)];
    
    [self.view pinItem:self.view attribute:NSLayoutAttributeRight to:self.thirdLevelView withOffset:80.0 andScale:1.0];
    [self.view pinItem:self.view attribute:NSLayoutAttributeTop to:self.thirdLevelView withOffset:-140.0 andScale:1.0];
    [self.view setSizeConstraintsForItem:self.thirdLevelView size:CGSizeMake(80, 80)];
}

#pragma mark - UI Actions

- (void)firstLevelViewDidTap:(id)sender {
    CHBIntroViewController *vc = [CHBIntroViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)secondLevelViewDidTap:(id)sender {
    
}

- (void)thirdLevelViewDidTap:(id)sender {
    
}

@end
