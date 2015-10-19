//
//  CHBGameViewController.m
//  chasingbird
//
//  Created by Howard on 2015-08-29.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBGameViewController.h"
#import "CHBGameScene.h"
#import "UIView+AutoLayoutHelpers.h"
#import "CHBPauseViewController.h"
#import "CHBResultViewController.h"
@import SpriteKit;

@interface CHBGameViewController () <CHBGameSceneDelegate>
@end

@implementation CHBGameViewController {
    SKView * skView;
    CHBGameScene *scene;
}

- (void)dealloc {
    NSLog(@"CHBGameViewController Did Dealloc");
}

- (void)setPaused:(BOOL)paused {
    skView.paused = paused;
    scene.paused = paused;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Configure the view.
    skView = [[SKView alloc] initWithFrame:self.view.bounds];
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    [self.view addSubview:skView];
    
    // Create and configure the scene.
    scene = [CHBGameScene sceneWithSize:self.view.bounds.size];
    scene.gameDelegate = self;
    scene.level = self.level;
    scene.scaleMode = SKSceneScaleModeAspectFit;
    
    // Present the scene.
    [skView presentScene:scene];
    
    [self setupPauseButton];
    
    self.paused = NO;
}

- (void)setupPauseButton {
    UIImage *pauseIcon = [UIImage imageNamed:@"game_btn_pause"];
    UIButton *pauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pauseButton.translatesAutoresizingMaskIntoConstraints = NO;
    [pauseButton addTarget:self action:@selector(pauseAction:) forControlEvents:UIControlEventTouchUpInside];
    [pauseButton setBackgroundImage:pauseIcon forState:UIControlStateNormal];
    
    [self.view addSubview:pauseButton];
    [self.view pinItem:self.view attribute:NSLayoutAttributeRight to:pauseButton withOffset:16 andScale:1.0];
    [self.view pinItem:self.view attribute:NSLayoutAttributeTop to:pauseButton withOffset:-16 andScale:1.0];
}

- (void)pauseAction:(id)sender {
    self.paused = YES;
    CHBPauseViewController *vc = [CHBPauseViewController new];
    vc.level = self.level;
    [self presentViewController:vc animated:YES completion:^{
        // pause game scene
    }];
}

#pragma mark - CHBGameSceneDelegate

- (void)gameScene:(CHBGameScene *)scene didStopWithPerformance:(CHBPerformance *)performance {
    // copy performance or it will dealloc
    CHBResultViewController *vc = [CHBResultViewController new];
    vc.level = self.level;
    [self presentViewController:vc animated:YES completion:^{
        // pause game scene
    }];
}

@end
