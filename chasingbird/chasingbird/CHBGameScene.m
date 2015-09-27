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

static const CGFloat minimumBirdSpeed = 0.5;

@interface CHBGameScene ()
@property (nonatomic, assign) NSTimeInterval lastUpdateTime;
@property (nonatomic, assign) NSTimeInterval dt;

@property (nonatomic, retain) NSTimer *touchTimer;
@property (nonatomic, assign) CGFloat birdSpeed;

@property (nonatomic, retain) SKNode *backgroundLayer;

@property (nonatomic, retain) SKNode *rockLayer;
@property (nonatomic, assign) CGFloat populateRockSpeed;

@property (nonatomic, retain) SKNode *atmosphereLayer;

@property (nonatomic, retain) SKNode *cloudLayer;

@property (nonatomic, retain) SKNode *birdLayer;
@property (nonatomic, retain) SKSpriteNode *birdNode;
@property (nonatomic, retain) SKAction *birdAnimation;
@property (nonatomic, retain) CHBBirdInfoNode *infoNode;

@property (nonatomic, retain) SKNode *flockLayer;

@property (nonatomic, retain) SKNode *hudLayer;
@end

@implementation CHBGameScene

#pragma mark - initialize

- (instancetype)initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.lastUpdateTime = 0;
    self.dt = 0;
    self.populateRockSpeed = 0.0001;
    
    [self setupLayer];
    [self setupBackgroundNode];
    //[self setupAtmosphereLayer];
    [self setupCloudLayer];
    [self setupBirdNode];
}

- (void)setupLayer {
    self.backgroundLayer = [SKNode new];
    self.backgroundLayer.zPosition = -1;
    [self addChild:self.backgroundLayer];
    
    self.atmosphereLayer = [SKNode new];
    self.atmosphereLayer.zPosition = 70;
    [self addChild:self.atmosphereLayer];
    
    self.cloudLayer = [SKNode new];
    self.cloudLayer.zPosition = 80;
    [self addChild:self.cloudLayer];
    
    self.birdLayer = [SKNode new];
    self.birdLayer.zPosition = 100;
    [self addChild:self.birdLayer];
}

- (void)setupBackgroundNode {
    SKSpriteNode* backgroundSprite = [[SKSpriteNode alloc] initWithImageNamed:@"level1_layer1_ocean"];
    backgroundSprite.position = CGPointMake(self.size.width/2, self.size.height/2);
    [self.backgroundLayer addChild:backgroundSprite];
    
    [backgroundSprite runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction moveByX:0 y:-self.size.height duration:2.0],
                                                                                   [SKAction moveByX:0 y:self.size.height*2 duration:0],
                                                                                   [SKAction moveByX:0 y:-self.size.height duration:2.0],
                                                                                   ]]]];
    
    SKSpriteNode* backgroundSprite2 = [[SKSpriteNode alloc] initWithImageNamed:@"level1_layer1_ocean"];
    backgroundSprite2.yScale = -1;
    backgroundSprite2.position = CGPointMake(self.size.width/2, self.size.height*1.5);
    [self.backgroundLayer addChild:backgroundSprite2];
    
    [backgroundSprite2 runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction moveByX:0 y:-self.size.height duration:2.0],
                                                                                    [SKAction moveByX:0 y:-self.size.height duration:2.0],
                                                                                    [SKAction moveByX:0 y:self.size.height*2 duration:0],
                                                                                    ]]]];
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction runBlock:^{[self populateRock];}],
                                                                       [SKAction waitForDuration:1.5]]]]];
}

- (void)populateRock {
    static NSMutableArray *textures = nil;
    if (textures == nil) {
        textures = [@[] mutableCopy];
        for (int i = 1; i <= 5; i++) {
            NSString *imageName = [NSString stringWithFormat:@"level1_layer2_rock%d", i];
            SKTexture *texture = [SKTexture textureWithImageNamed:imageName];
            [textures addObject:texture];
        }
    }
    
    SKSpriteNode *rockNode = [[SKSpriteNode alloc] initWithTexture:textures[arc4random()%5]];
    rockNode.position = CGPointMake([CHBHelpers randomWithMin:0 max:self.size.width], self.size.height+rockNode.size.height/2);
    [rockNode runAction:[SKAction sequence:@[[SKAction moveByX:0 y:-self.size.height-rockNode.size.height/2 duration:2.0],
                                             [SKAction removeFromParent]]]];
    [self.backgroundLayer addChild:rockNode];
}

- (void)setupAtmosphereLayer {
    SKSpriteNode* atmosphereSprite = [[SKSpriteNode alloc] initWithImageNamed:@"level1-2_layer3_atmosphere"];
    atmosphereSprite.position = CGPointMake(self.size.width/2, self.size.height/2);
    [self.backgroundLayer addChild:atmosphereSprite];
}

- (void)setupCloudLayer {
    
    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction runBlock:^{[self populateCloud];}],
                                                                       [SKAction waitForDuration:1.5]]]]];
}

- (void)populateCloud {
    NSString *imageName = [NSString stringWithFormat:@"level1-2_layer6_cloud%d", (arc4random()%3+1)];
    SKSpriteNode *node = [[SKSpriteNode alloc] initWithImageNamed:imageName];
    node.position = CGPointMake(-node.size.width/2, [CHBHelpers randomWithMin:0 max:self.size.height]);
    [self.cloudLayer addChild:node];
    
    SKAction *moveAction = [SKAction moveByX:self.size.width+node.size.width y:0 duration:5];
    SKAction *cloudAction = [SKAction repeatActionForever:[SKAction sequence:@[moveAction, [SKAction removeFromParent]]]];
    [node runAction:cloudAction];
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

#pragma mark - view Cycle

- (void)didMoveToView:(SKView *)view {
    self.birdSpeed = minimumBirdSpeed;
    self.touchTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(speedDown:) userInfo:nil repeats:YES];
}

#pragma mark - update event

//- (void)update:(NSTimeInterval)currentTime {
//    if (self.lastUpdateTime > 0) {
//        self.dt = currentTime - self.lastUpdateTime;
//    } else {
//        self.dt = 0;
//    }
//    self.lastUpdateTime = currentTime;
//}

#pragma mark - touch event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.birdSpeed = self.birdSpeed + 0.1;
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

@end
