//
//  CHBGameScene.m
//  chasingbird
//
//  Created by Howard on 2015-08-29.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBGameScene.h"
#import "CHBHelpers.h"
#import "CHBNetInfoNode.h"
#import "CHBBirdInfoNode.h"
#import "CHBLabelNode.h"
#import "CHBRadarNode.h"
#import "CHBPerformance.h"
@import WatchConnectivity;

@interface CHBGameScene () <WCSessionDelegate>
@property (nonatomic, retain) CHBPerformance *performance;

@property (nonatomic, assign) NSTimeInterval lastUpdateTime;
@property (nonatomic, assign) NSTimeInterval dt;

@property (nonatomic, retain) NSTimer *touchTimer;

@property (nonatomic, retain) SKNode *backgroundLayer;
@property (nonatomic, assign) CGFloat backgroundMovePointsPerSec;

@property (nonatomic, retain) SKNode *rockLayer;
@property (nonatomic, assign) CGFloat populateRockSpeed;

@property (nonatomic, retain) SKNode *atmosphereLayer;
@property (nonatomic, retain) SKSpriteNode *thunderNode;
@property (nonatomic, retain) SKAction *thunderAnimation;

@property (nonatomic, retain) SKNode *cloudLayer;

@property (nonatomic, retain) SKNode *flockLayer;
@property (nonatomic, retain) SKAction *flockAnimation;

@property (nonatomic, retain) SKNode *birdLayer;
@property (nonatomic, retain) SKSpriteNode *birdNode;
@property (nonatomic, retain) SKAction *birdAnimation;
@property (nonatomic, retain) CHBBirdInfoNode *birdInfoNode;

@property (nonatomic, retain) SKNode *netLayer;
@property (nonatomic, retain) SKSpriteNode *netNode;
@property (nonatomic, retain) SKAction *netDropAnimation;
@property (nonatomic, retain) SKAction *netCollisionAnimation;
@property (nonatomic, retain) SKAction *netBreakAnimation;
@property (nonatomic, assign) CHBNetState currentNetState;

@property (nonatomic, retain) CHBNetInfoNode *netInfoNode;

@property (nonatomic, retain) SKNode *checkPointLayer;
@property (nonatomic, retain) SKAction *checkPointAnimation;

@property (nonatomic, retain) SKNode *hudLayer;
@property (nonatomic, retain) SKSpriteNode *hudDashboardNode;
@property (nonatomic, retain) SKSpriteNode *hudTimerNode;
@property (nonatomic, retain) SKLabelNode *hudTimerLabelNode;
@property (nonatomic, retain) CHBRadarNode *hudRadarNode;
@end

@implementation CHBGameScene {
    NSInteger testNetCount;
}

- (void)dealloc {
    NSLog(@"Game Scene Did Dealloc");
}

#pragma mark - WCSessionDelegate

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message {
    NSString *heartrate = message[@"heartrate"];
    if (heartrate) {
        CGFloat speed = heartrate.floatValue;
        self.performance.birdSpeed = speed;
        self.backgroundMovePointsPerSec = speed;
    }
}

#pragma mark - view Cycle

- (void)didMoveToView:(SKView *)view {
    
    if ([WCSession isSupported]) {
        WCSession *session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
    
    self.lastUpdateTime = 0;
    self.dt = 0;
    self.populateRockSpeed = 0.0001;
    
    self.performance = [CHBPerformance new];
    switch (self.level) {
        case CHBGameLevelFirst:
            self.performance.totalTime = 20 * 60;
            self.performance.totalDistance = 1500;
            self.performance.flockElapsedDistance = 500;
            self.performance.flockSpeed = 60;
            break;
        case CHBGameLevelSecond:
            self.performance.totalTime = 30 * 60;
            self.performance.totalDistance = 2500;
            self.performance.flockElapsedDistance = 800;
            self.performance.flockSpeed = 80;
            break;
        case CHBGameLevelThird:
            self.performance.totalTime = 40 * 60;
            self.performance.totalDistance = 200;
            self.performance.flockElapsedDistance = 800;
            self.performance.flockSpeed = 100;
            break;
    }
    
    
    [self setupLayer];
    [self setupHubLayer];
    [self setupBackgroundNode];
    [self setupCloudLayer];
    [self setupBirdNode];
    
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction runBlock:^{[self populateRock];}],
                                                                       [SKAction waitForDuration:5.0]
                                                                       ]]]];
    
    self.touchTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateEverySecond:) userInfo:nil repeats:YES];
}

