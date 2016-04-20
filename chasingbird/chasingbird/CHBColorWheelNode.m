//
//  CHBColorWheelNode.m
//  StrayBird
//
//  Created by Rock Lee on 2016-04-19.
//  Copyright © 2016 howalee. All rights reserved.
//

#import "CHBColorWheelNode.h"

@interface CHBColorWheelNode ()
@property (nonatomic, retain) SKSpriteNode *wheelNode;

@property (nonatomic, retain) SKNode *detectedLayer;
@property (nonatomic, retain) SKSpriteNode *birdNode;
@property (nonatomic, retain) SKSpriteNode *flockNode;
@property (nonatomic, retain) SKSpriteNode *checkPointNode;
@end

@implementation CHBColorWheelNode

- (CGSize)size {
    return self.wheelNode.size;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    // Radar background
    self.wheelNode = [[SKSpriteNode alloc] initWithImageNamed:@"color-wheel"];
    [self.wheelNode runAction:[SKAction repeatActionForever:[SKAction sequence:@[[SKAction rotateByAngle:M_PI*2 duration:2.0],
                                                                                 [SKAction waitForDuration:10.0]]]]];
    [self addChild:self.wheelNode];
}
@end


