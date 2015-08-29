//
//  CHBGameViewController.m
//  chasingbird
//
//  Created by Howard on 2015-08-29.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBGameViewController.h"
#import "CHBGameScene.h"
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
    CHBGameScene *scene = [CHBGameScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

@end
