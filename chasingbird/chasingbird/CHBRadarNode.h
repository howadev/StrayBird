//
//  CHBRadarNode.h
//  chasingbird
//
//  Created by Rock Lee on 2015-10-12.
//  Copyright © 2015 howalee. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface CHBRadarNode : SKNode
@property (nonatomic, readonly) CGSize size;
@property (nonatomic, assign) CGFloat distanceOverall;
@property (nonatomic, assign) CGFloat birdDistanceLeft;
@property (nonatomic, assign) CGFloat flockDistanceLeft;
@end
