//
//  CHBGameScene.m
//  chasingbird
//
//  Created by Howard on 2015-08-29.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBGameScene.h"
#import "CHBHelpers.h"
#import "CHBBirdInfoNode.h"
#import "CHBLabelNode.h"
@import WatchConnectivity;

static const CGFloat minimumBirdSpeed = 0.5;

@interface CHBGameScene () <WCSessionDelegate>
@property (nonatomic, assign) CGFloat burnCalories;

@property (nonatomic, assign) CGFloat distanceMoved;
@property (nonatomic, assign) CGFloat distanceFromFlockOverall;
@property (nonatomic, assign) CGFloat distanceLeftOverall;

@property (nonatomic, assign) NSTimeInterval lastUpdateTime;
@property (nonatomic, assign) NSTimeInterval dt;

@property (nonatomic, retain) NSTimer *touchTimer;
@property (nonatomic, assign) CGFloat birdSpeed;

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
@property (nonatomic, retain) CHBBirdInfoNode *infoNode;

@property (nonatomic, retain) SKNode *checkPointLayer;
@property (nonatomic, retain) SKAction *checkPointAnimation;

@property (nonatomic, retain) SKNode *hudLayer;
@end

@implementation CHBGameScene

#pragma mark - WCSessionDelegate

- (void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *, id> *)message {
    NSString *heartrate = message[@"heartrate"];
    if (heartrate) {
        CGFloat speed = heartrate.floatValue;
        self.birdSpeed = speed/100;
    }
}

#pragma mark - view Cycle

- (void)didMoveToView:(SKView *)view {
    self.distanceMoved = 0;
    self.lastUpdateTime = 0;
    self.dt = 0;
    self.populateRockSpeed = 0.0001;
    
    [self setupLayer];
    [self setupBackgroundNode];
    //[self setupAtmosphereLayer];
    [self setupCloudLayer];
    [self setupBirdNode];
    
    if ([WCSession isSupported]) {
        WCSession *session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }
    
    self.birdSpeed = minimumBirdSpeed;
    self.touchTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(speedDown:) userInfo:nil repeats:YES];
    
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction runBlock:^{[self populateRock];}],
                                                                       [SKAction waitForDuration:5.0]
                                                                       ]]]];
}

- (void)setupLayer {
    self.backgroundLayer = [SKNode new];
    self.backgroundLayer.zPosition = -1;
    [self addChild:self.backgroundLayer];
    
    self.cloudLayer = [SKNode new];
    self.cloudLayer.zPosition = 80;
    [self addChild:self.cloudLayer];
    
    self.flockLayer = [SKNode new];
    self.flockLayer.zPosition = 95;
    [self addChild:self.flockLayer];
    
    self.birdLayer = [SKNode new];
    self.birdLayer.zPosition = 100;
    [self addChild:self.birdLayer];
    
    self.atmosphereLayer = [SKNode new];
    self.atmosphereLayer.zPosition = 105;
    [self addChild:self.atmosphereLayer];
    
    self.checkPointLayer = [SKNode new];
    self.checkPointLayer.zPosition = 110;
    [self addChild:self.checkPointLayer];
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
    
    for (int i = 0; i < 7; i++) {
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
    self.infoNode = [CHBBirdInfoNode new];
    self.infoNode.position = CGPointMake(0, self.birdNode.position.y);
    [self.birdLayer addChild:self.infoNode];
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
    [checkPointNode runAction:[SKAction group:@[[SKAction sequence:@[[SKAction moveByX:0 y:-self.size.height-checkPointNode.size.height duration:12.0],
                                                                     [SKAction removeFromParent]]],
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
    
    self.distanceMoved += self.backgroundMovePointsPerSec*self.dt;
    
    if (self.distanceMoved > self.distanceFromFlockOverall) {
        if (self.flockAnimation == nil) {
            [self populateFlock];
            self.distanceMoved = self.distanceFromFlockOverall;
            self.infoNode.distanceFromFlockLabel.text = @"0 M";
        }
    } else {
        self.infoNode.distanceFromFlockLabel.text = [NSString stringWithFormat:@"%.2f M", self.distanceFromFlockOverall-self.distanceMoved];
    }
    
    if (self.distanceMoved > self.distanceLeftOverall) {
//        if (self.checkPointAnimation == nil) {
//            [self populateCheckPointLayer];
//            [self.infoNode setHidden:YES];
//        }
    } else {
        self.infoNode.distanceLeftLabel.text = [NSString stringWithFormat:@"%.2f M", self.distanceLeftOverall-self.distanceMoved];
        
        self.burnCalories += 0.01;
        self.infoNode.caloriesLabel.text = [NSString stringWithFormat:@"%.2f KCAL", self.burnCalories];
    }
}

#pragma mark - touch event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.birdSpeed < 3) {
        self.birdSpeed = self.birdSpeed + 0.1;
    }
}

- (void)speedDown:(id)sender {
    if (self.birdSpeed > minimumBirdSpeed) {
        self.birdSpeed = self.birdSpeed - 0.1;
    }
}

- (void)setBirdSpeed:(CGFloat)birdSpeed {
    _birdSpeed = birdSpeed;
    
    self.backgroundLayer.speed = birdSpeed;
    self.infoNode.speedLabel.text = [NSString stringWithFormat:@"%.2f M/S", birdSpeed*100];
}

#pragma mark - game logic

- (CGFloat)distanceFromFlockOverall {
    return 1000;
}

- (CGFloat)distanceLeftOverall {
    return 2000;
}

@end