- (void)setupLayer {
    self.backgroundLayer = [SKNode new];
    self.backgroundLayer.zPosition = -1;
    [self addChild:self.backgroundLayer];
    
    self.cloudLayer = [SKNode new];
    self.cloudLayer.zPosition = 80;
    [self addChild:self.cloudLayer];
    
    self.birdLayer = [SKNode new];
    self.birdLayer.zPosition = 95;
    [self addChild:self.birdLayer];
    
    self.netLayer = [SKNode new];
    self.netLayer.zPosition = 98;
    [self addChild:self.netLayer];
    
    self.flockLayer = [SKNode new];
    self.flockLayer.zPosition = 100;
    [self addChild:self.flockLayer];
    
    self.atmosphereLayer = [SKNode new];
    self.atmosphereLayer.zPosition = 105;
    [self addChild:self.atmosphereLayer];
    
    self.checkPointLayer = [SKNode new];
    self.checkPointLayer.zPosition = 110;
    [self addChild:self.checkPointLayer];
    
    self.hudLayer = [SKNode new];
    self.hudLayer.zPosition = 150;
    [self addChild:self.hudLayer];
}

- (void)setupHubLayer {
    self.hudDashboardNode = [[SKSpriteNode alloc] initWithImageNamed:@"game_dashboard"];
    self.hudDashboardNode.position = CGPointMake(self.size.width/2, self.hudDashboardNode.size.height/2);
    [self.hudLayer addChild:self.hudDashboardNode];
    
    self.hudTimerNode = [[SKSpriteNode alloc] initWithImageNamed:@"game_timer"];
    self.hudTimerNode.position = CGPointMake(kCHBEdgeInset + self.hudTimerNode.size.width/2, self.hudDashboardNode.size.height);
    [self.hudLayer addChild:self.hudTimerNode];
    
    self.hudTimerLabelNode = [SKLabelNode new];
    self.hudTimerLabelNode.fontName = @"cn_bold";
    self.hudTimerLabelNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    self.hudTimerLabelNode.fontColor = [SKColor blackColor];
    self.hudTimerLabelNode.fontSize = 20.0;
    self.hudTimerLabelNode.position = CGPointMake(self.hudTimerNode.position.x, self.hudTimerNode.position.y-21.0/3*0.8);
    [self.hudLayer addChild:self.hudTimerLabelNode];
    
    self.hudRadarNode = [CHBRadarNode new];
    [self.hudRadarNode setScale:kCHBRadarScale];
    self.hudRadarNode.position = CGPointMake(self.size.width - self.hudRadarNode.size.width/2*kCHBRadarScale, self.hudRadarNode.size.height/2*kCHBRadarScale + kCHBEdgeInset);
    [self.hudLayer addChild:self.hudRadarNode];
}

