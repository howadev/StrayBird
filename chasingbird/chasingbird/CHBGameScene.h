//
//  CHBGameScene.h
//  chasingbird
//
//  Created by Howard on 2015-08-29.
//  Copyright © 2015 howalee. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "CHBTypes.h"
#import "CHBPerformance.h"

@class CHBGameScene;
@protocol CHBGameSceneDelegate <NSObject>
//- (void)gameScene:(CHBGameScene*)scene didPauseWithPerformance:(CHBPerformance*)performance;
- (void)gameScene:(CHBGameScene*)scene didStopWithPerformance:(CHBPerformance*)performance;
@end

@interface CHBGameScene : SKScene
@property (nonatomic, assign) CHBGameLevel level;
@end
