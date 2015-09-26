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

@interface CHBGameScene ()
@property (nonatomic, retain) SKNode *backgroundLayer;
@property (nonatomic, retain) SKNode *hudLayer;

@property (nonatomic, retain) SKNode *atmosphereLayer;

@property (nonatomic, retain) SKNode *cloudLayer;

@property (nonatomic, retain) SKNode *birdLayer;
@property (nonatomic, retain) SKSpriteNode *birdNode;
@property (nonatomic, retain) SKAction *birdAnimation;
@property (nonatomic, retain) CHBBirdInfoNode *infoNode;

@property (nonatomic, retain) SKNode *flockLayer;
@end

@implementation CHBGameScene

- (instancetype)initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
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
    [self addChild:backgroundSprite2];
    
    [backgroundSprite2 runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction moveByX:0 y:-self.size.height duration:2.0],
                                                                                    [SKAction moveByX:0 y:-self.size.height duration:2.0],
                                                                                    [SKAction moveByX:0 y:self.size.height*2 duration:0],
                                                                                    ]]]];
}

- (void)setupAtmosphereLayer {
    SKSpriteNode* atmosphereSprite = [[SKSpriteNode alloc] initWithImageNamed:@"level1-2_layer3_atmosphere"];
    atmosphereSprite.position = CGPointMake(self.size.width/2, self.size.height/2);
    [self.backgroundLayer addChild:atmosphereSprite];
}

- (void)setupCloudLayer {
    
    SKAction *moveAction = [SKAction moveByX:50 y:0 duration:5];
    SKAction *cloudAction = [SKAction repeatActionForever:[SKAction sequence:@[moveAction, moveAction.reversedAction]]];
    for (int i = 1; i <= 3; i++) {
        NSString *imageName = [NSString stringWithFormat:@"level1-2_layer6_cloud%d", i];
        SKSpriteNode *node = [[SKSpriteNode alloc] initWithImageNamed:imageName];
        node.position = CGPointMake([CHBHelpers randomWithMin:0 max:self.size.width], [CHBHelpers randomWithMin:self.size.height*(i-1)/3 max:self.size.height*i/3]);
        [self.cloudLayer addChild:node];
        [node runAction:cloudAction];
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
    
    CGFloat preferredWidth = self.size.width/2 - self.birdNode.size.width/2;
    self.infoNode = [[CHBBirdInfoNode alloc] initWithPreferredWidth:preferredWidth];
    self.infoNode.position = CGPointMake(preferredWidth/2, self.birdNode.position.y);
    [self.birdLayer addChild:self.infoNode];
}

- (void)_setupInfoNode {
    
}

@end