- (void)setupBackgroundNode {
    self.backgroundMovePointsPerSec = 80.0;
    
    NSString *imageName = nil;
    switch (self.level) {
        case CHBGameLevelFirst:
            imageName = @"level1_layer1_ocean";
            break;
        case CHBGameLevelSecond:
            imageName = @"level2_layer1_ground";
            break;
        case CHBGameLevelThird:
            imageName = @"level3_layer1_ocean";
            break;
        default:
            NSAssert(NO, @"not existed level");
            break;
    }
    SKSpriteNode* backgroundSprite1 = [[SKSpriteNode alloc] initWithImageNamed:imageName];
    //SKSpriteNode *backgroundSprite1 = [SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:self.size];
    backgroundSprite1.name = @"background";
    backgroundSprite1.yScale = -1;
    backgroundSprite1.position = CGPointMake(self.size.width/2, self.size.height/2);
    [self.backgroundLayer addChild:backgroundSprite1];

    SKSpriteNode* backgroundSprite2 = [[SKSpriteNode alloc] initWithImageNamed:imageName];
    //SKSpriteNode *backgroundSprite2 = [SKSpriteNode spriteNodeWithColor:[SKColor greenColor] size:self.size];
    backgroundSprite2.name = @"background";
    backgroundSprite2.position = CGPointMake(self.size.width/2, self.size.height*1.5);
    [self.backgroundLayer addChild:backgroundSprite2];
}

- (void)populateRock {
    static NSMutableArray *textures = nil;
    if (textures == nil) {
        NSString *_imageName = nil;
        switch (self.level) {
            case CHBGameLevelFirst:
                _imageName = @"level1_layer2_rock";
                break;
            case CHBGameLevelSecond:
                _imageName = @"level2_layer2_rock";
                break;
            case CHBGameLevelThird:
                _imageName = @"level3_layer2_rock";
                break;
            default:
                NSAssert(NO, @"not existed level");
                break;
        }
        
        textures = [@[] mutableCopy];
        for (int i = 1; i <= 5; i++) {
            NSString *imageName = [NSString stringWithFormat:@"%@%d", _imageName, i];
            SKTexture *texture = [SKTexture textureWithImageNamed:imageName];
            [textures addObject:texture];
        }
    }
    
    SKSpriteNode *rockNode = [[SKSpriteNode alloc] initWithTexture:textures[arc4random()%5]];
    rockNode.name = @"rock";
    
    CGPoint rockPos = [self convertPoint:CGPointMake([CHBHelpers randomWithMin:0 max:self.size.width], self.size.height+rockNode.size.height/2) toNode:self.backgroundLayer];
    rockNode.position = rockPos;
    
    [self.backgroundLayer addChild:rockNode];
}

- (void)setupAtmosphereLayer {
    SKSpriteNode* atmosphereSprite = [[SKSpriteNode alloc] initWithImageNamed:@"level1-2_layer3_atmosphere"];
    atmosphereSprite.position = CGPointMake(self.size.width/2, self.size.height/2);
    [self.backgroundLayer addChild:atmosphereSprite];
}

- (void)populateThunder {
    NSMutableArray *textures = [@[] mutableCopy];
    for (int i = 1; i <= 3; i++) {
        NSString *imageName = [NSString stringWithFormat:@"sprite_level3_layer3_thunder%d", i];
        SKTexture *texture = [SKTexture textureWithImageNamed:imageName];
        [textures addObject:texture];
    }
    
    self.thunderAnimation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    
    self.thunderNode = [[SKSpriteNode alloc] initWithImageNamed:@"sprite_level3_layer3_thunder1"];
    self.thunderNode.position = CGPointMake(self.size.width/2, self.size.height/2);
    [self.atmosphereLayer addChild:self.thunderNode];
    [self.thunderNode runAction:[SKAction sequence:@[self.thunderAnimation,
                                                     [SKAction waitForDuration:1.0],
                                                     [SKAction removeFromParent]]]];
}

- (void)setupCloudLayer {
    
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction runBlock:^{[self populateCloud];}],
                                                                       [SKAction waitForDuration:1.5]]]]];
}

