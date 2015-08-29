//
//  CHBGameScene.m
//  chasingbird
//
//  Created by Howard on 2015-08-29.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBGameScene.h"

@interface CHBGameScene ()

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
    SKTexture *backgroundTexture = [SKTexture textureWithImageNamed:@"level1_layer1_ocean"];
    backgroundTexture.filteringMode = SKTextureFilteringNearest;
    
    SKAction* moveSprite = [SKAction moveByX:0 y:-backgroundTexture.size.height duration:1.0];
    SKAction* resetSprite = [SKAction moveByX:0 y:backgroundTexture.size.height duration:0];
    SKAction* moveSpriteForever = [SKAction repeatActionForever:[SKAction sequence:@[moveSprite, resetSprite]]];
    
    SKSpriteNode* backgroundSprite = [SKSpriteNode spriteNodeWithTexture:backgroundTexture];
    backgroundSprite.zPosition = -10;
    backgroundSprite.position = self.view.center;
    [backgroundSprite runAction:moveSpriteForever];
    [self addChild:backgroundSprite];
    
    SKSpriteNode* backgroundSprite2 = [SKSpriteNode spriteNodeWithTexture:backgroundTexture];
    backgroundSprite2.yScale = -1.0;
    backgroundSprite2.zPosition = -10;
    backgroundSprite2.position = CGPointMake(self.view.center.x, self.view.center.y+backgroundTexture.size.height);
    [backgroundSprite2 runAction:moveSpriteForever];
    [self addChild:backgroundSprite2];
}

@end
