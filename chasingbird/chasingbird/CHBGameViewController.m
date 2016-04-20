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
#import "AVFoundation/AVAudioPlayer.h"
@import SpriteKit;

@interface CHBGameViewController () <CHBGameSceneDelegate>
@property (nonatomic, retain) CHBGameScene *scene;
@property (nonatomic, retain) SKView * skView;
@property (nonatomic, retain) AVAudioPlayer *player;
@end

@implementation CHBGameViewController

- (void)dealloc {
    NSLog(@"CHBGameViewController Did Dealloc");
}

- (void)setPaused:(BOOL)paused {
    self.skView.paused = paused;
    self.scene.paused = paused;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Configure the view.
    self.skView = [[SKView alloc] initWithFrame:self.view.bounds];
    self.skView.showsFPS = YES;
    self.skView.showsNodeCount = YES;
    [self.view addSubview:self.skView];
    
    // Create and configure the scene.
    self.scene = [CHBGameScene sceneWithSize:self.view.bounds.size];
    self.scene.gameDelegate = self;
    self.scene.level = self.level;
    self.scene.scaleMode = SKSceneScaleModeAspectFit;
    
    // Present the scene.
    [self.skView presentScene:self.scene];
    
    [self setupPauseButton];
    
    self.paused = NO;
    
    NSString *musicName;
    switch (self.level) {
        case CHBGameLevelFirst:
            musicName = @"music_bg_level1";
            break;
        case CHBGameLevelSecond:
            musicName = @"music_bg_level2";
            break;
        case CHBGameLevelThird:
            musicName = @"music_bg_level3";
            break;
    }
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:musicName ofType:@"mp3"]];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [self.player play];
    
    #if TARGET_IPHONE_SIMULATOR
    [self.player stop];
    #endif
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
    vc.performance = self.scene.performance;
    vc.level = self.level;
    vc.multiplePlayers = self.multiplePlayers;
    [self presentViewController:vc animated:YES completion:^{
        // pause game scene
    }];
}

#pragma mark - CHBGameSceneDelegate

- (void)gameScene:(CHBGameScene *)scene didStopWithPerformance:(CHBPerformance *)performance {
    CHBResultViewController *vc = [CHBResultViewController new];
    vc.level = self.level;
    vc.multiplePlayers = self.multiplePlayers;
    vc.performance = scene.performance;
    [self presentViewController:vc animated:YES completion:^{
        // pause game scene
    }];
}

@end