- (void)populateCloud {
    NSString *_imageName = nil;
    switch (self.level) {
        case CHBGameLevelFirst:
        case CHBGameLevelSecond:
            _imageName = @"level1-2_layer6_cloud";
            break;
        case CHBGameLevelThird:
            _imageName = @"level3_layer6_cloud";
            break;
        default:
            NSAssert(NO, @"not existed level");
            break;
    }
    
    NSString *imageName = [NSString stringWithFormat:@"%@%d", _imageName, (arc4random()%3+1)];
    SKSpriteNode *node = [[SKSpriteNode alloc] initWithImageNamed:imageName];
    node.position = CGPointMake(-node.size.width/2, [CHBHelpers randomWithMin:0 max:self.size.height]);
    [self.cloudLayer addChild:node];
    
    SKAction *moveAction = [SKAction moveByX:self.size.width+node.size.width y:0 duration:5];
    SKAction *cloudAction = [SKAction repeatActionForever:[SKAction sequence:@[moveAction, [SKAction removeFromParent]]]];
    [node runAction:cloudAction];
}

- (void)populateFlock {
    NSMutableArray *textures = [@[] mutableCopy];
    for (int i = 1; i <= 10; i++) {
        NSString *imageName = [NSString stringWithFormat:@"sprite_level1-3_layer4_flock%d", i];
        SKTexture *texture = [SKTexture textureWithImageNamed:imageName];
        [textures addObject:texture];
    }
    
    self.flockAnimation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    
    for (int i = 0; i < 6; i++) {
        SKSpriteNode *birdNode = [[SKSpriteNode alloc] initWithImageNamed:@"sprite_level1-3_layer4_flock1"];
        
        CGFloat gap = (self.size.width - birdNode.size.width*7)/6;
        CGFloat y = 0;
        if (abs(i-3) == 0) {
            y = self.size.height*10/12;
        } else if (abs(i-3) == 1) {
            y = self.size.height*9/12;
        } else if (abs(i-3) == 2) {
            y = self.size.height*8/12;
        } else if (abs(i-3) == 3) {
            y = self.size.height*7/12;
        }
        birdNode.position = CGPointMake(birdNode.size.width/2+gap*i+birdNode.size.width*i, self.size.height+birdNode.size.height/2);
        [self.flockLayer addChild:birdNode];
        if (i%2 == 0) {
            [birdNode runAction:[SKAction sequence:@[[SKAction moveToY:y duration:2],
                                                     [SKAction repeatActionForever:self.flockAnimation]]]];
        } else {
            [birdNode runAction:[SKAction sequence:@[[SKAction moveToY:y duration:2],
                                                     [SKAction repeatActionForever:self.flockAnimation.reversedAction]]]];
        }
    }
}

- (void)setupNetInfoNode {
    self.netInfoNode = [CHBNetInfoNode new];
    self.netInfoNode.position = CGPointMake(self.size.width, self.netNode.position.y);
    [self.netLayer addChild:self.netInfoNode];
}

- (void)setupNetNode {
    NSMutableArray *textures = [@[] mutableCopy];
    for (int i = 1; i <= 2; i++) {
        NSString *imageName = [NSString stringWithFormat:@"sprite_level2_layer5_net%d", i];
        SKTexture *texture = [SKTexture textureWithImageNamed:imageName];
        [textures addObject:texture];
    }
    self.netDropAnimation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    
    textures = [@[] mutableCopy];
    for (int i = 3; i <= 4; i++) {
        NSString *imageName = [NSString stringWithFormat:@"sprite_level2_layer5_net%d", i];
        SKTexture *texture = [SKTexture textureWithImageNamed:imageName];
        [textures addObject:texture];
    }
    self.netCollisionAnimation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    
    textures = [@[] mutableCopy];
    for (int i = 5; i <= 8; i++) {
        NSString *imageName = [NSString stringWithFormat:@"sprite_level2_layer5_net%d", i];
        SKTexture *texture = [SKTexture textureWithImageNamed:imageName];
        [textures addObject:texture];
    }
    self.netBreakAnimation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    
    self.netNode = [[SKSpriteNode alloc] initWithImageNamed:@"sprite_level2_layer5_net1"];
    self.netNode.position = CGPointMake(self.size.width/2, self.size.height+self.netNode.size.height/2);
    [self.netLayer addChild:self.netNode];
    
    [self setupNetInfoNode];
}

