//
//  CHBGameScene.m
//  chasingbird
//
//  Created by Howard on 2015-08-29.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBGameScene.h"

@interface CHBGameScene ()
@property (nonatomic, assign) CGRect playableRect;
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
    
    CGFloat maxAspectRatio = 16.0 / 9.0;
    CGFloat maxAspectRatioWidth = self.size.height / maxAspectRatio;
    self.playableRect = CGRectMake((self.size.width-maxAspectRatioWidth)/2.0, 0, maxAspectRatioWidth, self.size.height);
    
    SKSpriteNode* backgroundSprite = [[SKSpriteNode alloc] initWithImageNamed:@"level1_layer1_ocean"];
    backgroundSprite.size = self.size;
    backgroundSprite.position = CGPointMake(self.size.width/2, self.size.height/2);
    [self addChild:backgroundSprite];
    
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

@end
