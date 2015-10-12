//
//  CHBRadarNode.m
//  chasingbird
//
//  Created by Rock Lee on 2015-10-12.
//  Copyright © 2015 howalee. All rights reserved.
//

#import "CHBRadarNode.h"

@interface CHBRadarNode ()
@property (nonatomic, retain) SKSpriteNode *radarNode;
@property (nonatomic, retain) SKSpriteNode *playerNode;
@property (nonatomic, retain) SKSpriteNode *flockNode;
@end

@implementation CHBRadarNode

- (CGSize)size {
    return self.radarNode.size;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.radarNode = [[SKSpriteNode alloc] initWithImageNamed:@"game_radar"];
    [self addChild:self.radarNode];
    
    self.flockNode = [[SKSpriteNode alloc] initWithImageNamed:@"game_radar_flock"];
    self.flockNode.position = self.radarNode.position;
    [self addChild:self.flockNode];
    
    //    self.hudRadarPlayerNode = [[SKSpriteNode alloc] initWithImageNamed:@"game_radar_player"];
    //    //[self.hudRadarPlayerNode setScale:0.8];
    //    self.hudRadarPlayerNode.position = CGPointMake(self.hudRadarNode.size.width/2 + self.hudRadarPlayerNode.size.width/2, self.hudRadarNode.size.height/2);
    //    self.hudRadarPlayerNode.position = self.hudRadarNode.position;
    //    [self.hudRadarNode addChild:self.hudRadarPlayerNode];
}

@end