- (void)applyNetState:(CHBNetState)state {
    switch (state) {
        case CHBNetStateDrop:
            NSAssert(self.currentNetState == CHBNetStateNone, @"Invalid state transition");
            [self setupNetNode];
            [self.netNode runAction:[SKAction repeatActionForever:self.netDropAnimation]];
            [self.netLayer runAction:[SKAction moveByX:0 y:-(self.size.height - self.birdNode.position.y)-self.netNode.size.height/2 duration:2.0]];
            self.currentNetState = CHBNetStateDrop;
            break;
        case CHBNetStateCollision:
            NSAssert(self.currentNetState == CHBNetStateDrop, @"Invalid state transition");
            [self.netNode removeAllActions];
            [self.netNode runAction:[SKAction repeatActionForever:self.netCollisionAnimation]];
            self.currentNetState = CHBNetStateCollision;
            break;
        case CHBNetStateBreak:
            NSAssert(self.currentNetState == CHBNetStateCollision, @"Invalid state transition");
            [self.netNode removeAllActions];
            [self.netNode runAction:[SKAction sequence:@[self.netBreakAnimation,
                                                         [SKAction removeFromParent]]]];
            [self.netInfoNode removeFromParent];
            self.netLayer.position = CGPointZero;
            self.currentNetState = CHBNetStateBreak;
            break;
        default:
            NSAssert(NO, @"funny state");
            break;
    }
}

- (void)setupBirdNode {
    self.birdNode = [[SKSpriteNode alloc] initWithImageNamed:@"sprite_level1-3_layer4_bird1"];
    self.birdNode.position = CGPointMake(self.size.width/2, self.size.height/4);
    [self.birdLayer addChild:self.birdNode];
    
    NSMutableArray *textures = [@[] mutableCopy];
    for (int i = 1; i <= 10; i++) {
        NSString *imageName = [NSString stringWithFormat:@"sprite_level1-3_layer4_bird%d", i];
        SKTexture *texture = [SKTexture textureWithImageNamed:imageName];
        [textures addObject:texture];
    }
    self.birdAnimation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    [self.birdNode runAction:[SKAction repeatActionForever:self.birdAnimation]];
    
    //CGFloat preferredWidth = self.size.width/2 - self.birdNode.size.width/2;
    self.birdInfoNode = [CHBBirdInfoNode new];
    self.birdInfoNode.position = CGPointMake(kCHBEdgeInset, self.birdNode.position.y + self.birdNode.size.height/2);
    [self.birdLayer addChild:self.birdInfoNode];
}

- (void)populateCheckPointLayer {
    NSMutableArray *textures = [@[] mutableCopy];
    for (int i = 1; i <= 8; i++) {
        NSString *imageName = [NSString stringWithFormat:@"sprite_level1-3_layer5_checkpoint%d", i];
        SKTexture *texture = [SKTexture textureWithImageNamed:imageName];
        [textures addObject:texture];
    }
    
    self.checkPointAnimation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    
    SKSpriteNode *checkPointNode = [[SKSpriteNode alloc] initWithImageNamed:@"sprite_level1-3_layer5_checkpoint1"];
    checkPointNode.position = CGPointMake(self.size.width/2, self.size.height+checkPointNode.size.height/2);
    [self.checkPointLayer addChild:checkPointNode];
    [checkPointNode runAction:[SKAction group:@[[SKAction sequence:@[[SKAction moveByX:0 y:-self.size.height-checkPointNode.size.height duration:2.0],
                                                                     [SKAction removeFromParent],
                                                                     [SKAction runBlock:^{[self stopGame];}]]],
                                                [SKAction repeatActionForever:self.checkPointAnimation]]]];
}


#pragma mark - update event

