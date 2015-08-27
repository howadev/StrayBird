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
    self.firstLevelView.levelMode = CHBMapLevelViewLevelModeFirst;
    self.firstLevelView.starMode = CHBMapLevelViewStarModeThree;
    
    [self.view addSubview:self.firstLevelView];
    [self.view pinItemCenterHorizontally:self.view to:self.firstLevelView];
    [self.view pinItemCenterVertically:self.view to:self.firstLevelView];
}

@end
