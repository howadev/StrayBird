//
//  CHBGameScene.m
//  chasingbird
//
//  Created by Howard on 2015-08-29.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBGameScene.h"

@interface CHBGameScene ()
@property (nonatomic, retain) SKNode *backgroundLayer;
@property (nonatomic, retain) SKNode *hudLayer;

@property (nonatomic, retain) SKNode *birdLayer;
@property (nonatomic, retain) SKSpriteNode *birdNode;
@property (nonatomic, retain) SKAction *birdAnimation;

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
    [self setupBirdNode];
}

- (void)setupLayer {
    self.backgroundLayer = [SKNode new];
    self.backgroundLayer.zPosition = -1;
    [self addChild:self.backgroundLayer];
    
    self.birdLayer = [SKNode new];
    self.birdLayer.zPosition = 1;
    [self addChild:self.birdLayer];
}

- (void)setupBackgroundNode {
    SKSpriteNode* backgroundSprite = [[SKSpriteNode alloc] initWithImageNamed:@"level1_layer1_ocean"];
    backgroundSprite.size = self.size;
    backgroundSprite.position = CGPointMake(self.size.width/2, self.size.height/2);
    [self.backgroundLayer addChild:backgroundSprite];
    
    [backgroundSprite runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction moveByX:0 y:-self.size.height duration:2.0],
                                                                                   [SKAction moveByX:0 y:self.size.height*2 duration:0],
                                                                                   [SKAction moveByX:0 y:-self.size.height duration:2.0],
                                                                                   ]]]];
    
    SKSpriteNode* backgroundSprite2 = [[SKSpriteNode alloc] initWithImageNamed:@"level1_layer1_ocean"];
    backgroundSprite2.yScale = -1;
    backgroundSprite2.size = self.size;
    backgroundSprite2.position = CGPointMake(self.size.width/2, self.size.height*1.5);
    [self addChild:backgroundSprite2];
    
    [backgroundSprite2 runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction moveByX:0 y:-self.size.height duration:2.0],
                                                                                    [SKAction moveByX:0 y:-self.size.height duration:2.0],
                                                                                    [SKAction moveByX:0 y:self.size.height*2 duration:0],
                                                                                    ]]]];
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
    
}

@end
