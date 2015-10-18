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
@import SpriteKit;

@interface CHBGameViewController ()

@end

@implementation CHBGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Configure the view.
    SKView * skView = [[SKView alloc] initWithFrame:self.view.bounds];
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    [self.view addSubview:skView];
    
    // Create and configure the scene.
    CHBGameScene *scene = [CHBGameScene sceneWithSize:self.view.bounds.size];
    scene.level = CHBGameLevelThird;
    scene.scaleMode = SKSceneScaleModeAspectFit;
    
    // Present the scene.
    [skView presentScene:scene];
    
    [self setupPauseButton];
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
    CHBPauseViewController *vc = [CHBPauseViewController new];
    [self presentViewController:vc animated:YES completion:^{
        // pause game scene
    }];
}

@end
