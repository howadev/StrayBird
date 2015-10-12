//
//  CHBRadarNode.m
//  chasingbird
//
//  Created by Rock Lee on 2015-10-12.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBRadarNode.h"
#import "CHBTypes.h"

@interface CHBRadarNode ()
@property (nonatomic, retain) SKSpriteNode *radarNode;

@property (nonatomic, retain) SKNode *detectedLayer;
@property (nonatomic, retain) SKSpriteNode *birdNode;
@property (nonatomic, retain) SKSpriteNode *flockNode;
@property (nonatomic, retain) SKSpriteNode *checkPointNode;
@end

@implementation CHBRadarNode

- (CGSize)size {
    return self.radarNode.size;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.distanceOverall = 100;
        self.flockDistanceLeft = 80;
        self.birdDistanceLeft = 50;
        [self initialize];
    }
    return self;
}

- (void)initialize {
    // Radar background
    self.radarNode = [[SKSpriteNode alloc] initWithImageNamed:@"game_radar"];
    [self.radarNode runAction:[SKAction repeatActionForever:[SKAction sequence:@[//[SKAction rotateByAngle:M_PI*2 duration:2.0],
                                                                                 //[SKAction waitForDuration:2.0],
                                                                                 [SKAction runBlock:^{[self updateRadar];}]]]]];
    [self addChild:self.radarNode];
    
    // Detected layer
    self.detectedLayer = [SKNode new];
    [self addChild:self.detectedLayer];
    
//    self.flockNode = [[SKSpriteNode alloc] initWithImageNamed:@"game_radar_flock"];
//    self.flockNode.position = self.radarNode.position;
//    [self.detectedLayer addChild:self.flockNode];
//    
//    self.birdNode = [[SKSpriteNode alloc] initWithImageNamed:@"game_radar_player"];
//    self.birdNode.position = self.radarNode.position;
//    [self.detectedLayer addChild:self.birdNode];
    
    self.checkPointNode = [[SKSpriteNode alloc] initWithImageNamed:@"game_radar_checkpoint"];
    self.checkPointNode.position = self.radarNode.position;
    [self.detectedLayer addChild:self.checkPointNode];
    
    [self.checkPointNode runAction:[SKAction rotateByAngle:-M_PI_4 duration:0]];
    [self.detectedLayer runAction:[SKAction rotateByAngle:M_PI_4 duration:0]];
}

- (void)updateRadar {
    CGFloat radarEdge = 32.0;
    CGFloat tmp = (self.flockDistanceLeft / self.distanceOverall) * ((self.size.width - radarEdge) / 2) / sqrt(2);
    self.flockNode.position = CGPointMake(self.radarNode.position.x - tmp, self.radarNode.position.y + tmp);
    
    [self updatePositionWithNode:self.checkPointNode distance:self.distanceOverall];
    [self updatePositionWithNode:self.birdNode distance:self.birdDistanceLeft];
    [self updatePositionWithNode:self.flockNode distance:self.flockDistanceLeft];
}

- (void)updatePositionWithNode:(SKSpriteNode*)node distance:(CGFloat)distance {
    static CGFloat radarEdge = 32.0;
    
    CGFloat tmp = (distance / self.distanceOverall) * self.size.height;
    CGFloat y = self.radarNode.position.y - self.radarNode.size.height/2 + tmp;
    
    if (y > self.radarNode.size.height - radarEdge) {
        y = self.radarNode.size.height - radarEdge;
    } else if (y < self.radarNode.position.y - self.radarNode.size.height/2 + radarEdge) {
        y = self.radarNode.position.y - self.radarNode.size.height/2 + radarEdge;
    }
    
    node.position = CGPointMake(self.radarNode.position.x, y);
}

@end