- (void)update:(NSTimeInterval)currentTime {
    if (self.lastUpdateTime > 0) {
        self.dt = currentTime - self.lastUpdateTime;
    } else {
        self.dt = 0;
    }
    self.lastUpdateTime = currentTime;
    
    // Move background
    CGPoint backgroundVelocity = CGPointMake(0, -self.backgroundMovePointsPerSec);
    CGPoint amountToMove = CGPointMake(backgroundVelocity.x * self.dt, backgroundVelocity.y * self.dt);
    self.backgroundLayer.position = CGPointMake(self.backgroundLayer.position.x + amountToMove.x, self.backgroundLayer.position.y + amountToMove.y);
    
    [self.backgroundLayer enumerateChildNodesWithName:@"background" usingBlock:^(SKNode * _Nonnull node, BOOL * _Nonnull stop) {
        NSAssert([node isKindOfClass:[SKSpriteNode class]], @"Need it");
        SKSpriteNode *background = (SKSpriteNode*)node;
        CGPoint backgroundScreenPos = [self.backgroundLayer convertPoint:background.position toNode:self];
        if (backgroundScreenPos.y <= -self.size.height/2) {
            background.position = CGPointMake(background.size.width/2, background.position.y + self.size.height*2);
        }
    }];
    
    [self.backgroundLayer enumerateChildNodesWithName:@"rock" usingBlock:^(SKNode * _Nonnull node, BOOL * _Nonnull stop) {
        NSAssert([node isKindOfClass:[SKSpriteNode class]], @"Need it");
        SKSpriteNode *rock = (SKSpriteNode*)node;
        CGPoint rockPos = [self.backgroundLayer convertPoint:rock.position toNode:self];
        if (rockPos.y <= -rock.size.height/2) {
            [rock removeFromParent];
        }
    }];
    
    self.performance.birdElapsedDistance += self.performance.birdSpeed * self.dt;
    self.performance.flockElapsedDistance += self.performance.flockSpeed * self.dt;
    
    if (self.performance.birdElapsedDistance > self.performance.flockElapsedDistance) {
        if (self.flockAnimation == nil) {
            [self populateFlock];
            self.birdInfoNode.distanceFromFlockLabel.text = @"0 M";
        }
    } else {
        self.birdInfoNode.distanceFromFlockLabel.text = [NSString stringWithFormat:@"%.2f M", self.performance.flockElapsedDistance-self.performance.birdElapsedDistance];
    }
    
    if (self.performance.birdElapsedDistance > self.performance.totalDistance) {
        if (self.checkPointAnimation == nil) {
            [self populateCheckPointLayer];
            [self.birdInfoNode setHidden:YES];
        }
    } else {
        self.birdInfoNode.distanceLeftLabel.text = [NSString stringWithFormat:@"%.2f M", self.performance.totalDistance-self.performance.birdElapsedDistance];
    }
}

- (void)updateEverySecond:(id)sender {
    
    self.performance.elapsedTime++;
    
    self.birdInfoNode.caloriesLabel.text = [NSString stringWithFormat:@"%.2f KCAL", self.performance.calories];
    self.birdInfoNode.speedLabel.text = [NSString stringWithFormat:@"%.2f M/S", self.performance.birdSpeed];
    
    self.hudTimerLabelNode.text = [NSString stringWithFormat:@"%02ld:%02ld", (NSUInteger)self.performance.leftTime/60, (NSUInteger)self.performance.leftTime%60];
}

#pragma mark - touch event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    testNetCount++;
    
    if (testNetCount == 1) {
        self.currentNetState = CHBNetStateNone;
        [self applyNetState:CHBNetStateDrop];
    } else if (testNetCount == 2) {
        [self applyNetState:CHBNetStateCollision];
    } else if (testNetCount == 3) {
        [self applyNetState:CHBNetStateBreak];
        testNetCount = 0;
    }
}

#pragma mark - Game Action

- (void)stopGame {
    [self.gameDelegate gameScene:self didStopWithPerformance:self.performance];
}


@end
